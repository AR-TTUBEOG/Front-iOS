//
//  ImageHandling.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import Foundation
import SwiftUI

protocol ImageHandling: AnyObject {
    func addImage(_ images: [UIImage])
    func removeImage(at indext: Int)
    func showImagePicker()
    func getImages() -> [UIImage]
    
    var isImagePickerPresented: Bool { get set }
    var selectedImageCount: Int { get }
}
