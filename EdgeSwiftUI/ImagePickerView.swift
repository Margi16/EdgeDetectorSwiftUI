//
//  ImagePickerView.swift
//  EdgeSwiftUI
//
//  Created by Margi  Bhatt on 18/08/22.
//

import SwiftUI

struct ImagePickerView: View {
    
    @State var image: Image?
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var buttonPressed = false
    @StateObject private var model = ContentViewModel()
    
    var body: some View {
        NavigationView{
            VStack{
                    ZStack{
                        Rectangle()
                            .fill(.secondary)
                        
                        Text("Tap to select a picture")
                            .foregroundColor(.white)
                            .font(.headline)
                        
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    .padding()
                    .onTapGesture {
                        showingImagePicker = true
                    }
                    .onChange(of: inputImage) { _ in loadImage() }
                    .sheet(isPresented: $showingImagePicker) {
                        ImagePicker(image: $inputImage)
                    }
                    
                    Spacer()
                    
                    
                NavigationLink(destination: ContentView(image: inputImage)) {
                    Text("Show Next View")
                }
                .onTapGesture {
                    model.image = inputImage?.cgImage
                }
                .navigationTitle("Navigation")
                
            }
        }.navigationTitle("Plotline")
        
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
    
}

struct ImagePickerView_Previews: PreviewProvider {
    static var previews: some View {
        ImagePickerView()
    }
}
