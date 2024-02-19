//
//  TestMap.swift
//  ttubeokAR
//
//  Created by Subeen on 2/7/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    enum MapType {
        case searchMode
        case createMode
    }
    
//    @StateObject private var routeViewModel = RouteViewModel()
//    @StateObject private var locationManger = LocationManager()
//    @StateObject private var annoViewModel = AnnoViewModel()
    
    /// 검색바
    @StateObject var searchViewModel = SearchViewModel()
    /// 장소 검색
    @StateObject var exploreViewModel: ExploreViewModel
    /// 산책로
    @StateObject var roadViewModel = RoadViewModel()
    /// 상세
    @StateObject var detailViewModel = DetailViewModel()
    
    /// 사용자 현재 위치
    let location = CLLocationCoordinate2D(latitude: BaseLocationManager.shared.currentLocation?.coordinate.latitude ?? 0.0, longitude: BaseLocationManager.shared.currentLocation?.coordinate.longitude ?? 0.0)
    /// 지도 확대 비율
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    @State var isSelectedTotal: Bool = false
    
    /// 최단 경로 coordinates 값 저장
    @State var routes: [CLLocationCoordinate2D] = []
    @State var selectedId: Int? = nil
    @State var selectedPlace: ExploreDetailInfor? = nil
    
    /// 설정 화면
    @State var showSearchOptionButton = false

    
    /// 카메라 구도
    @State var position: MapCameraPosition = .camera(
        MapCamera(
            centerCoordinate: CLLocationCoordinate2D(
                latitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.latitude ?? 0.0,
                longitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.longitude ?? 0.0),
            distance: 980,
            pitch: 60
        )
    )
    
    /// 유저 어노테이션 방향 계산
    @State var heading: Double = 0
    
    /// 장소 등록 모드
    @State var isCreateMode: Bool = false
    @State var newLocations: [CLLocation]?
    
    /// 검색 모드, 추가 모드
    @State var mapType: MapType = .searchMode
    
    /// 사용자의 실시간 흔적 저장
    @State var history: [CLLocationCoordinate2D] = []
    /// 목적지 위도경도
    var dest: CLLocation? = nil
    @State var isTracking: Bool = false
    @State var polyline = MKPolyline()
    @ObservedObject var locationManager = BaseLocationManager.shared
    
    
    var body: some View {
        ZStack {
//            switch mapType {
//            case .searchMode:
                Map(position: $position, bounds: .init(centerCoordinateBounds: .init(center: location, span: span))) {
                    if routes.isEmpty {
                        
                        MapPolyline(coordinates: routes)
                            .stroke(.blue, lineWidth: 2.0)
                    }
                    
                    
                    
                    ForEach(exploreViewModel.exploreData?.information ?? [], id: \.self) { place in
                        Annotation("",
                                   coordinate: .init(latitude: place.latitude ?? 0.0, longitude: place.longitude ?? 0.0),
                                   anchor: .bottom
                        ) {
                            if !isSelectedTotal || selectedId != place.placeId {
                                AnnoButtonView(place: place, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, isSelected: false, id: place.placeId)
                            }
                            
                            if selectedId == place.placeId {
                                AnnoButtonView(place: place, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, isSelected: true, id: place.placeId)
                            }
                        }
                    }
                    
                    UserAnnotation {
                        Image("trailMap")
                    }
                }
                .onMapCameraChange(frequency: .continuous) { context in
                    heading = context.camera.heading
                }
                .customPopup(isPresented: $isSelectedTotal) {
                    DetailPlaceView(detailViewModel: detailViewModel, roadViewModel: roadViewModel, id: selectedId!, selectedPlace: $selectedPlace, isSelectedTotal: $isSelectedTotal, isCreateMode: $isCreateMode, routes: $routes)
                }
                /// 장소, 거리 설정
                .customPopup(isPresented: $showSearchOptionButton) {
                    PlaceSettingView()
                }
                .onAppear(perform: {
                    searchViewModel.currentView = .mapView
                    exploreViewModel.fetchExploreDataAll(page: 0)
                })
                /// 검색창
                if !isSelectedTotal  {
                    searchControl
                }
                
                
//            case .createMode:
//                break;
//                MapPolyline(coordinates: roadViewModel.history ?? [])
//                    .stroke(.blue, lineWidth: 10.0)
                
            
//            }
        }

    }
    
    /// 상단 검색 바(Map, Explore 뷰에 따라 달라진다)
    private var searchControl: some View {
        SearchControl(viewModel: searchViewModel, isShowingPopup: $showSearchOptionButton, exploreViewModel: exploreViewModel)
    }
    

}


    
    func convertToCLLocation(_ routes: [[Double]]?) -> [CLLocationCoordinate2D]? {
        var array: [CLLocationCoordinate2D] = []
        
        if let routes_ = routes {
            for route in routes_ {
                array.append(CLLocationCoordinate2D(latitude: route[1], longitude: route[0]))
                
                print("==================== Location Test =========================")
                print("\(route[1]) , \(route[0])\n")
            }
        } else {
            return nil
        }
        
        return array
    }


//#Preview {
//    MapView(exploreViewModel: ExploreViewModel())
//}
