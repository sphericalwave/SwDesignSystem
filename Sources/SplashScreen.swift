//
//  ContentView.swift
//  Splash
//
//  Created by Aaron Anthony on 2023-05-30.
//

import SwiftUI

@available(iOS 13.0, *)
public struct SplashScreen<Content: View>: View {
    
    @State var splashAnimation: Bool = false
    @State var animationComplete = false
    @Environment(\.colorScheme) var scheme
    private let injectedView: () -> Content
    
    public init(@ViewBuilder injectedView: @escaping () -> Content) {
        self.injectedView = injectedView
    }
    
    public var body: some View {
        ZStack {
            injectedView()
                .opacity(splashAnimation ? 1: 0) //hide home until splash finishes
            
            Group {
                if #available(iOS 15.0, *) {
                    Color("BG")
                        .mask {
                            Rectangle()
                                .overlay(alignment: .center) {
                                    Image("logo_svg")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 200, height: 200)
                                        .scaleEffect(splashAnimation ? 60 : 1)
                                        .blendMode(.destinationOut)
                                }
                        }
                } else {
                    // Fallback: approximate effect without using iOS 15 overlay-in-mask
                    ZStack {
                        Color("BG")
                        Image("logo_svg")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                            .scaleEffect(splashAnimation ? 60 : 1)
                            .blendMode(.destinationOut)
                    }
                    .compositingGroup()
                    .luminanceToAlpha()
                }
            }
            .allowsHitTesting(false) //never really goes away, make touches pass thru
        }
        .modifier(IgnoresSafeAreaCompat())
        .preferredColorScheme(splashAnimation ? nil: .light) //avoiding dark twitter color
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                withAnimation(.easeInOut(duration: 0.7)) {
                    splashAnimation.toggle()
                }
            }
        }
        //.onTapGesture {
        //    //testing only
        //    withAnimation(.easeInOut(duration: 0.4)) {
        //        splashAnimation.toggle()
        //    }
        //}
    }
}

@available(iOS 13.0, *)
private struct IgnoresSafeAreaCompat: ViewModifier {
    func body(content: Content) -> some View {
        Group {
            if #available(iOS 14.0, *) {
                content.ignoresSafeArea()
            } else {
                content.edgesIgnoringSafeArea(.all)
            }
        }
    }
}

@available(iOS 13.0, *)
struct SplashScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        SplashScreen {
            Image("HomeLight")
                .resizable()
                .aspectRatio(contentMode: .fill)
        }
        .preferredColorScheme(.dark)
    }
}
