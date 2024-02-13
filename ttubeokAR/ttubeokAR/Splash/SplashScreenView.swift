//
//  SplashScreenView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI
import CoreLocation

struct SplashScreenView: View {
    //MARK: Property
    @State private var isLocationPermission = false
    @State private var showingLocationServiceDisabledAlert = false
    
    let alertTitle: String = "위치 정보 이용"
    let alertMessage: String = "위치 서비스를 사용할 수 없습니다.\n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요."
    
    //MARK: Body
    var body: some View {
        ZStack(alignment: .center) {
            backgroundSplashImage
            blackOpacityView
            centerLogo
        }
        .onAppear {
            requestLocationPermission()
        }
        .alert(alertTitle,
               isPresented: $showingLocationServiceDisabledAlert) {
            Button("설정으로 이동") {
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text(alertMessage)
        }
    }
    
    //MARK: SplashScreenView
    
    /// 스플래쉬 화면 배경화면 사진
    private var backgroundSplashImage: some View {
        Icon.loginBackground.image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .ignoresSafeArea(.all)
    }
    
    /// 배경화면 위 검은 색 배경 처리
    private var blackOpacityView: some View {
        RoundedRectangle(cornerRadius: 24)
            .foregroundStyle(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color(red: 0.09, green: 0.08, blue: 0.12).opacity(0.6))
            .shadow(color: .white.opacity(0.25), radius: 100, x: 0, y: 4)
    }
    
    /// 뚜벅 로고 이미지
    private var centerLogo: some View {
        Icon.logoImage.image
            .resizable()
            .frame(maxWidth: 90, maxHeight: 92)
            .aspectRatio(contentMode: .fill)
    }
    
    private func changeToLoginView() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let newRootView = UIHostingController(rootView: LoginViewCycle())
            appDelegate.changeRootSplashView(newRootView, animated: true)
        }
    }
    
    //MARK: - Location 설정
    
    private func requestLocationPermission() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    BaseLocationManager.shared.requestLocationAuthorization()
                    
                    BaseLocationManager.shared.onAuthorizationChanged = { status in
                        switch status {
                        case .authorizedWhenInUse, .authorizedAlways:
                            self.isLocationPermission = true
                            proceedChangeView()
                        case .denied, .restricted, .notDetermined:
                            self.isLocationPermission = false
                            self.showingLocationServiceDisabledAlert = true
                        default:
                            break
                        }
                    }
                }
            }
            else {
                showingLocationServiceDisabledAlert = true
            }
        }
    }
    
    private func proceedChangeView() {
            if isLocationPermission {
                self.changeToLoginView()
            }
    }
}

#Preview {
    SplashScreenView()
}
