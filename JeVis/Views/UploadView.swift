//
//  ContentView.swift
//  JeVis
//
//  Created by Rizki Maulana on 23/04/24.
//

import SwiftUI

struct UploadView: View {
    @State private var image: Image?
    @State private var showingPickerOption = false
    @State private var showingImagePicker = false
    @State private var showingCamera = false
    @State private var inputImage: UIImage?
    @State private var puzzleImage: UIImage?
    @State private var showProgressBar = false
    @State private var navigateToResult = false
    @State private var imageUrl: String?
    @State private var locationModel: LocationModel?
    @State private var isClicked = false
    @State private var gifLoading = false
    
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
                            .frame(width: 68, height: 38, alignment: .leading)
                            .padding()
                            .onTapGesture {
                                self.showingImagePicker = false
                                self.showingCamera = false
                                self.showingPickerOption = false
                            }
                        Spacer()
                        NavigationLink{
                            HelpView()
                        } label: {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(Color.button)
                                .frame(width: 30, height: 30)
                                .padding()
                        }
                    }
                    if(!gifLoading){
                        ZStack{
                            AnimationView(name: "tap", animationSpeed: 0.5)
                                .frame(width: 200, height: 200)
                                .padding(.top, 200)
                                .onTapGesture {
                                    if(self.showProgressBar) {return}
                                }
                                
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .frame(width: 121, height: 119)
                                .foregroundStyle(Color.button)
                                .padding(.top, 200)
                                .onTapGesture {
                                    self.showingPickerOption = true
                                    self.isClicked = true
                                }
                                .sensoryFeedback(.success, trigger: isClicked)
                        }
                    } else {
//                        GifView("loadingGif")
//                            .padding(.top, 100)
                        PuzzleView(selectedPhotoItem: self.puzzleImage)
                    }
                    
                    
                    Spacer()
                    if showProgressBar {
                        AnimationView(name: "progressBar", animationSpeed: 0.5)
                            .frame(width: 100, height: 100)
                            .padding(.top)
                            .transition(.opacity)
                    }
                }
            }
            .sheet(isPresented: $showingPickerOption) {
                HStack {
                    Image(systemName: "photo.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.button)
                        .frame(width: 60, height: 60)
                        .padding()
                        .onTapGesture {
                            self.showingImagePicker = true
                        }
                        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                            ImagePicker(sourceType: .photoLibrary, image: self.$inputImage)
                        }
                    Image(systemName: "camera.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(Color.button)
                        .frame(width: 60, height: 60)
                        .padding()
                        .onTapGesture {
                            self.showingCamera = true
                        }
                        .sheet(isPresented: $showingCamera, onDismiss: loadImage) {
                            ImagePicker(sourceType: .camera, image: self.$inputImage)
                        }
                }
                .padding()
                .presentationDetents([.fraction(0.15)])
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
            }
            .navigationBarBackButtonHidden(true)
            .navigationDestination(isPresented: $navigateToResult) {
                ResultView(locationModel: locationModel, image: image)
            }
        }.navigationBarBackButtonHidden(true)
    }
    
    
    func loadImage() {
        guard let inputImage = inputImage else {return}
        self.puzzleImage = inputImage
        self.showingPickerOption = false
        self.showProgressBar = true
        self.gifLoading = true
        self.image = Image(uiImage: inputImage)
        let resizedImage = resizeImage(inputImage, targetSize: CGSize(width: 50, height: 50))
        guard let base64 = resizedImage.pngData()?.base64EncodedString(options: .lineLength64Characters) else { return }
        // dicomment dulu untuk hemat quota api, uncomment ketika release
//        fetchGeolocation(base64: base64)
        // dipakai selama testing menggunakan data dummy, comment ketika release
        dummyFetchGeolocation(base64: base64)
        self.inputImage = nil
    }
    
    func dummyFetchGeolocation(base64: String) {
        self.showProgressBar = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.showProgressBar = false
            self.locationModel = LocationModel(latitude: 51.50576400756836, longitude: -0.075251996517181, address: "Tower Bridge, A100 EC3N 4AB, UK", imageUrl: "https://i.ibb.co/VMjSpp0/03e4a17543ae.png")
            self.navigateToResult = true
        }
    }
    
    func fetchGeolocation(base64: String) {
        networkRequest.fetchGeolocationPicarta(base64ImageString: base64) { result in
            switch result {
            case .success(let location):
                print("Latitude: \(location.latitude), Longitude: \(location.longitude), Address: \(location.address ?? "")")
                self.locationModel = location
                uploadImage(base64: base64)
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func uploadImage(base64: String) {
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
                self.locationModel?.imageUrl = imageUrl
                self.navigateToResult = true
            }
        }
    }
    
    func resizeImage(_ image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        let scaleFactor = min(widthRatio, heightRatio)
        let scaledSize = CGSize(width: size.width * scaleFactor, height: size.height * scaleFactor)
        let renderer = UIGraphicsImageRenderer(size: scaledSize)
        let scaledImage = renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: scaledSize))
        }
        return scaledImage
    }
}

#Preview {
    UploadView()
}
