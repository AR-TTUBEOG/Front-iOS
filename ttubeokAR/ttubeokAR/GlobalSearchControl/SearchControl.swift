//
//  SearchControl.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/7/24.
//

import SwiftUI


struct SearchControl: View {
    // MARK: - Property
    @ObservedObject var viewModel: SearchViewModel
    
    
    // MARK: - View
    var body: some View {
        ZStack{
            Color(red: 0.09, green: 0.08, blue: 0.12).ignoresSafeArea()
            VStack{
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 12) {
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(red: 0.16, green: 0.16, blue: 0.23))
                            .clipShape(.rect(cornerRadius: 12))
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/)
                            .frame(width: 43, height: 31)
                    }// 뚜벅 로고
                    
                    HStack{
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                        TextField("길 검색하기", text: $viewModel.searchText)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 0.52, green: 0.53,  blue: 0.6))
                            .frame(minWidth: 0, maxWidth: 239)
                        
                        if !viewModel.searchText.isEmpty {
                            Button(action: {
                                self.viewModel.searchText = ""
                            }){
                                Image(systemName: "xmark.circle.fill")
                                    .padding(5)
                            }
                        } else {
                            EmptyView()
                        }
                    } // 검색 필드
                    .background(Color(red: 0.16, green: 0.16, blue: 0.23))
                    .clipShape(.rect(cornerRadius: 12))
                    .padding(8)
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(red: 0.16, green: 0.16, blue: 0.23))
                            .clipShape(.rect(cornerRadius: 12))
                        Image("option")
                            .resizable()
                            .frame(width: 22, height: 22)
                        
                    } // 검색 옵션 버튼
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 2)
                
                //MARK: - TODO
                /*
                 - Note: 지도뷰 / 메인 뷰에 따라 하단 간편 검색 기록의 종류가 바뀌어야 한다. 추후 지도를 제작 후 다시 모델을 수정할 예정!!
                 */
                GeometryReader { geometry in
                    HStack(alignment: .center, spacing: 4) {
                        ForEach(viewModel.buttons.indices, id: \.self) { index in
                            Button(viewModel.buttons[index].title) {
                                viewModel.buttonSelection(at: index)
                                viewModel.buttons[index].action()
                            }
                            .font(.system(size: 12))
                            .frame(width: geometry.size.width > 500 ? 71 : geometry.size.width / 5, height: 32)
                            .background(viewModel.selectedButtonIndex == index ? Color(red: 0.52, green: 0.54, blue: 0.92) : Color(red: 0.16, green: 0.16, blue: 0.23))
                            .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                            .clipShape(.rect(cornerRadius: 16))
                        }
                    }
                    .frame(width: 324, alignment: .topLeading)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 0)
                } // 하단 간편 검색 버튼 생성
            }
        }
    }
}
