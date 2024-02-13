//
//  SplashScreenView.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/4/24.
//

import SwiftUI
import Combine
import CoreLocation
import AVFoundation
import Photos

struct SplashScreenView: View {
    //MARK: Property
    
    @State private var isLocationPermissionOfGPS = false
    @State private var isLocationPermissionOfCamera = false
    @State private var isLocationPermissionOfLibrary = false
    
    @State private var showingLocationServiceDisabledAlert = false
    @State private var showingCameraAccessAlert = false
    @State private var showingPhotoLibraryAccessAlert = false
    
    //MARK: Authorization Text
    
    let gpsAlertTitle: String = "위치 정보 이용"
    let gpsAlertMessage: String = "위치 서비스를 사용할 수 없습니다. \n디바이스의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요."
    
    let cameraAlertTitle: String = "카메라 접근 허용"
    let cameraAlertMessage: String = "카메라를 사용할 수 없습니다. \n디바이스의 '설정 > 개인정보 보호'에서 카메라 서비스를 켜주세요."
    
    let libraryAlertTitle: String = "앨범 접근 허용"
    let libraryAlertMessage: String = "앨범 사용할 수 없습니다. \n디바이스의 '설정 > 개인정보 보호'에서 앨범 서비스를 켜주세요."
    
    
    //MARK: Body
    
    //MARK: Body
    var body: some View {
        ZStack(alignment: .center) {
            backgroundSplashImage
            blackOpacityView
            centerLogo
        }
        .onAppear {
            requestCameraPermission()
            requestPhotoLibraryPermission()
            requestLocationPermission()
        }
        
        .onReceive(Just(isLocationPermissionOfGPS)) { _ in
            proceedChangeView()
        }
        
        .onReceive(Just(isLocationPermissionOfCamera)) { _ in
            proceedChangeView()
        }
        
        .onReceive(Just(isLocationPermissionOfLibrary)) { _ in
            proceedChangeView()
        }
        
        .alert(cameraAlertTitle,
               isPresented: $showingCameraAccessAlert) {
            Button("설정으로 이동") {
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text(cameraAlertMessage)
        }
        
        .alert(libraryAlertTitle,
               isPresented: $showingPhotoLibraryAccessAlert) {
            Button("설정으로 이동") {
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text(libraryAlertMessage)
        }
        
        
        .alert(gpsAlertTitle,
               isPresented: $showingLocationServiceDisabledAlert) {
            Button("설정으로 이동") {
                if let appSetting = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(appSetting)
                }
            }
            Button("취소", role: .cancel) {}
        } message: {
            Text(gpsAlertMessage)
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
                    BaseLocationManager.shared.onAuthorizationChanged = { status in
                        switch status {
                            
                        case .notDetermined:
                            BaseLocationManager.shared.requestLocationAuthorization()
                        case .authorizedWhenInUse, .authorizedAlways:
                            self.isLocationPermissionOfGPS = true
                            proceedChangeView()
                        case .denied, .restricted:
                            self.isLocationPermissionOfGPS = false
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
    
    //MARK: - 카메라 설정
    private func requestCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    self.showingCameraAccessAlert = !granted
                    self.isLocationPermissionOfCamera = granted
                }
            }
        case .denied, .restricted:
            self.showingCameraAccessAlert = true
            self.isLocationPermissionOfCamera = false
        case .authorized:
            self.isLocationPermissionOfCamera = true
        default:
            break
        }
    }

    //MARK: - 앨범 설정
    private func requestPhotoLibraryPermission() {
        switch PHPhotoLibrary.authorizationStatus() {
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    self.isLocationPermissionOfLibrary = status == .authorized
                    self.showingPhotoLibraryAccessAlert = status != .authorized
                }
            }
        case .denied, .restricted:
            self.showingPhotoLibraryAccessAlert = true
            self.isLocationPermissionOfLibrary = false
        case .authorized, .limited:
            self.isLocationPermissionOfLibrary = true
        default:
            break
        }
    }
    
    private func proceedChangeView() {
        if isLocationPermissionOfGPS, isLocationPermissionOfCamera, isLocationPermissionOfLibrary {
                self.changeToLoginView()
            }
    }
}

#Preview {
    SplashScreenView()
}
