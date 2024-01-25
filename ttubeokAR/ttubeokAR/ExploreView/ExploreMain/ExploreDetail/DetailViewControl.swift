//
//  DetailViewControl.swift
//  ttubeokAR
//
//  Created by 최윤아 on 1/25/24.
//

import SwiftUI

struct DetailViewControl: View {
    private let detailInfoInstance: DetailInfo
    @ObservedObject private var viewModel: DetailView
    private var imageNames: [String]
    
    init(detailInfoInstance: DetailInfo, viewModel: DetailView) {
        self.detailInfoInstance = detailInfoInstance
        self.viewModel = viewModel
        self.imageNames = []
    }
    
    
    var body: some View {
        ZStack(alignment:.top) {
            Color.background.ignoresSafeArea()
            
            VStack {
                SpaceImage
                
                HStack {
                    SpaceName
                    GuestVisitBook
                    GuestBook
                    
                }
                EventImage
                Spaceinfomation
                bookCount
            }
        }
    }
    
    
    private var SpaceImage : some View {
        Image(detailInfoInstance.SampleStoreInfo.image)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: .infinity)
            .frame(height: 252)
            .padding(.top, 0)
        
    }
    
    private var SpaceName : some View {
        Text(detailInfoInstance.SampleStoreInfo.name)
            .foregroundColor(Color.white)
            .padding(.top, 25)
            .padding(.leading, 5)
            .font(.system(size: 18, weight: .bold))
    }
    
    private var GuestVisitBook: some View {
        Rectangle()
            .foregroundColor(Color.white)
            .cornerRadius(19)
            .frame(width: 75, height: 27)
            .onTapGesture {
                viewModel.GuestVisitAction()
            }
            .overlay(
                Text("방문하기")
                    .foregroundColor(Color.gradient03)
                    .font(.system(size: 11, weight: .bold))
            )
            .padding(.top, 25)
            .padding(.leading, 35)
    }
    
    private var GuestBook: some View {
        Rectangle()
            .foregroundColor(Color.chart)
            .cornerRadius(19)
            .frame(width: 75, height: 27)
            .onTapGesture {
                viewModel.GuestBookAction()
            }
            .overlay(
                Text("방명록 작성")
                    .foregroundColor(Color.white)
                    .font(.system(size: 11, weight: .bold))
            )
            .padding(.top, 25)
            .padding(.leading, 0)
    }
    
    private var EventImage: some View {
        HStack(spacing: 10) {
            ForEach(detailInfoInstance.SampleStoreInfo.benefit, id: \.self) { benefitName in
                Image(getImageForBenefit(benefitName))
                    .resizable()
                    .frame(width: 15, height: 17)
            }
        }
        .padding(.leading,-160)
    }

    func getImageForBenefit(_ benefitName: String) -> String {
        switch benefitName {
        case "giftIcon":
            return detailInfoInstance.SampleStoreInfo.benefit.contains(benefitName) ? "giftIcon" : "giftIcon2"
        case "coupon":
            return detailInfoInstance.SampleStoreInfo.benefit.contains(benefitName) ? "coupon" : "coupon2"
        case "Union":
            return detailInfoInstance.SampleStoreInfo.benefit.contains(benefitName) ? "Union" : "Union2"
        default:
            return "defaultImage"
        }
    }
    
    private var Spaceinfomation : some View{
        Text(detailInfoInstance.SampleStoreInfo.info)
            .font(.system(size: 11, weight: .light))
            .foregroundColor(Color.white)
            .padding(.trailing,80)
            .padding(.top,5)
    }
    
    private var bookCount : some View{
        
        HStack {
            Rectangle()
                .foregroundColor(Color.chart)
                .cornerRadius(19)
                .frame(width: 75, height: 27)
            Rectangle()
                .foregroundColor(Color.chart)
                .cornerRadius(19)
                .frame(width: 75, height: 27)
        }
        .padding(.leading,-170)
    }
    
  
}

    
struct DetailViewControl_Previews: PreviewProvider {
    static var previews: some View {
        let detailInfoInstance = DetailInfo()
        let viewModel = DetailView()
        return DetailViewControl(detailInfoInstance: detailInfoInstance, viewModel: viewModel)
            .previewLayout(.sizeThatFits)
    }
}
