//
//  PopUpCustom.swift
//  ttubeokAR
//
//  Created by 정의찬 on 2/6/24.
//

import Foundation
import SwiftUI
import UIKit

func getScreenSize() -> CGSize {
    guard let window = UIApplication.shared.connectedScenes
        .filter({ $0.activationState == .foregroundActive })
        .first(where: { $0 is UIWindowScene }) as? UIWindowScene else {
        return .zero
    }
    return window.screen.bounds.size
}

struct PopupModifier<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent
    private var screenSize: CGSize { getScreenSize() }
    @GestureState private var dragState = DragState.inactive
    private let dragThreshold: CGFloat = 120
    
    enum DragState {
        case inactive
        case dragging(translation: CGSize)
        
        var translation: CGSize {
            switch self {
            case .inactive:
                return .zero
            case .dragging(let translation):
                return translation
            }
        }
        
        var isDragging: Bool {
            switch self {
            case .inactive:
                return false
            case .dragging:
                return true
            }
        }
    }
    
    
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom) {
                    content
                    if isPresented {
                        popupContent()
                            .position(x: screenSize.width / 2, y: screenSize.height * 0.72)
                            .animation(dragState.isDragging ? nil : .easeOut(duration: 0.5), value: dragState.translation.height)
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.5), value: isPresented)
                            .offset(y: dragState.isDragging ? dragState.translation.height : 0)
                            .gesture(
                                DragGesture()
                                    .updating($dragState) { drag, state, _ in
                                        if drag.translation.height > 0 {
                                            state = .dragging(translation: drag.translation)
                                        }
                                    }
                                    .onEnded { drag in
                                        if drag.translation.height > dragThreshold {
                                            withAnimation(.smooth(duration: 1.0)) {
                                                isPresented = false
                                            }
                                        }
                                    }
                            )
                    }
                }
        .transition(.move(edge: .bottom))
        .animation(.easeInOut(duration: 0.5), value: isPresented)
    }
}

extension View {
    func customPopup<PopupContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> PopupContent) -> some View {
        modifier(PopupModifier(isPresented: isPresented, popupContent: content))
    }
}




