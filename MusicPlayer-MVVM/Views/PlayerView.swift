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
    @State private var showFiles = false
    @State private var showDetails = true
    @Namespace private var playerAnimation
    
    var frameImage: CGFloat {
        showDetails ? 320 : 50
    }
    
    // MARK: - Body
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                
                VStack {
                    
                    /// List of songs
                    List {
                        ForEach(vm.songs) { song in
                            SongCell(song: song, durationFormated: vm.durationFormated)
                                .onTapGesture {
                                    vm.playAudio(song: song)
                                }
                        }
                    }
                    .listStyle(.plain)
                    
                    Spacer()
                    
                    // MARK: - Player
                    VStack {
                        
                        /// Mini Player
                        HStack {
                            Color.white
                                .frame(width: frameImage, height: frameImage)
                            
                            if !showDetails {
                                
                                /// Description
                                VStack(alignment: .leading) {
                                    Text("Name")
                                        .nameFont()
                                    Text("Unknow Artist")
                                        .artistFont()
                                }
                                .matchedGeometryEffect(id: "Description", in: playerAnimation)
                                
                                Spacer()
                                
                                CustomButton(image: "play.fill", size: .title) {
                                    //
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
                                Text("Name")
                                    .nameFont()
                                Text("Unknow Artist")
                                    .artistFont()
                            }
                            .matchedGeometryEffect(id: "Description", in: playerAnimation)
                            .padding(.top)
                            
                            VStack {
                                /// Duration
                                HStack {
                                    Text("00:00")
                                    Spacer()
                                    Text("03:27")
                                }
                                .durationFont()
                                .padding()
                                
                                /// Slider
                                Divider()
                                
                                
                                HStack(spacing: 40) {
                                    CustomButton(image: "backward.end.fill", size: .title2) {
                                        //
                                    }
                                    CustomButton(image: "play.circle.fill", size: .largeTitle) {
                                        //
                                    }
                                    CustomButton(image: "forward.end.fill", size: .title2) {
                                        //
                                    }
                                }
                            }
                            .padding(.horizontal, 40)
                        }
                    }
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
                ImportFileManager(songs: $vm.songs)
            })
        }
    }
    
    // MARK: - Methods
    private func CustomButton(image: String, size: Font, action: @escaping () -> ()) -> some View {
        Button {
            action()
        } label: {
            Image(systemName: image)
                .foregroundStyle(.white)
                .font(size)
        }
        
    }
}

#Preview {
    PlayerView()
}




