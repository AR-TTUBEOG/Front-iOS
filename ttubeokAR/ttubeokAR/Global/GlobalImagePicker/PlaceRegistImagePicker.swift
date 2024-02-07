//
//  WalkwayImagePicker.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/28/24.
//

import SwiftUI
import PhotosUI

/// 갤러리에서 이미지 10장을 고르도록 앨범을 부르기 위한 구조체
struct PlaceRegistImagePicker: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    var imageHandler: ImageHandling
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
        config.selectionLimit = 10
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, imageHandler: imageHandler )
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PlaceRegistImagePicker
        var imageHandler: ImageHandling
        
        init(_ parent: PlaceRegistImagePicker, imageHandler: ImageHandling) {
            self.parent = parent
            self.imageHandler = imageHandler
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            self.parent.dismiss()
            
            for result in results {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                    if let image = object as? UIImage {
                        DispatchQueue.main.async {
                            self.imageHandler.addImage([image])
                        }
                    }
                }
            }
        }
    }
}

