//
//  ResultView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI
import AVFAudio

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSearchWebView = false
    let locationModel: LocationModel?
    let image:Image?
    let defaultCoordinate = 0.0
    var tm = TextToSpeechManager()
    
    var body: some View {
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
                Text("\(locationModel?.latitude ?? defaultCoordinate),\(locationModel?.longitude ?? defaultCoordinate)")
                    .padding([.bottom], 16)
                HStack {
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "mappin.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.button)
                    })
                    Spacer()
                    Button(action: {
                        showSearchWebView = true
                        let urlString = "\(Constants.googleLensSearch)\(locationModel?.imageUrl ?? "")"
                        let url = URL(string: urlString)!
                        UIApplication.shared.open(url)
                    }, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.button)
                    })
                }.frame(width: 136)
                Spacer()
                Button(action: {
                    if(tm.synthesizer.isPaused == true){
                        tm.synthesizer.continueSpeaking()
                    } else if (tm.synthesizer.isSpeaking == true){
                        tm.synthesizer.pauseSpeaking(at: AVSpeechBoundary.immediate)
                    } else if(!tm.synthesizer.isSpeaking){
                        tm.speak("Anda dapat menekan tombol pin untuk beralih ke aplikasi navigasi atau tombol kaca pembesar untuk beralih ke aplikasi pencarian.")
                    }
                }, label: {
                    Image(systemName: "speaker.wave.2.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.button)
                })
                .padding(.bottom, 50)
            }.padding()
        }.navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.button)
                    }
                }
            }
    }
}

#Preview {
    ResultView(locationModel: LocationModel(latitude: 51.50576400756836, longitude: -0.075251996517181, address: "Tower Bridge, A100 EC3N 4AB, UK", imageUrl: "https://i.ibb.co/vh2mkZX/bbe1c309fd34.png"),image: Image(systemName: "heart"))
}
