//
//  ContentView.swift
//  EdgeSwiftUI
//
//  Created by Margi  Bhatt on 18/08/22.
//

import SwiftUI
import EdgeDetectorFramework

struct ContentView: View {
    
    @StateObject private var model = ContentViewModel()
    
    @State private var showContours = false
    @State private var showSettings = false
    
    @State private var showImagePicker = false
    @State private var selectedImage: UIImage?
    
    var body: some View {
        ZStack {
            
            if showContours {
                ContoursView(contours: model.contours)
            } else {
                ImageView(image: model.image)
            }
            
            VStack {
                Spacer()
                
                HStack {
                    Button {
                        showImagePicker = true
                    } label: {
                        Image(systemName: "photo")
                            .padding()
                    }
                    
                    Spacer()
                    
                    if model.calculating {
                        Text("Calculating contours...")
                            .foregroundColor(.white)
                            .padding()
                    } else if selectedImage != nil {
                        Text("Tap screen to toggle contours")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        Text("Tap \(Image(systemName: "photo")) to select an image")
                            .foregroundColor(.white)
                            .padding()
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        showSettings.toggle()
                    }, label: {
                        Image(systemName: "gear")
                            .padding()
                    })
                }
            }
        }.background(Color.black)
        .onTapGesture {
            self.showContours.toggle()
        }
        .sheet(isPresented: $showSettings) {
            SettingsView()
                .onDisappear {
                    model.updateContours()
                }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .onChange(of: selectedImage) { _ in
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let selectedImage = selectedImage else { return }
        model.startProcessing(for: selectedImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
