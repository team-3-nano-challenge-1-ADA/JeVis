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
    @State private var showProgressBar = false
    
    var body: some View {
        
        ZStack {
            // Latar belakang dengan warna background
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea(.all)
            
            // Konten utama termasuk logo dan gambar
            VStack {
                HStack {
//                    Spacer()
                    Image("logo")
                        .resizable()
                        .frame(width: 68, height: 62, alignment: .leading)
                        .padding() // Beri jarak dari tepi
                        .onTapGesture {
                            self.showingImagePicker = false
                        }
                    Spacer()

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
                        .transition(.opacity)
                } else {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .foregroundColor(Color.button)
                        .frame(width: 100, height: 100)
                        .padding(.top, 200)
                        .onTapGesture {
                            self.showingImagePicker = true
                         }
                }
                Spacer()
                //animation
                if showProgressBar {
                    AnimationView(name: "progressBar")
                        .frame(width: 100, height: 100)
                        .padding(.top)
                        .transition(.opacity)
                    }
                }
            }
        
        
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(image: self.$inputImage)
                        }

        .onAppear{
            if inputImage != nil{
                self.showProgressBar = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                    self.showProgressBar = false
                                    self.image = Image(uiImage: self.inputImage!)
                }
            }
        }
    }
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        
        // Menunda tampilan gambar dan menampilkan progress bar setelah 5 detik
        self.showProgressBar = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
                self.showProgressBar = false
                self.image = Image(uiImage: inputImage)
            }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}

