//
//  WalkPlaceRegister.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/27/24.
//

import SwiftUI

/// 산책로 등록 뷰(단계별로 등록하게되는 뷰 흐름
struct WalkPlaceRegisterView: View {
    
    //MARK: - Property
    @StateObject private var viewModel = WalkwayViewModel()
    @Environment(\.dismiss) var dismiss
    @State private var keyboardVisible = false
    
    var lastedSelectedTab: Int
    
    //MARK: - Body
    var body: some View {
        allView
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $viewModel.navigationToNextView) {
                PlaceRegisterFinishView(viewModel: viewModel, lastedSelectedTab: lastedSelectedTab)
            }
            .onAppear{
                observeKeyboard()
            }
    }
    
    //MARK: - WalkPlaceRegisterView
    
    private var allView: some View {
        VStack(alignment: .center, spacing: 35) {
            
            PlaceRegisterNavigation(currentPage: viewModel.currentPageIndex, totalPages: 5, lastedSelectedTab: lastedSelectedTab)
            WalkwayPageContent(viewModel: viewModel)
            
            Spacer()
            
            if !keyboardVisible {
                changeViewButton
                    .padding(.bottom, 20)
            }
        }
        .background(Color.background.ignoresSafeArea(.all))
        .onTapGesture {
            self.keyboardResponsive()
        }
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
            
            if viewModel.currentPageIndex <= 4 {
                Button(action: {
                    withAnimation {
                        if viewModel.currentPageIndex == 4 {
                            viewModel.navigationToNextView = true
                        } else {
                            viewModel.currentPageIndex += 1
                        }
                    }
                }) {
                    Text(viewModel.currentPageIndex == 4 ? "확인" : "다음")
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

struct WalkPlaceRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        WalkPlaceRegisterView(lastedSelectedTab: 1)
    }
}


