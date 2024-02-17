//
//  BaseImage.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/17/24.
//

import Foundation
import UIKit

class ImageBase64Converter {

    /// 이미지를 Base64 문자열로 인코딩
    /// - Parameter img: 인코딩할 UIImage 객체입니다
    /// - Returns: Base64 인코딩된 문자열을 반환
    public func imageToBase64String(img: UIImage) -> String? {
        guard let imageData = img.jpegData(compressionQuality: 1.0) ?? img.pngData() else {
            return nil
        }
        
        return imageData.base64EncodedString()
    }

    /// Base64 문자열을 UIImage 객체로 디코딩
    /// - Parameter base64String: 디코딩할 Base64 인코딩
    /// - Returns: UIImage 객체를 반환합니다. 디코딩에 실패하면 nil을 반환
    public func base64StringToUIImage(base64String: String) -> UIImage? {
        guard let imageData = Data(base64Encoded: base64String) else {
            return nil
        }
        
        return UIImage(data: imageData)
    }
}
