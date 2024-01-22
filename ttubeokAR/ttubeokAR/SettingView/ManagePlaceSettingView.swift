//
//  AddStoreSettingView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/20/24.
//

import SwiftUI

struct ManagePlaceSettingView: View {
    
    @StateObject var mpViewModel = ManagePlaceViewModel()
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea(.all)
            
            VStack {
                NavigationBar(isDisplayLeadingBtn: true, title: "등록된 장소 관리")
                ScrollView {
                    placeListView(mpViewModel: mpViewModel)
                }
                Spacer()
            }
        }
    }
    
    private struct placeListView: View {
        
        @ObservedObject var mpViewModel: ManagePlaceViewModel
        
        fileprivate var body: some View {
            VStack {
                // cell
                ForEach(mpViewModel.places, id: \.self) { place in
                    placeCellView(place: place)
                }
            }
        }
    }
    
    private struct placeCellView: View {
        
        private var place: Place
        
        fileprivate init(place: Place) {
            self.place = place
        }
        
        fileprivate var body: some View {
            Button {
                
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 24)
                    
                        .fill(.primary01).opacity(0.3)
                        .overlay {
                            RoundedRectangle(cornerRadius: 24)
                                .strokeBorder(Color.primary01, lineWidth: 2)
                        }
                        .frame(width: 150, height: 150)
                    
                    
                }
                .overlay {
                    VStack(alignment: .leading) {
                        Image("spaceTest")
                        Text(place.title)
                            .foregroundStyle(.white)
                            .font(.sandol(type: .regular, size: 14))
                        Text(place.content)
                            .foregroundStyle(.textPink).opacity(0.5)
                            .font(.sandol(type: .regular, size: 11))
                            .multilineTextAlignment(/*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/)
                    }

                }
            }
            
            
        }
    }
}

#Preview {
    ManagePlaceSettingView()
}
