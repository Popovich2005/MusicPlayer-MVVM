//
//  Model.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import Foundation

struct SongModel: Identifiable {
    var id = UUID()
    var name: String
    var data: Data
    var artist: String?
    var coverImage: Data?
    var duration: TimeInterval?
}
