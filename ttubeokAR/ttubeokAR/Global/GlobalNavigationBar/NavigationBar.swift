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
    
    let leadingItems: [(Icon, () -> Void)]
    let trailingItems: [(Icon, () -> Void)]
    
    init(
        isDisplayLeadingBtn: Bool = true,
        isDisplayTrailingBtn: Bool = false,
        title: String = "",
        fontSize: CGFloat = 16,
        fontType: Font.Sandol = .bold,
        leadingItems: [(Icon, () -> Void)] = [(.chevronLeft, {})],
        trailingItems: [(Icon, () -> Void)] = [(.chevronLeft, {}), (.chevronLeft, {})]
    ) {
        self.isDisplayLeadingBtn = isDisplayLeadingBtn
        self.isDisplayTrailingBtn = isDisplayTrailingBtn
        self.title = title
        self.fontSize = fontSize
        self.fontType = fontType
        self.leadingItems = leadingItems
        self.trailingItems = trailingItems
    }
    
    var body: some View {
        HStack(spacing: 0) {
            if isDisplayLeadingBtn {
                ForEach(leadingItems, id: \.0, content: { item in
                    Button(
                        action: {
                            item.1()
                        },
                        label: {
                            item.0.image
                                .imageScale(.large)
                                .frame(maxWidth: 11, maxHeight: 18)
                        }
                    )
                })
            }
            
            Spacer()
            
            Text(title)
                .font(.sandol(type: fontType, size: fontSize))
                .foregroundStyle(Color.textPink)
            
            Spacer()
            
            if isDisplayTrailingBtn {
                ForEach(trailingItems, id: \.0, content: { item in
                    Button(
                        action: {
                            item.1()
                        },
                        label: {
                            item.0.image
                        }
                    )
                    .padding(.leading, 18)
                })
            }
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
        NavigationBar()
            .previewLayout(.sizeThatFits)
    }
}
