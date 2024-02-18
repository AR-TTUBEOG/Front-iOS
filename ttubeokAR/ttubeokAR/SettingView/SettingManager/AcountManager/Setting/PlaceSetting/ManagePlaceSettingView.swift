//
//  AddStoreSettingView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/20/24.
//

import SwiftUI

struct ManagePlaceSettingView: View {
    
    // MARK: - Property
    @Environment (\.dismiss) var dismiss
    @StateObject var viewModel: PlaceViewModel
    
    var body: some View {
        allView
    }
    
    private var allView: some View {
        ZStack(){
            GeometryReader { geometry in
                Color.background.ignoresSafeArea()
                VStack(spacing : 20){
                    centerView(geometry: geometry)
                        .onAppear{
                            print("---초기호출----")
//                            placeListView(PlaceViewModel:PlaceViewModel)
                        }
                }
                
                
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    
    private func imgBackground(geometry: GeometryProxy) -> some View {
        Icon.EmptyDataImage.image
            .fixedSize()
            .aspectRatio(contentMode: .fit)
            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.32)
    }
    
    
    private var topBar : some View {
        HStack{
            Button(action : {
                dismiss()
            }) {
                Icon.chevronLeft.image
                    .resizable()
                    .frame(maxWidth: 11, maxHeight: 18)
                    .padding(.leading,-110)
            }
            
            Spacer()
                .frame(maxWidth: 10)
            Text("등록된 장소 관리")
                .font(.sandol(type: .bold, size: 25))
                .foregroundStyle(Color.textPink)
        }
    }
    
    //    private var placeType : some View {
    //
    //            Menu {
    //                ForEach(CouponViewModel.FilterType.allCases, id: \.self) { item in
    //                    Button {
    //                        couponViewModel.filterType = item
    //                    } label: {
    //                        Label {
    //                            Text(item.title)
    //                        } icon: {
    //                            if couponViewModel.filterType == item {
    //                                Icon.chevronDown.image
    //                            }
    //                        }
    //                    }
    //                }
    //            } label: {
    //                HStack(spacing: 4) {
    //                    Text(couponViewModel.filterType.title)
    //                    Icon.chevronDown.image
    //                }
    //                .foregroundStyle(.white)
    //                .font(.sandol(type: .regular, size: 13))
    //                .padding(.trailing, 13)
    //
    //            }
    //        }
    //    }
    
    
    private func centerView(geometry: GeometryProxy) -> some View {
        if let information = viewModel.placeData?.information, !information.isEmpty {
            return AnyView(placeListView(geometry: geometry))
        } else {
            return AnyView(imgBackground(geometry: geometry))
        }
    }
    
    
    private func placeListView(geometry: GeometryProxy) -> some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: [GridItem(.flexible(minimum: 150), spacing: -8), GridItem(.flexible(minimum: 150), spacing: 15)], spacing: 25) {
                ForEach(self.viewModel.placeData?.information ?? [], id: \.self) { place in
                    RegisteredPlaceCard(viewModel: PlaceViewModel(), registeredPlaceInfor: place)
                        .frame(minWidth: 0, maxWidth: .infinity)
                    }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        .refreshable {
            print("--------------refresh 호출--------------")
        }
    }
}
    

//#Preview {
//    ManagePlaceSettingView()
//        .environmentObject(PlaceListViewModel())
//}
