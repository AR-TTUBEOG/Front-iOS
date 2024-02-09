//
//  ImageHandling.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import Foundation
import SwiftUI

protocol BookMarkImgProtocol: AnyObject {
    func setImage(_ images: UIImage)
    func showImagePicker()
    var isImagePickerPresented: Bool { get set }
}
