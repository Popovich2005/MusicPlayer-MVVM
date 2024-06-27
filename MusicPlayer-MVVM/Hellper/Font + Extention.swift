//
//  FontView.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI

extension Text {
    func nameFont() -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(size: 16, weight: .semibold, design: .rounded))
    }
    
    func artistFont() -> some View {
        self
            .foregroundStyle(.white)
            .font(.system(size: 14, weight: .light, design: .rounded))
    }
}

struct FontsView: View {
    var body: some View {
        VStack {
            Text("Name Font")
                .nameFont()
            Text("Artist Font")
                .artistFont()
        }
    }
}

#Preview {
    FontsView()
}
