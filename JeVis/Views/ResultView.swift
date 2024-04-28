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
    let coordinate:String
    let imageUrl:String?
    let image:Image?
    
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
                Text(coordinate)
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
                        let urlString = "\(Constants.googleLensSearch)\(imageUrl ?? "")"
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
    ResultView(coordinate: "7° 36′ 28\" LS, 110° 12′ 13\" BT", imageUrl: "https://i.ibb.co/vh2mkZX/bbe1c309fd34.png", image: Image(systemName: "heart"))
}
