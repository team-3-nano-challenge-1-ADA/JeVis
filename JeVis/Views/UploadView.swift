//
//  ContentView.swift
//  JeVis
//
//  Created by Rizki Maulana on 23/04/24.
//

import SwiftUI

struct UploadView: View {
    @State private var image: Image?
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var showProgressBar = false
    @State private var navigateToResult = false
    @State private var imageUrl: String?
    
    let networkRequest = NetworkRequest()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Rectangle()
                    .fill(Color.background)
                    .ignoresSafeArea(.all)
                VStack {
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 68, height: 62, alignment: .leading)
                            .padding()
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
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .foregroundColor(Color.button)
                        .frame(width: 100, height: 100)
                        .padding(.top, 200)
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                    
                    Spacer()
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
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(coordinate: "s", imageUrl: imageUrl, image: image)
            }
        }
    }
    
    
    func loadImage(){
        guard let inputImage = inputImage else {return}
        self.image = Image(uiImage: inputImage)
        self.showProgressBar = true
        guard let base64 = inputImage.pngData()?.base64EncodedString(options: .lineLength64Characters) else { return }
        networkRequest.uploadToImageBb(base64ImageData: base64) { (url, error) in
            self.showProgressBar = false
            if let error = error {
                print("Error uploading image: \(error.localizedDescription)")
                return
            }
            guard let imageUrl = url else {
                print("Error: Could not extract image URL")
                return
            }
            print("imageUrl" + imageUrl)
            self.imageUrl = imageUrl
            if (self.imageUrl != nil) {
                /// TODO Add call api reverse image to location below:
                   
                self.navigateToResult = true
            }
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}

