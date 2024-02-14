//
//  PermissionViewModel.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/15/24.
//

import Foundation
import Combine

class PermissionViewModel: ObservableObject {
    let permissionCheck = PassthroughSubject<Void, Never>()
    
    @Published var isLocationGPS = false {
        didSet { permissionCheck.send() }
    }
    
    @Published var isLocationCamera = false {
        didSet { permissionCheck.send() }
    }
    
    @Published var isLocationLibrary = false {
        didSet { permissionCheck.send() }
    }
    
    var allPermissionsGranted: AnyPublisher<Bool, Never> {
            permissionCheck
                .map { self.isLocationGPS && self.isLocationCamera && self.isLocationLibrary }
                .eraseToAnyPublisher()
        }
}
