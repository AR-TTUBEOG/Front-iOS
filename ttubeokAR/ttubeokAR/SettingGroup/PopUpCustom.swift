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

extension View {
    func customPopup<PopupContent: View>(isPresented: Binding<Bool>, @ViewBuilder content: @escaping () -> PopupContent) -> some View {
        modifier(PopupModifier(isPresented: isPresented, popupContent: content))
    }
}


struct PopupModifier<PopupContent: View>: ViewModifier {
    @Binding var isPresented: Bool
    let popupContent: () -> PopupContent
    private var screenSize: CGSize { getScreenSize() }
    @GestureState private var dragState = DragState.inactive
    private let dragThreshold: CGFloat = 50.0
    
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
                            .animation(dragState.isDragging ? nil : .easeOut(duration: 0.5), value: dragState.translation.height) // 드래그 애니메이션 유지
                            .transition(.move(edge: .bottom))
                            .animation(.easeInOut(duration: 0.5), value: isPresented)
                            .offset(y: dragState.isDragging ? dragState.translation.height : 0)
                            .gesture(
                                DragGesture()
                                    .updating($dragState) { drag, state, _ in
                                        state = .dragging(translation: drag.translation)
                                    }
                                    .onEnded { drag in
                                        if drag.translation.height > dragThreshold {
                                            withAnimation(.easeOut(duration: 0.5)) {
                                                // 임계값을 넘으면 팝업을 사라지게 하고, 드래그 상태를 초기화
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
