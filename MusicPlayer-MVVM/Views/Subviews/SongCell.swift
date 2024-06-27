//
//  SongCell.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI

struct SongCell: View {
    
    // MARK: - Properties
    let song: SongModel
    
    // MARK: - Body
    var body: some View {
        HStack {
            Color.white
                .frame(width: 60, height: 60)
                .cornerRadius(10)
            
            VStack(alignment: .leading) {
                Text(song.name)
                    .nameFont()
                Text(song.artist ?? "Unknow Artist")
                    .artistFont()
            }
            
            Spacer()
            
            Text("03:48")
                .artistFont()
        }
        .listRowBackground(Color.clear)
        .listRowSeparator(.hidden)
    }
}

#Preview {
    SongCell(song: SongModel(name: "CV", data: Data(), artist: "DD", coverImage: Data(), duration: 0))
}
