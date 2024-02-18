////
////  TestMap.swift
////  ttubeokAR
////
////  Created by Subeen on 2/7/24.
////
//
//import SwiftUI
//import MapKit
//
//struct TestMapDuplicate: View {
//    
//    @StateObject private var routeViewModel = RouteViewModel()
////    @StateObject private var locationManger = LocationManager()
//    @StateObject private var annoViewModel = AnnoViewModel()
//    
//    /// 검색바
//    @StateObject private var searchViewModel = SearchViewModel()
//    /// 장소 검색
//    @StateObject private var exploreViewModel = ExploreViewModel()
//    /// 산책로
//    @ObservedObject private var roadViewModel = RoadViewModel()
//    
//    /// 사용자 현재 위치
//    let location = CLLocationCoordinate2D(latitude: BaseLocationManager.shared.currentLocation?.coordinate.latitude ?? 0.0, longitude: BaseLocationManager.shared.currentLocation?.coordinate.longitude ?? 0.0)
//    /// 지도 확대 비율
//    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
//    
//    @State private var isSelectedTotal: Bool = false
//    
//    /// 최단 경로 coordinates 값 저장
//    @State private var routes: [CLLocationCoordinate2D] = []
//    @State private var selectedId: Int? = nil
//    @State private var selectedAnno: Anno? = nil
//    
//    @EnvironmentObject var sharedTabInfo: SharedTabInfo
//    
//    @State private var selectedTab: Int
//    
//    /// 설정 화면
//    @State private var showSearchOptionButton = false
//
//    
//    /// 카메라 구도
//    @State private var position: MapCameraPosition = .camera(
//        MapCamera(
//            centerCoordinate: CLLocationCoordinate2D(
//                latitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.latitude ?? 0.0,
//                longitude: BaseLocationManager.shared.getCurrentLocation()?.coordinate.longitude ?? 0.0),
//            distance: 980,
//            pitch: 60
//        )
//    )
//    
//    /// 유저 어노테이션 방향 계산
//    @State private var heading: Double = 0
//    
//    /// 장소 등록 모드
//    @State private var isCreateMode: Bool = false
//    @State private var newLocations: [CLLocation]?
//    
//    
//    /// selectedTab 초기화
//    /// - Parameter selectedTab: 현재 선택된 탭 추적하여 값 전달 -> 뚜닷에 활용하기 위함
//    init(selectedTab: Int = 1) {
//        _selectedTab = State(initialValue: selectedTab)
//    }
//    
//    var body: some View {
//        ZStack {
//            Map(position: $position, bounds: .init(centerCoordinateBounds: .init(center: location, span: span))) {
//                    if routes.isEmpty {
//                        
//                        MapPolyline(coordinates: routes)
//                            .stroke(.blue, lineWidth: 2.0)
//                    }
//                
//                
////                    ForEach(exploreViewModel.exploreData?.information ?? [], id: \.self) { place in
//                    ForEach(annoViewModel.annos, id: \.self) { anno in
//                    Annotation("",
//                               coordinate: .init(latitude: anno.latitude, longitude: anno.longitude),
//                               anchor: .bottom
//                    ) {
//                        if !isSelectedTotal || selectedId != anno.storeId {
//                            AnnoButtonView(type: .cafe, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, selectedAnno: $selectedAnno, isSelected: false, id: anno.storeId)
//                        }
//                        
//                        if selectedId == anno.storeId {
//                            AnnoButtonView(type: .cafe, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, selectedAnno: $selectedAnno, isSelected: true, id: anno.storeId)
//                        }
//                    }
//                }
//                UserAnnotation {
//                    Image("trailMap")
//                }
//            }
//            .onMapCameraChange(frequency: .continuous) { context in
//                heading = context.camera.heading
//            }
//            .customPopup(isPresented: $isSelectedTotal) {
//                DetailPlaceView(anno: $selectedAnno, isSelectedTotal: $isSelectedTotal, isCreateMode: $isCreateMode, road: roadViewModel)
//            }
//            /// 장소, 거리 설정
//            .customPopup(isPresented: $showSearchOptionButton) {
//                PlaceSettingView()
//            }
//            
//            /// 검색창
//            searchControl
//                .onAppear(perform: {
//                    searchViewModel.currentView = .mapView
//                })
//        }
////        .task {
////            routeViewModel.routeResponse(origin_lon: BaseLocationManager.shared.currentLocation?.coordinate.longitude ?? 0.0, origin_lat: BaseLocationManager.shared.currentLocation?.coordinate.latitude ?? 0.0, dest_lon: 127.064556, dest_lat: 37.256406)
////        }
//        }
//    
//    /// 상단 검색 바(Map, Explore 뷰에 따라 달라진다)
//    private var searchControl: some View {
//        SearchControl(viewModel: searchViewModel, isShowingPopup: $showSearchOptionButton, exploreViewModel: exploreViewModel)
//    }
//}
//
//
//    
////    func convertToCLLocation(_ routes: [[Double]]?) -> [CLLocationCoordinate2D]? {
////        var array: [CLLocationCoordinate2D] = []
////        
////        if let routes_ = routes {
////            for route in routes_ {
////                array.append(CLLocationCoordinate2D(latitude: route[1], longitude: route[0]))
////                
////                print("==================== Location Test =========================")
////                print("\(route[1]) , \(route[0])\n")
////            }
////        } else {
////            return nil
////        }
////        
////        return array
////    }
//
//
//#Preview {
//    TestMapDuplicate()
//}
