//
//  ResultView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI

struct ResultView: View {
    let coordinate:String
    let imageUrl:String
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                AsyncImage(url: URL(string: imageUrl)) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
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
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.button)
                    })
                }.frame(width: 136)
                
                Spacer()
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "speaker.wave.2.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.button)
                })
                .padding(.bottom, 50)
            }.padding()
        }
    }
}

#Preview {
    ResultView(coordinate: "7° 36′ 28\" LS, 110° 12′ 13\" BT", imageUrl: "https://gaetlokal.id/cni-content/uploads/modules/posts/20200917084844.png")
}
