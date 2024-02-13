//
//  DetailPlaceView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/6/24.
//

import SwiftUI
import PopupView

struct DetailPlaceView: View {
    
    @Binding var anno: Anno?
    // 지점에 대한 경로들
    var routes: [String]? = ["스티브", "숩", "으찮"]
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            VStack {
                infoView(selectedAnno: $anno)
                
                Spacer()
                    .frame(height: 50)
                
                if routes != nil { // 경로가 있다면
                    routeChooseBtnView()
                }
                
                Spacer()
                    .frame(height: 28)
                
                walkBtnView()
            }
        }
        .frame(height: 400)
    }
    
    private struct infoView: View {
        
        @Binding var selectedAnno: Anno?
        
//        init(selectedAnno: Anno? = nil) {
//            self.selectedAnno = selectedAnno
//        }
        
        fileprivate var body: some View {
            VStack {
                Image(.mapPlaceExample)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 170)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                HStack {
                    VStack(alignment: .leading) {
                        Text(selectedAnno?.name ?? "이름없음")
                            .foregroundStyle(.white)
                        Text("농구 게임을 통한 할인권 증정")
                            .foregroundStyle(.gray)
                    }
                             
                    Spacer()
                    HStack {
                        Text("1.5kms")
                        Text("4.8")
                    }
                    .foregroundStyle(.gray)
                    
                }
                
            }
            .padding(.horizontal, 15)
        }
        
    }
    
    private struct routeChooseBtnView: View {
        fileprivate var body: some View {
            HStack {
                Text("스티브의 길")
                    .foregroundStyle(.gray)
            }
        }
    }
    
    private struct walkBtnView: View {
        fileprivate var body: some View {
            HStack {
                Button {
    
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

#Preview {
    DetailPlaceView(anno: .constant(.init(storeId: 1, dongareaId: 1, name: "카페", info: "분위기 좋은 카페", latitude: 37.547889, longitude: 126.915158, image: "exampleMarket", type: "cafe")))
}
