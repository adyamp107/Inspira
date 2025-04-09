//
//  Splash.swift
//  Inspira
//
//  Created by Adya Muhammad Prawira on 08/04/25.
//

import SwiftUI

struct SplashView: View {
    @State private var animate = false
    @State private var showMainView = false

    var body: some View {
        ZStack {
            if showMainView {
                ContentView()
            } else {
                Color.white.ignoresSafeArea()

                Image("inspiralogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                    .scaleEffect(animate ? 1 : 0.5)
                    .opacity(animate ? 1 : 0)
                    .animation(.interpolatingSpring(stiffness: 100, damping: 10).delay(0.2), value: animate)
            }
        }
        .onAppear {
            animate = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.2) {
                withAnimation(.easeInOut) {
                    showMainView = true
                }
            }
        }
    }
}



#Preview {
    SplashView()
}
