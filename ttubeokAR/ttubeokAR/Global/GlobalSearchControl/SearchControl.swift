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
                HStack(alignment: .center, spacing: 12) {
                    
                    ZStack{
                        Rectangle()
                            .frame(width: 40, height: 40)
                            .foregroundStyle(Color(red: 0.16, green: 0.16, blue: 0.23))
                            .clipShape(.rect(cornerRadius: 12))
                        Image("logo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 43, height: 31)
                    }// 뚜벅 로고
                    
                    HStack{
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                        //MARK: - TODO
                        /**
                         - Note : 텍스트필드 내 기본 텍스트 SWiftUI에서 색상 변경 불가
                         */
                        TextField("길 검색하기", text: $viewModel.searchText)
                            .font(.sandol(type: .regular, size: 14))
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
                /**
                 
                 - Note: 지도뷰 / 메인 뷰에 따라 하단 간편 검색 기록의 종류가 바뀌어야 한다. 추후 지도를 제작 후 다시 모델을 수정할 예정!!
                 
                 **/
                GeometryReader { geometry in
                    HStack(alignment: .center, spacing: 4) {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack(alignment: .center, spacing: 4){
                                ForEach(viewModel.buttons.indices, id: \.self) { index in
                                    Button(action: {
                                        viewModel.buttonSelection(at: index)
                                        viewModel.buttons[index].action()
                                    })
                                    {
                                        HStack {
                                            if !viewModel.buttons[index].buttonImage.isEmpty {
                                                Image(viewModel.buttons[index].buttonImage)
                                                    .resizable()
                                                    .frame(width: 20, height: 20)
                                            }
                                            Text(viewModel.buttons[index].title)
                                                .font(.sandol(type: .regular, size: 12))
                                                .foregroundStyle(Color.white)
                                        }
                                        .frame(width: geometry.size.width > 500 ? 71 : geometry.size.width / 5, height: 32)
                                        .background(viewModel.selectedButtonIndex == index ? Color(red: 0.52, green: 0.54, blue: 0.92) : Color(red: 0.16, green: 0.16, blue: 0.23))
                                        .foregroundStyle(Color(red: 0.92, green: 0.9, blue: 0.97))
                                        .clipShape(.rect(cornerRadius: 16))
                                    }
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 0)// 하단 간편 검색 버튼 생성
                        }
                        .frame(width: geometry.size.width)
                    }
                    .frame(width: 60, alignment: .topLeading)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

struct SearchControl_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of SearchViewModel
        let viewModel = SearchViewModel()
        
        // Pass the viewModel to the test1 view
        SearchControl(viewModel: viewModel)
    }
}
