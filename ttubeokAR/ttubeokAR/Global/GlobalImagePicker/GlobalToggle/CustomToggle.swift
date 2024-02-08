//
//  ToggleButtonView.swift
//  ttubeokAR
//
//  Created by Subeen on 1/20/24.
//

import SwiftUI

struct CustomToggle: ToggleStyle {
//    private let width = 60.0
    
//    var activeColor: Color = Color.gray
//    var activeCircle: Bool
//    var height: CGFloat
//    var width: CGFloat
//    
//    init(
//        activeColor: Color,
//        activeCircle: Bool,
//        height: CGFloat,
//        width: CGFloat
//    ) {
//        self.activeColor = activeColor
//        self.activeCircle = activeCircle
//        self.height = height
//        self.width = width
//    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            ToggleShape(isOn: configuration.$isOn)
        }.onTapGesture {
            withAnimation(.spring()) {
                configuration.isOn.toggle()
            }
        }
    }
}

struct ToggleShape: View {
    @Binding var isOn: Bool
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            GeometryReader { proxy in
                ZStack (alignment: isOn ? .trailing : .leading) {
                    Capsule()
                        .fill(isOn ? .primary03 : .textPink)
                        .frame(width:proxy.size.width, height: proxy.size.height)
                        .overlay {
                            HStack(alignment: .center) {
                                Text(isOn ? "ON" : "OFF")
                                    .foregroundStyle(isOn ? .white : .primary03)
                                    .offset(x: isOn ? 8 : 25)
                                    .font(.sandol(type: .bold, size: 11))
                                    .kerning(0.11)
                                
                                Circle()
                                    .fill(.white)
                                    .frame(width: 20, height: 20)
                                    .offset(x: isOn ? 7 : -35)
                            }
                        }
                }

            }
            .frame(width: 65, height: 30)
        }
    }
}

//#Preview {
//    @State var isOn: Bool = false
//    Toggle(isOn: $isOn) {
//        Text("h")
//    }.toggleStyle(ToggleButtonView())
//}




//
//  RecuritCustomToggle.swift
//  SSAFSound
//
//  Created by 서원지 on 2023/07/18.
//

//import SwiftUI
//
//public struct RecuritCustomToggle: ToggleStyle {
//    var activeColor: Color = Color.gray
//    var activeCircle: Bool
//    var height: CGFloat
//    var width: CGFloat
//
//    public init(activeColor: Color, activeCircle: Bool, height: CGFloat, width: CGFloat) {
//        self.activeColor = activeColor
//        self.activeCircle = activeCircle
//        self.width = width
//        self.height = height
//    }
//
//    //MARK: -  컴스텀으로 toggle 만드는 UI
//    public func makeBody(configuration: Configuration) -> some View {
//        RoundedRectangle(cornerRadius: 30)
//            .stroke(configuration.isOn ? activeColor : Color.gray, style: .init(lineWidth: 2))
////                .fill(configuration.isOn ? activeColor : Color.gray4)
//            .frame(width: width, height: height)
////                .background(configuration.isOn ? activeColor : Color.gray)
//            .cornerRadius(30)
//            .overlay {
//                
//                HStack {
//                    Text("모집중")
//                        .manropeFont(family: .Bold , size: 18)
//                        .kerning(-0.3)
//                        .offset(x: configuration.isOn ? 8 : 25)
//                        .foregroundColor(configuration.isOn ? activeColor: .bluegrey)
//                    
//                    Circle()
//                        .fill(activeCircle ? activeColor : .grey)
//                        .frame(width: 20, height: 20)
//                        .padding(3)
//                        .offset(x: configuration.isOn ? 8 : -60)
//                }
//
//            }
//           
//            .onTapGesture {
//                withAnimation(.spring()) {
//                    configuration.isOn.toggle()
//                }
//            }
//    }
//
//}
//
//
//
public struct CustomToggle_Previews: PreviewProvider {
    @State var isOn: Bool
    public static var previews: some View {
        HStack {
            Toggle("", isOn: .constant(true))
                .toggleStyle(CustomToggle())
        }
    }
}
