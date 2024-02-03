//
//  WalkPlaceRegister.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

struct WalkPlaceRegisterView: View {
    
    //MARK: - Property
    @StateObject private var viewModel = WalkwayViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    //MARK: - Body
    var body: some View {
        allView
            .navigationBarBackButtonHidden(true)
    }
    
    private var allView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                Color.black.ignoresSafeArea()
                VStack(alignment: .center, spacing: 35) {
                    PlaceRegisterNavigation(currentPage: viewModel.currentPageIndex, totalPages: 6)
                    WalkwayPageContent(viewModel: viewModel)
                }
                changeViewButton
                    .position(x: geometry.size.width / 2, y: geometry.size.height * 0.93)
            }
        }
    }
    
    //MARK: - WalkPlaceRegisterView
    private var changeViewButton: some View {
        HStack(alignment: .bottom, spacing: 18) {
            Button(action: {
                withAnimation {
                    if viewModel.currentPageIndex > 0 {
                        viewModel.currentPageIndex -= 1
                    }
                    else if viewModel.currentPageIndex == 0 {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }) {
                Text("이전")
                    .font(.sandol(type: .medium, size: 20))
                    .foregroundColor(Color.textPink)
                    .frame(maxWidth: 154, maxHeight: 42)
                    .contentShape(Rectangle())
            }
            .background(Color(red: 0.25, green: 0.24, blue: 0.33))
            .clipShape(RoundedRectangle(cornerRadius: 19))
            .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
            
            if viewModel.currentPageIndex <= 4 {
                Button(action: {
                    withAnimation {
                        if viewModel.currentPageIndex == 5 {
                            viewModel.navigationToNextView = true
                        } else {
                            viewModel.currentPageIndex += 1
                        }
                    }
                }) {
                    Text("다음")
                        .font(.sandol(type: .medium, size: 20))
                        .foregroundColor(Color.textPink)
                        .frame(maxWidth: 154, maxHeight: 39.53)
                        .contentShape(Rectangle())
                }
                .background(Color.primary03)
                .clipShape(RoundedRectangle(cornerRadius: 19))
                .shadow(color: .black.opacity(0.15), radius: 2.5, x: 0, y: 1)
            }
        }
    }
}

struct WalkPlaceRegisterView_Previews: PreviewProvider {
    static var previews: some View { 
        WalkPlaceRegisterView()
    }
}

                
