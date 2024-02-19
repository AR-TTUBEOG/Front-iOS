//
//  AnnotationButtonView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/3/24.
//

import SwiftUI

struct AnnoButtonView: View {
    var place: ExploreDetailInfor
    @Binding var selectedId: Int?
    @Binding var isSelectedTotal: Bool
//    @Binding var selectedAnno: Anno?
    @State var isSelected: Bool
    @State var id: Int


    var body: some View {

            ZStack {
                if isSelected {
                    backgroundView()
                }
                
                Button {
                    selectedId = id
                    
                    if !isSelectedTotal {
                        isSelectedTotal = true
                    }
                    
                } label: {
                    if place.placeType.spot {
                        Image(.trailMap)
                    } else if place.placeType.store {
                        Image(.restaurantMap)
                    }
                }
                .scaleEffect(isSelected ? 1.5 : 1.0, anchor: .init(x: 0.5, y: 0.86))
            }
        
    }
    
    private struct backgroundView: View {
        
        let gradient = LinearGradient(gradient: Gradient(colors: [.primary03, .white]), startPoint: .bottom, endPoint: .center)
        
        fileprivate var body: some View {
            Circle()
                .trim(from: 0.05, to: 0.45)
                .stroke(gradient, style: .init(lineWidth: 45, lineCap: .round))
                .rotationEffect(.degrees(180))
                .offset(y: -25)
                .frame(width: 100, height: 100)
                .foregroundStyle(gradient)
                .overlay {
                    HStack {
                        Button {
                            print("anno : present")
                        } label: {
                            Image("mapPresent")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .offset(x: -15, y: -52)
                        
                        Button {
                            print("anno : coupon")
                        } label: {
                            Image("mapCoupon")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 20, height: 20)
                        }
                        .offset(y: -74)
                        
                        Button {
                            print("anno : game")
                        } label: {
                            Image("mapGame")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        .offset(x: 15, y: -52)
                    }                    
                }
        }
    }
}


//#Preview {
//    AnnoButtonView(type: .cafe, selectedId: .constant(""), isSelectedTotal: .constant(false), selectedAnno: .constant(.init(latitude: 37.256406, longitude: 127.064556, type: .cafe, image: "mapPlaceExample", isSelected: false)), isSelected: true, id: "")
//}
