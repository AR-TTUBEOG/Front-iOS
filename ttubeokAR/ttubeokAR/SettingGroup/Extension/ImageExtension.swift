//
//  ImageExtension.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/18/24.
//

import Foundation
import SwiftUI

extension Image {
    init(base64String: String) {
        if let uiImage = ImageBase64Converter.base64StringToUIImage(base64String: base64String) {
            self.init(uiImage: uiImage)
        } else {
            self.init(systemName: "photo")
        }
    }
}

extension UIImage {
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
