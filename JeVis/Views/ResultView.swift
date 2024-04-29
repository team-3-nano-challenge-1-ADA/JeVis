//
//  ResultView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI

struct ResultView: View {
    @Environment(\.dismiss) var dismiss
    @State private var showSearchWebView = false
    @State private var isWebviewLoading = true
    let locationModel: LocationModel?
    let image:Image?
    let defaultCoordinate = 0.0
    
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
                Button(action: {}, label: {
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
    ResultView(locationModel: LocationModel(latitude: 51.50576400756836, longitude: -0.075251996517181, address: "Tower Bridge, A100 EC3N 4AB, UK", imageUrl: "https://i.ibb.co/VMjSpp0/03e4a17543ae.png"),image: Image(systemName: "heart"))
}
