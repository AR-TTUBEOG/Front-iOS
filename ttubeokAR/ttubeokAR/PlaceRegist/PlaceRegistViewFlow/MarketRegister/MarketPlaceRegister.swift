//
//  MarketPlaceRegister.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI


struct MarketPlaceRegister: View {
    
    //MARK: - ViewModel
    @StateObject private var viewModel = MarketViewModel()
    
    //MARK: - Property
    @Environment(\.dismiss) var dismiss
    @State private var keyboardVisible = false
    
    var lastedSelectedTab: Int
    
    //MARK: - Property
    var body: some View {
        allView
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $viewModel.navigationToNextView) {
                PlaceRegisterFinishView(viewModel: viewModel, lastedSelectedTab: lastedSelectedTab)
            }
            .onAppear {
                observeKeyboard()
            }
            .ignoresSafeArea(.keyboard)
    }
    
    //MARK: - Body
    
    private var allView: some View {
        GeometryReader { geometry in
            ScrollView {
                ZStack(alignment: .center) {
                    backgroundImage
                        .padding(.top, 100)
                    VStack(alignment: .center, spacing: 35) {
                        
                        PlaceRegisterNavigation(currentPage: viewModel.currentPageIndex, totalPages: 7, lastedSelectedTab: lastedSelectedTab)
                        
                        MarketPageContent(viewModel: viewModel)
                            .ignoresSafeArea(.keyboard)
                        
                        Spacer(minLength: 10)
                        
                        if !keyboardVisible {
                            changeViewButton
                                .padding(.bottom, 20)
                        }
                    }
                }
                .frame(height: geometry.size.height)
                
                .onTapGesture {
                    self.keyboardResponsive()
                }
            }
            .scrollIndicators(.hidden)
        }
        .background(Color.background)
    }
    private var backgroundImage: some View {
        Icon.backgroundLogo.image
            .resizable()
            .frame(width: 300, height: 400)
            .aspectRatio(contentMode: .fit)
    }
    
    private var changeViewButton: some View {
        HStack(alignment: .bottom, spacing: 18) {
            Button(action: {
                withAnimation {
                    if viewModel.currentPageIndex > 0 {
                        viewModel.currentPageIndex -= 1
                    }
                    else if viewModel.currentPageIndex == 0 {
                        dismiss()
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
            
            if viewModel.currentPageIndex <= 5 {
                Button(action: {
                    withAnimation {
                        if viewModel.currentPageIndex == 5 {
                            viewModel.navigationToNextView = true
                        } else {
                            viewModel.currentPageIndex += 1
                        }
                    }
                }) {
                    Text(viewModel.currentPageIndex == 6 ? "확인" : "다음")
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
    
    private func observeKeyboard() {
            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillShowNotification,
                object: nil, queue: .main
            ) { _ in
                keyboardVisible = true
            }

            NotificationCenter.default.addObserver(
                forName: UIResponder.keyboardWillHideNotification,
                object: nil, queue: .main
            ) { _ in
                keyboardVisible = false
            }
        }
}

struct MarketPlace_Previews: PreviewProvider {
    static var previews: some View {
        MarketPlaceRegister(lastedSelectedTab: 1)
    }
}
