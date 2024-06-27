//
//  BackgroundView.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        LinearGradient(
            colors: [.topBackground, .bottomBackground],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}
#Preview {
    BackgroundView()
}
