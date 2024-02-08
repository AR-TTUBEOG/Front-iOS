//
//  TestMap.swift
//  ttubeokAR
//
//  Created by Subeen on 2/7/24.
//

import SwiftUI
import MapKit

struct TestMap: View {
    
    @StateObject private var routeViewModel = RouteViewModel()
    @StateObject private var locationManger = LocationManager()
    @StateObject private var annoViewModel = AnnoViewModel()
    
    /// 사용자 현재 위치
    let location = CLLocationCoordinate2D(latitude: 37.254611, longitude: 127.065993)
    /// 지도 확대 비율
    let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    
    @State private var isSelectedTotal: Bool = false
    
    /// 최단 경로 coordinates 값 저장
    @State private var routes: [CLLocationCoordinate2D] = []
    @State private var selectedId: String? = nil

                            
//    MapCamearPosition(ce)
    
    var body: some View {
        ZStack {
            Map(bounds: .init(centerCoordinateBounds: .init(center: location, span: span))) {
                    if !routes.isEmpty {
                        MapPolyline(coordinates: routes)
                            .stroke(.blue, lineWidth: 2.0)
                    }
                    ForEach(annoViewModel.annos, id: \.self) { anno in
                    Annotation("",
                               coordinate: .init(latitude: anno.latitude, longitude: anno.longitude),
                               anchor: .bottom
                    ) {
                        if !isSelectedTotal || selectedId != anno.id.uuidString {
                            AnnoButtonView(type: .cafe, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, isSelected: false, id: anno.id.uuidString)
                        }
                        
                        if selectedId == anno.id.uuidString {
                            AnnoButtonView(type: .cafe, selectedId: $selectedId, isSelectedTotal: $isSelectedTotal, isSelected: true, id: anno.id.uuidString)
                        }
                    }
                }
            }
            
            Button {
                routes = convertToCLLocation(routeViewModel.routeModel?.routes.first?.geometry.coordinates) ?? []
                
                print("!")
            } label: {
                Text("Current Loaction")
            }
                    
        }
        .task {
            routeViewModel.routeResponse(origin_lon: 127.06586387017393, origin_lat: 37.2548934785234, dest_lon: 127.064556, dest_lat: 37.256406)
        }
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


#Preview {
    TestMap()
}
