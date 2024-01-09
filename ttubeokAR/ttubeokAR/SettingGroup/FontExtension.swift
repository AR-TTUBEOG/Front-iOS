//
//  FontExtension.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/9/24.
//

import Foundation
import SwiftUI

extension Font {
    enum Sandol {
        case regular
        case thin
        case ultraLight
        case light
        case medium
        case semiBold
        case bold
        
        var value: String {
            switch self {
            case .regular:
                return "AppleSDGothicNeo-Regular"
            case .thin:
                return "AppleSDGothicNeo-Thin"
            case .ultraLight:
                return "AppleSDGothicNeo-UltraLight"
            case .light:
                return "AppleSDGothicNeo-Light"
            case .medium:
                return "AppleSDGothicNeo-Medium"
            case .semiBold:
                return "AppleSDGothicNeo-SemiBold"
            case .bold:
                return "AppleSDGothicNeo-Bold"
            }
        }
    }
    
    /// 폰트타입을 쉽게 사용하기 위함 또한 피그마에 적용된 폰트가 아닌 폰트를 사용하기 위함 기존 맥북에 달린 정식 폰트로 사용
    /// - Parameters:
    ///   - type: 원하는 폰트 열거형 value 값 작성
    ///   - size: 원하는 폰트 사이즈 작성
    /// - Returns: 작성된 값에 맞게 적용됨
    static func sandol( type: Sandol, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
}
/*
 
 AppleSDGothicNeo-Regular
 AppleSDGothicNeo-Thin
 AppleSDGothicNeo-UltraLight
 AppleSDGothicNeo-Light
 AppleSDGothicNeo-Medium
 AppleSDGothicNeo-SemiBold
 AppleSDGothicNeo-Bold
 
 */
