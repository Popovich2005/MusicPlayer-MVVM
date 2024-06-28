//
//  ViewModel.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import Foundation

final class ViewModel: ObservableObject {
    
    @Published var songs: [SongModel] = []
}
