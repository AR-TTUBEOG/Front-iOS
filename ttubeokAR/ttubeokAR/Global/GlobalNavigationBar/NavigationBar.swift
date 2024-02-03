//
//  NavigationBar.swift
//  ttubeokAR
//
//  Created by Subeen on 1/15/24.
//

import SwiftUI

struct NavigationBar: View {
    let isDisplayLeadingBtn: Bool
    let isDisplayTrailingBtn: Bool
    
    let title: String
    let fontSize: CGFloat
    let fontType: Font.Sandol
    let lastedSelectedTab: Int
    
    
    init(
        isDisplayLeadingBtn: Bool = true,
        isDisplayTrailingBtn: Bool = false,
        title: String = "",
        fontSize: CGFloat = 16,
        fontType: Font.Sandol = .bold,
        lastedSelectedTab: Int = 1
    ) {
        self.isDisplayLeadingBtn = isDisplayLeadingBtn
        self.isDisplayTrailingBtn = isDisplayTrailingBtn
        self.title = title
        self.fontSize = fontSize
        self.fontType = fontType
        self.lastedSelectedTab = lastedSelectedTab
    }
    
    var body: some View {
            
            HStack(spacing: 0) {
                CloseCancelButton(lastedSelectedTab: lastedSelectedTab)
                
                Spacer()
                
                Text(title)
                    .font(.sandol(type: fontType, size: fontSize))
                    .foregroundStyle(Color.textPink)
                
                Spacer()
                
            }
            .padding(.horizontal, 20)
            .frame(height: 44)
    }
}
//
//#Preview(traits: .sizeThatFitsLayout) {
//    NavigationBar()
//        
//}

struct NavigationBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBar(lastedSelectedTab: 1)
            .previewLayout(.sizeThatFits)
    }
}
