//
//  AddLocation.swift
//  ttubeokAR
//
//  Created by 정의찬 on 1/8/24.
//

import Foundation
import SwiftUI

class AddLocationCommand: TtuDotModel {
    var onExecute: (() -> Void)?
    
    func execute() {
        onExecute?()
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let newRootView = UIHostingController(rootView: PlaceRegistrationView())
        appDelegate?.changeRootViewController(newRootView)
    }
}
