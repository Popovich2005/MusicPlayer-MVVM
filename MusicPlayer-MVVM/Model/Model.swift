//
//  Model.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import Foundation

struct SongModel: Identifiable {
    let id = UUID()
    let name: String
    let data: Data
    let artist: String?
    let coverImage: Data?
    let duration: TimeInterval?
}
