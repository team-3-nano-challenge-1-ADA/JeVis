//
//  ResultView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI
import AVFAudio
import UIKit

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToMap = false
    @State private var isAnimating = true
    @State private var isTaskCompleted = true
    var locationModel: LocationModel?
    var image:Image?
    let defaultCoordinate = 0.0
    var tm = TextToSpeechManager()
    
    var body: some View {
        NavigationView{
            ZStack {
                Rectangle()
                    .fill(Color.background)
                    .ignoresSafeArea(.all)
                VStack {
                    Spacer()
                    image?
                        .resizable()
                        .scaledToFit()
                        .transition(.opacity)
                        .frame(maxHeight: 180)
                        .padding([.bottom], 18)
                    Text("\(locationModel?.latitude ?? defaultCoordinate), \(locationModel?.longitude ?? defaultCoordinate)")
                        .padding([.bottom], 16)
                    HStack {
                        NavigationLink(destination: MapView(locationModel: locationModel)) {
                            Image(systemName: "mappin.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundColor(Color.button)
                        }
                        Spacer()
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.button)
                            .onTapGesture {
                                let urlString = "\(Constants.googleLensSearch)\(locationModel?.imageUrl ?? "")"
                                let url = URL(string: urlString)!
                                UIApplication.shared.open(url)
                            }
                    }.frame(width: 136)
                    Spacer()
                    
                    if(isAnimating){
                        AnimationView(name: "soundWave2", animationSpeed: 1.0)
                            .frame(width: 200, height: 80)
                            .padding(.leading, 10)
                            .onAppear(perform: {
                                stopAnimation()
                            })
                    }
                    
                }.padding()
            }.navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink {
                            UploadView()
                        } label: {
                            Image(systemName: "arrow.backward")
                                .foregroundColor(.button)
                        }
                    }
                }
                .onAppear(perform: {
                    tm.speak("Menurut prediksi, lokasi gambar yang Anda unggah berada di \(locationModel?.address ?? "Tidak diketahui"). Anda dapat menekan tombol pin untuk beralih ke aplikasi navigasi, atau tombol kaca pembesar untuk beralih ke aplikasi pencarian.")
                    
                    triggerHapticFeedback()
                    
                })
                .onDisappear(perform: {
                    if(tm.synthesizer.isSpeaking){
                        tm.synthesizer.stopSpeaking(at: .immediate)
                    }
                })
        }.navigationBarBackButtonHidden(true)
    }
    
    func stopAnimation(){
        tm.delegate.didFinishSpeechCallback = {
            isAnimating = false
        }
    }
    
    func triggerHapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
}

#Preview {
    ResultView(locationModel: LocationModel(latitude: -6.3031838, longitude: 106.652819, address: "Green Office Park, BSD Tangerang", imageUrl: "https://i.ibb.co/vh2mkZX/bbe1c309fd34.png"),image: Image(systemName: "heart"))
}
