//
//  ContentView.swift
//  MusicPlayer-MVVM
//
//  Created by Алексей Попов on 27.06.2024.
//

import SwiftUI
import RealmSwift

struct PlayerView: View {
    
    // MARK: - Properties
    @ObservedResults(SongModel.self) var songs
    @StateObject var vm = ViewModel()
    @State private var showFiles = false
    @State private var showDetails = false
    @Namespace private var playerAnimation
    
    var frameImage: CGFloat {
        showDetails ? 320 : 50
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                
                // MARK: - Background
                BackgroundView()
                
                
                VStack {
                    
                    /// List of songs
                    List {
                        ForEach(songs) { song in
                            SongCell(song: song, durationFormated: vm.durationFormated)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                        }
                        .onDelete(perform: $songs.remove)
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                    
                    // MARK: - Player
                    if vm.currentSong != nil {
                        
                        Player()
                        
                        .frame(height: showDetails
                               ? SizeConstant.fullPlayer
                               : SizeConstant.miniPlayer)
                        .onTapGesture {
                            withAnimation(.spring) {
                                self.showDetails.toggle()
                            }
                        }
                        
                    }
                }
            }
            
            // MARK: - Navigation Bar
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showFiles.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .foregroundStyle(.white)
                            .font(.title2)
                    }
                }
            }
            // MARK: File's Sheet
            .sheet(isPresented: $showFiles, content: {
                ImportFileManager()
            })
        }
    }
    
    // MARK: - Methods
//    @ViewBuilder
    private func Player() -> some View {
        VStack {
            
            /// Mini Player
            HStack {
                
                ///Cover
                SongImageView(imageData: vm.currentSong?.coverImage, size: frameImage)
                
                if !showDetails {
                    
                    /// Description
                    VStack(alignment: .leading) {
                       SongDescription()
                    }
                    .matchedGeometryEffect(id: "Description", in: playerAnimation)
                    
                    Spacer()
                    
                    CustomButton(image: vm.isPlaying ? "pause.fill" : "play.fill", size: .title) {
                        vm.playPause()
                    }
                }
            }
            .padding()
            .background(showDetails ? .clear : .black.opacity(0.3))
            .cornerRadius(10)
            .padding()
            
            /// Full Player
            if showDetails {
                
                /// Description
                VStack {
                    SongDescription()
                }
                .matchedGeometryEffect(id: "Description", in: playerAnimation)
                .padding(.top)
                
                VStack {
                    /// Duration
                    HStack {
                        Text("\(vm.durationFormated(duration: vm.currentTime))")
                        Spacer()
                        Text("\(vm.durationFormated(duration: vm.totalTime))")
                    }
                    .durationFont()
                    .padding()
                    
                    /// Slider
                    Slider(value: $vm.currentTime, in: 0...vm.totalTime) { editing in
                        
                        if !editing {
                            vm.seekAudio(time: vm.currentTime)
                        }
                    }
                    .offset(y: -18)
                    .accentColor(.white)
                    .onAppear {
                        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                            vm.updateProgress()
                        }
                    }
                    
                    
                    HStack(spacing: 40) {
                        CustomButton(image: "backward.end.fill", size: .title2) {
                            vm.backward()
                        }
                        CustomButton(image: vm.isPlaying
                                     ? "pause.circle.fill"
                                     : "play.circle.fill",
                                     size: .largeTitle) {
                            vm.playPause()
                        }
                        CustomButton(image: "forward.end.fill", size: .title2) {
                            vm.forward()
                        }
                    }
                }
                .padding(.horizontal, 40)
            }
        }
    }
    
    private func CustomButton(image: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }
        
    }
    
    @ViewBuilder
    private func SongDescription() -> some View {
        if let currentSong = vm.currentSong {
            Text(currentSong.name)
                .nameFont()
            Text(currentSong.artist ?? "Unknow Artist")
                .artistFont()
        }
    }
}



#Preview {
    PlayerView()
}




