//
//  ImageSelectionButton.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/5/24.
//

import SwiftUI

struct ImageSelectionButton<ViewModel: ObservableObject & ImageHandling>: View {
    
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        choiceImageView
    }
    
    /// 이미지 추가 버튼
    private var addImageButton: some View {
        ZStack(alignment: .center) {
            RoundedRectangle(cornerRadius: 19)
                .foregroundStyle(Color.clear)
                .frame(width: 80, height: 80)
                .background(Color.textPink)
                .overlay(
                    RoundedRectangle(cornerRadius: 19)
                        .inset(by: 0/75)
                        .stroke(Color.primary04, lineWidth: 1.5)
                )
            VStack(alignment: .center, spacing: 8)
            {
                Icon.camera.image
                    .resizable()
                    .frame(width: 42, height: 31)
                Text("\(viewModel.selectedImageCount) / 10")
                    .font(.sandol(type: .medium, size: 11))
                    .foregroundStyle(Color.primary03)
                    .frame(width: 28, height: 18, alignment: .center)
            }
            .frame(alignment: .bottom)
            .offset(y: 5)
        }
        .clipShape(.rect(cornerRadius: 19))
    }
    
    /// 선택한 사진 보기
    private var showImages: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 13) {
                ForEach(0..<viewModel.getImages().count, id: \.self) { index in
                    imageAddAndRemove(for: index, image: viewModel.getImages()[index])
                }
            }
        }
    }
    
    @ViewBuilder
    /// 이미지와 이미지 위 삭제 버튼 동시 생성
    /// - Parameters:
    ///   - index: 인덱스에 해당하는 이미지 생성하기
    ///   - image: 인데스에 해당하는 이미지
    /// - Returns: 사진과 버튼
    private func imageAddAndRemove(for index: Int, image: UIImage) -> some View {
        ZStack(alignment: .topTrailing){
            Image(uiImage: image)
                .resizable()
                .frame(width: 80, height: 80)
                .clipShape(.rect(cornerRadius: 19))
            
            Button(action: {
                viewModel.removeImage(at: index)
            }) {
                Icon.xButton.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 22, height: 22)
                    .padding([.horizontal, .vertical], -3)
            }
        }
        .frame(maxWidth: 95, maxHeight: 95)
    }
    
    /// 이미지 추가 버튼 및 추가한 이미지 뷰
    private var choiceImageView: some View {
        HStack(spacing: 13) {
            Button(action: {
                viewModel.showImagePicker()
            }) {
                addImageButton
            }
            .sheet(isPresented: $viewModel.isImagePickerPresented) {
                PlaceRegistImagePicker(imageHandler: viewModel)
                    .ignoresSafeArea(.all)
            }
            showImages
        }
        .frame(width: 330,height: 95)
    }
}
