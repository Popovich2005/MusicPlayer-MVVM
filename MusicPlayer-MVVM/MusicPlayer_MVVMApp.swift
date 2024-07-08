//
//  MusicPlayer_MVVMApp.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI

@main
struct MusicPlayer_MVVMApp: App {
    var body: some Scene {
//        let _ = print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!.path())
        WindowGroup {
            PlayerView()
        }
    }
}
