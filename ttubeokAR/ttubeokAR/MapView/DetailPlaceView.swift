//
//  DetailPlaceView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI
import PopupView
import MapKit

struct DetailPlaceView: View {
    // 지점에 대한 경로들
    @StateObject var detailViewModel: DetailViewModel
    @StateObject var roadViewModel: RoadViewModel
    
    @State var id: Int
    @Binding var selectedPlace: ExploreDetailInfor?
    
    @Binding var isSelectedTotal: Bool
    @Binding var isCreateMode: Bool
    @Binding var routes: [CLLocationCoordinate2D]

    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                infoView(detailViewModel: detailViewModel, selectedPlace: selectedPlace ?? .init(placeId: 1, placeType: .init(store: true, spot: false), dongName: "", memberId: 1, name: "", info: "", latitude: 0.0, longitude: 0.0, image: "", stars: 0.0, guestbookCount: 1, likesCount: 1, isFavorited: false, createdAt: "", recommendationScore: 1, distance: 0.0, hasGame: false))
                
                Spacer()
                    .frame(height: 50)
                
                if roadViewModel.responseRoadModel?.information.count == 0 { // 경로가 있다면
//                    routeChooseBtnView(roadListViewModel: roadListViewModel, road: road)
                    Text("경로없음")

                } else {    // 경로가 있다면
                    Text("경로있음")
                }
                
                Spacer()
                    .frame(height: 28)
                
                walkBtnView(isCreateMode: $isCreateMode, isSelectedTotal: $isSelectedTotal)
            }
        }
        .frame(height: 400)
        .onAppear(perform: {
//            print("디테일뷰 이름"\(selectedPlace?.name)")
            
            self.detailViewModel.fetchDetails(for: selectedPlace ?? .init(placeId: 1, placeType: .init(store: true, spot: false), dongName: "", memberId: 1, name: "", info: "", latitude: 0.0, longitude: 0.0, image: "", stars: 0.0, guestbookCount: 1, likesCount: 1, isFavorited: false, createdAt: "", recommendationScore: 1, distance: 0.0, hasGame: false))
        })
    }
        
    
    private struct infoView: View {
        @State private var detailViewModel: DetailViewModel?
        @State private var selectedPlace: ExploreDetailInfor
        
        
        @State var name: String = ""
        @State var info: String = ""
        @State var stars: Float = 0.0
        @State var distance: String = ""
        
        init(detailViewModel: DetailViewModel, selectedPlace: ExploreDetailInfor) {
            self.detailViewModel = detailViewModel
            self.selectedPlace = selectedPlace
        }
        
        fileprivate var body: some View {
            VStack {
                Image(.mapPlaceExample)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                HStack {
                    VStack(alignment: .leading) {
                        
                        Text(name)
                            .foregroundStyle(.white)
                
                            
                        Text(info)
                            .foregroundStyle(.gray)
                    }
                             
                    Spacer()
                    HStack {
                        Text("\(detailViewModel?.distance ?? 27)")
                        Text("\(detailViewModel?.likeText ?? 0)")
                    }
                    .foregroundStyle(.gray)
                    
                }
                
            }
            .padding(.horizontal, 15)
            .onAppear {
//                self.detailViewModel.fetchDetails(for: selectedPlace)
                
                if selectedPlace.placeType.spot {
                    let infomation = detailViewModel?.walkwayDetailDataModel?.information
                    name = infomation?.name ?? "name 연결안됨"
                    info = infomation?.info ?? "info 연결안됨"
                    stars = infomation?.stars ?? 0.0
//                    distance = infomation?. ?? "distance 연결안됨"
                } else if selectedPlace.placeType.store {
                    let infomation = detailViewModel?.storeDetailDataModel?.information
                    name = infomation?.name ?? "name 연결안됨"
                    info = infomation?.info ?? "info 연결안됨"
                    stars = infomation?.stars ?? 0.0
//                    distance = infomation.distance ?? "distance 연결안됨"
                }
            }
        }
        
    }
    
    private struct routeChooseBtnView: View {
        
//        @Binding var roadListViewModel: RoadListViewModel
        @Binding var road: RoadViewModel

        fileprivate var body: some View {
            HStack {
                Button {
                    
                } label: {
                    Text("<")
                }
                
                Spacer()
                
                Text("스티브의 길")
                    .foregroundStyle(.gray)
                
                Spacer()
                
                Button {
                    
                } label: {
                    Text(">")
                }
            }
            .padding(.horizontal, 20)
        }
    }
    
    private struct walkBtnView: View {
        
        @Binding var isCreateMode: Bool
        @Binding var isSelectedTotal: Bool
        
        fileprivate var body: some View {
            HStack {
                Button {
                    isCreateMode.toggle()
                    
                    if isCreateMode {
                        isSelectedTotal = false
                    }
                    
                } label: {
                    RoundedRectangle(cornerRadius: 19)
                        .frame(height: 40)
                        .overlay {
                            Text("경로 만들기")
                                .foregroundStyle(.textPink)
                        }
                        .foregroundStyle(.primary03)
                }
                
                Button {
    
                } label: {
                    RoundedRectangle(cornerRadius: 19)
                        .frame(height: 40)
                        .overlay {
                            Text("따라 걷기")
                                .foregroundStyle(.textPink)
                        }
                        .foregroundStyle(.primary03)
                }
            }
        }
    }

}

//#Preview {
//    DetailPlaceView(detailViewModel: .init(), roadViewModel: .init(), id: 1, selectedPlace: .init(projectedValue: .constant(.init(placeId: 1, placeType: "cafe", dongName: "", memberId: 1, name: "name", info: "info", latitude: 0.0, longitude: 0.0, image: "", stars: 0.0, guestbookCount: 1, likesCount: 1, isFavorited: false, createdAt: "", recommendationScore: i, distance: 0.0, hasGame: false))), isSelectedTotal: .constant(true), isCreateMode: .constant(false), routes: .constant([CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)])))
//}
