//
//  ContentView.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI

struct PlayerView: View {
    
    // MARK: - Properties
    @StateObject var vm = ViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                /// List of songs
                List {
                    ForEach(vm.songs) { song in
                        SongCell(song: song)
                    }
                }
                .listStyle(.plain)
            }
            
            // MARK: - Navigation Bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                }
            }
        }
    }
}

#Preview {
    PlayerView()
}




