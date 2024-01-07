//
//  SearchControl.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/7/24.
//

import SwiftUI


struct SearchControl: View {
    // MARK: - Property
    @Binding var text: String // 텍스트 필드 입력 데이터
    
    
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
                    }// LogoRectangle
                    
                    HStack{
                        Image("search")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(8)
                        TextField("길 검색하기", text: $text)
                            .font(.system(size: 14))
                            .foregroundStyle(Color(red: 0.52, green: 0.53,  blue: 0.6))
                            .frame(width: 239, height: 40)
                        
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                            }){
                                Image(systemName: "xmark.circle.fill")
                            }
                        } else {
                            EmptyView()
                        }
                    } // SearchTextField
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
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 2)
                .frame(width: 375, height: 44, alignment: .center)
            }
        }
    }
    
    // MARK: - TODO
    struct SearchControl_Previews: PreviewProvider {
        @State static var searchText = ""
        
        static var previews: some View {
            SearchControl(text: $searchText)
        }
    }
}
