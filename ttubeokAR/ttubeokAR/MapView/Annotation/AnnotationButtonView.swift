//
//  AnnotationButtonView.swift
//  ttubeokAR
//
//  Created by Subeen on 2/3/24.
//

import SwiftUI

struct AnnotationButtonView: View {
    var type: AnnoType
    @Binding var isSelected: Bool
    @State var selectedPlaceId: Bool
    @Binding var id: String
    @Binding var selectedPlace: Anno
    
//    init(type: PlaceType, isSelected: Bool, selectedPlace: Anno) {
//        self.type = type
//        self.isSelected = isSelected
//        self.selectedPlace = selectedPlace
//    }
    
    var body: some View {
        if self.selectedPlace.id.uuidString == self.id {
            ZStack {
                if isSelected {
                    backgroundView()
                }
                Button {
                    
                    
                    if selectedPlace.id.uuidString == self.id {
                        
                        
                        isSelected.toggle()
                        self.selectedPlace.isSelected = isSelected
                        //                    self.selectedPlaceId = isSelected
                        
                        
                        print("self id : \(self.id)")
                        print("self button : \(isSelected)")
                        
                    }
                    
                    //                print("anno tapped")
                    
                    print("id: \(id)")
                    //                if self.id == place.id.uuidString {
                    //                    self.isSelected = place.isSelected
                    //                    print(place.id)
                    //                } else if self.id != place.id.uuidString {
                    //                    self.isSelected = false
                    //                }
                    
                } label: {
                    switch type {
                    case .cafe :
                        Image(.restaurantMap2)
                    case .restaurant:
                        Image(.restaurantMap)
                    case .route:
                        Image(.restaurantMap)
                    }
                    
                }
                .scaleEffect(isSelected ? 1.5 : 1.0, anchor: .init(x: 0.5, y: 0.86))
                .border(Color.gray)
                .onChange(of: self.id) { newValue in
                    self.id = newValue
                }
                .onChange(of: self.isSelected) { newValue in
                    self.isSelected = newValue
                    //                self.isSelected = selectedPlaceId
                }
            }
        }
    }
    
    private struct backgroundView: View {
        
        let gradient = LinearGradient(gradient: Gradient(colors: [Color.primary03, .white]), startPoint: .bottom, endPoint: .center)
        
        fileprivate var body: some View {
            Circle()
                .trim(from: 0.05, to: 0.45)
                .stroke(gradient, style: .init(lineWidth: 45, lineCap: .round))
                .rotationEffect(.degrees(180))
                .offset(y: -25)
                .frame(width: 100, height: 100)
//                .foregroundStyle(gradient)
                .overlay {
                    HStack {
                        Button {
                            print("anno : present")
                        } label: {
                            Image(.present)
                        }
                        .offset(x: -15, y: -52)
                        
                        Button {
                            print("anno : coupon")
                        } label: {
                            Image(.coupon)
                        }
                        .offset(y: -74)
                        
                        Button {
                            print("anno : game")
                        } label: {
                            Image(.game)
                        }
                        .offset(x: 15, y: -52)
                    }
                    
                }
        }
    }
}

//#Preview {
//    AnnotationButtonView(type: .restaurant, isSelected: .constant(false), selectedPlaceId: false, id: .constant(""), selectedPlace: .constant(.init(location: .init(latitude: 37.36639705565353, longitude: 127.10223207837413), color: Color.blue, type: .cafe, isSelected: false)))
//}
