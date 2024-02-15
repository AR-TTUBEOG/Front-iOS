//
//  EditorView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/1/24.
//

import SwiftUI

struct EditorView: View {
    
    
    @EnvironmentObject private var placeListViewModel: PlaceListViewModel
    @StateObject var placeViewModel: PlaceViewModel
    @State var type: Bool = true
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                NavigationBar(isDisplayLeadingBtn: true, isDisplayTrailingBtn: true)
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("산책스팟 이름")
                                .font(.sandol(type: .bold, size: 20))
                            Spacer()
                        }
                        TitleView(placeViewModel: placeViewModel)
                        
                        HStack {
                            Text("주소")
                                .font(.sandol(type: .bold, size: 20))
                            Spacer()
                        }
                        
                        AddressView(placeViewModel: placeViewModel)
                        
                        HStack {
                            Text("배경 사진")
                                .font(.sandol(type: .bold, size: 20))
                            Spacer()
                        }
                        
                        HStack {
                            Text("산책스팟 소개")
                                .font(.sandol(type: .bold, size: 20))
                            Spacer()
                        }
                        detailView(placeViewModel: placeViewModel)
                        
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal, 16)
                }
            }
        }
    }
    
    private struct TitleView: View {
        
        @ObservedObject private var placeViewModel: PlaceViewModel
        @State var title: String
        
        init(placeViewModel: PlaceViewModel) {
            self.placeViewModel = placeViewModel
            self.title = placeViewModel.place.information.name
        }
    
        fileprivate var body: some View {
            
            RoundedRectangle(cornerRadius: 24)
            
                .fill(.primary01).opacity(0.3)
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .strokeBorder(Color.primary01, lineWidth: 2)
                }
                .frame(height: 45)
                .overlay {
                    TextField(
                        "현재 닉네임",
                        text: $title,
                        prompt: Text("이름을 입력하세요").foregroundStyle(.white)
                    )
                    .padding(.leading, 20)
                }
        }
    }
    
    private struct AddressView: View {
        
        @ObservedObject private var placeViewModel: PlaceViewModel
        @State var title: String
        
        init(placeViewModel: PlaceViewModel) {
            self.placeViewModel = placeViewModel
            self.title = placeViewModel.place.information.detailAddress
        }
        
        fileprivate var body: some View {
            
            VStack {
                HStack {
                    RoundedRectangle(cornerRadius: 24)
                    
                        .fill(.primary01).opacity(0.3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .strokeBorder(Color.primary01, lineWidth: 2)
                        }
                        .frame(height: 45)
                        .overlay {
                            TextField(
                                "현재 닉네임",
                                text: $title,
                                prompt: Text("이름을 입력하세요").foregroundStyle(.white)
                            )
                            .padding(.leading, 20)
                        }
                    
                    Button {
                        
                    } label: {
                        Image(.chevronRight)
                    }
                }
                
                RoundedRectangle(cornerRadius: 24)
                
                    .fill(.primary01).opacity(0.3)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(Color.primary01, lineWidth: 2)
                    }
                    .frame(height: 45)
                    .overlay {
                        
                    }
            }
        }
    }
    
    private struct detailView: View {
        
        @ObservedObject private var placeViewModel: PlaceViewModel
        @State var info: String
        
        init(placeViewModel: PlaceViewModel) {
            self.placeViewModel = placeViewModel
            self.info = placeViewModel.place.information.info
        }
    
        fileprivate var body: some View {
            
            ZStack {
                
                
                
                RoundedRectangle(cornerRadius: 24)
                
                    .fill(.primary01).opacity(0.3)
                    .overlay {
                        RoundedRectangle(cornerRadius: 24)
                            .strokeBorder(Color.primary01, lineWidth: 2)
                    }
                    .frame(height: 200)
                VStack {
                    TextField(
                        "현재 닉네임",
                        text: $info,
                        prompt: Text("산책스팟의 특징과 강점을 간단히 소개해주세요.").foregroundStyle(.white.opacity(0.5))
                    )
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    EditorView(
        placeViewModel: PlaceViewModel(
            place: .init(check: true, information: .init(id: 1, dongAreaID: 1, detailAddress: "경기도 수원시 영통구 매영로 333번길 12", name: "우하항", info: "음식이 친절하고 사장님이 맛있어요.", latitude: 37.245477, longtitude: 127.060852, image: [""], stars: 3.3)
            )
        )
    )
}
