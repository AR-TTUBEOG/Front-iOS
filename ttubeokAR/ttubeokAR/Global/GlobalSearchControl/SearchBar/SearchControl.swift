//
//  SearchControl.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/7/24.
//

import SwiftUI
import PopupView


/// 화면의 상단에 사용되는 검색바, 간편 검색 버튼을 갖는다.
struct SearchControl: View {
    // MARK: - Property
    @ObservedObject var viewModel: SearchViewModel
    @State private var isShowingPopup = false
    
    
    // MARK: - Body
    var body: some View {
        ZStack{
            GeometryReader { geometry in
                VStack {
                    searchField
                    bottomButtons
                }
                .offset(y: -10)
                .frame(minWidth: 0, maxWidth: .infinity)
                
                .popup(isPresented: $isShowingPopup) {
                    PlaceSettingView()
                        .clipShape(.rect(cornerRadius: 40))
                } customize: {
                    $0
                        .type(.toast)
                        .position(.bottom)
                        .animation(.spring)
                        .appearFrom(.bottom)
                        .dragToDismiss(true)
                        .closeOnTap(true)
                }
            }
            //TODO: - 구현 필요
            .onTapGesture {
                hideKeyBoard()
            }
        }
    }
    
    // MARK: - Search View
    
    /// 검색필드를 생성한다.
    private var searchField: some View {
        HStack(alignment: .center, spacing: 4) {
            logoImage
            searchTextField
            searchOptionButton
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 2)
    }
    
    /// 간편검색 버튼으로써 터치를 하여 빠른 검색필터를 갖는다.
    private var bottomButtons: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 4) {
                    ForEach(viewModel.buttons.indices, id: \.self) { index in
                        Button(action: {
                            viewModel.buttonSelection(at: index)
                            viewModel.buttons[index].action()
                        }) {
                            HStack {
                                if !viewModel.buttons[index].buttonImage.isEmpty {
                                    Image(viewModel.buttons[index].buttonImage)
                                        .fixedSize()
                                }
                                Text(viewModel.buttons[index].title)
                                    .font(.sandol(type: .regular, size: 12))
                                    .foregroundColor(Color.white)
                            }
                            .frame(width: geometry.size.width > 500 ? 71 : geometry.size.width / 5, height: 32)
                            .background(viewModel.selectedButtonIndex == index ? Color(red: 0.52, green: 0.54, blue: 0.92) : Color(red: 0.16, green: 0.16, blue: 0.23))
                            .cornerRadius(16)
                        }
                    }
                }
                .padding(.horizontal, 16)
            }
            .frame(width: geometry.size.width)
        }
        .frame(maxWidth: .infinity)
    }
    
    /// 간편 검색 버튼에 사용하느 로고 이미지(맵뷰에서 사용된다)
    private var logoImage: some View {
        ZStack {
            viewModel.logoImage
                .resizable()
                .frame(width: viewModel.imageSize.width, height: viewModel.imageSize.height)
        }
    }
    
    /// 검색 필드를 생성하여 검색할 수 있도록 한다.
    private var searchTextField: some View {
        HStack {
            Image("search")
                .resizable()
                .frame(width: 24, height: 24)
                .padding(8)
            TextField("", text: $viewModel.searchText
                      ,prompt: Text("길 검색하기")
                .foregroundStyle(Color(red: 0.52, green: 0.53, blue: 0.6))
                .font(.sandol(type: .regular, size: 14)))
            .font(.sandol(type: .regular, size: 14))
            .background((Color(red: 0.16, green: 0.16, blue: 0.23)))
            .foregroundStyle(Color(red: 0.52, green: 0.53, blue: 0.6))
            .frame(minWidth: 0, maxWidth: 239)
            .onSubmit {
                print(viewModel.getTextFieldValue())
            }
            
            if !viewModel.searchText.isEmpty {
                Button(action: {
                    viewModel.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .padding(5)
                }
            }
        }
        .background(Color(red: 0.16, green: 0.16, blue: 0.23))
        .clipShape(.rect(cornerRadius: 12))
        .padding(8)
    }
    
    /// 검색 옵션을 설정하기 위해 검색 옵션을 설정한다.
    private var searchOptionButton: some View {
        Button(action: {
            isShowingPopup = true
        }) {
            ZStack {
                Rectangle()
                    .frame(width: 40, height: 40)
                    .foregroundColor(Color(red: 0.16, green: 0.16, blue: 0.23))
                    .clipShape(.rect(cornerRadius: 12))
                Image("option")
                    .resizable()
                    .frame(width: 18.33, height: 14.67)
            }
        }
    }
}

// MARK: - Preview

struct SearchControl_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of SearchViewModel
        let viewModel = SearchViewModel()
        
        // Pass the viewModel to the test1 view
        SearchControl(viewModel: viewModel)
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyBoard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
