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
    @State private var navigateToMap = false
    
    var locationModel: LocationModel?
    var image:Image?
    let defaultCoordinate = 0.0
    
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

//                    Button(action: {}, label: {
//                        Image(systemName: "mappin.circle.fill")
//                            .resizable()
//                            .frame(width: 50, height: 50)
//                            .foregroundStyle(Color.button)
//                    })
                    NavigationLink(destination: MapView(locationModel: locationModel)) {
                                        Image(systemName: "mappin.circle.fill")
                                            .resizable()
                                            .frame(width: 50, height: 50)
                                            .foregroundColor(Color.button)
                    }
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
//            .navigationBarBackButtonHidden(true)
//            .navigationDestination(isPresented: $navigateToMap) {
//               
//            }
        } //akhir navihationstack
//        .navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    ResultView(locationModel: LocationModel(latitude: -6.3031838, longitude: 106.652819, address: "Green Office Park, BSD Tangerang", imageUrl: "https://i.ibb.co/vh2mkZX/bbe1c309fd34.png"),image: Image(systemName: "heart"))
}
