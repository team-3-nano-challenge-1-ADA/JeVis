//
//  ContentView.swift
//  JeVis
//
//  Created by Rizki Maulana on 23/04/24.
//

import SwiftUI

struct UploadView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showAnimationView = false
    
    var body: some View {
        
        ZStack {
            // Latar belakang dengan warna background
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea(.all)
            
            // Konten utama termasuk logo dan gambar
            VStack {
                HStack {
                    Spacer()
                    Image("logo")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding() // Beri jarak dari tepi
                        .onTapGesture {
                            self.showingImagePicker = false
                        }

                    Image(systemName: "questionmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.button)
                        .frame(width: 30, height: 30)
                        .padding()
                        .onTapGesture {
                            self.showingImagePicker = false
                        }
                }
                
                // Area gambar (atau placeholder gambar)
                if image != nil {
                    image?
                        .resizable()
                        .scaledToFit()
                        .padding(.top, 200)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .foregroundColor(Color.button)
                        .frame(width: 100, height: 100)
                        .padding(.top, 200)
                }
                Spacer()
            }
            .onTapGesture {
                //SELECT IMAGE
                self.showingImagePicker = true
            }
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
            if showAnimationView {
                AnimationView(name: "progressBar")
            }
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
        
        showAnimationView = true
    }
}


#Preview {
    UploadView()
}

