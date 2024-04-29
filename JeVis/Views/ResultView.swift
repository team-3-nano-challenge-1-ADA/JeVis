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
    @State private var navigateToMap = false
    @State private var isWebviewLoading = true
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
                    Text("\(locationModel?.latitude ?? defaultCoordinate),\(locationModel?.longitude ?? defaultCoordinate)")
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
                                showSearchWebView = true
                            }
                            .sheet(isPresented: $showSearchWebView) {
                                ZStack {
                                    WebView(url: URL(string: "\(Constants.googleLensSearch)\(locationModel?.imageUrl ?? "")")!, isLoading: $isWebviewLoading)
                                    if isWebviewLoading {
                                        ProgressView()
                                    }
                                    
                                }
                                
                            }
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
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ResultView(locationModel: LocationModel(latitude: -6.3031838, longitude: 106.652819, address: "Green Office Park, BSD Tangerang", imageUrl: "https://i.ibb.co/vh2mkZX/bbe1c309fd34.png"),image: Image(systemName: "heart"))
}
