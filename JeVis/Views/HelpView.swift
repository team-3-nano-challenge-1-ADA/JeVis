//
//  HelpView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI

struct HelpView: View {
    @Bindable var helpModel = HelpModel()
    var pages: [String] = ["upload page", "result"]
    var onboardings = HelpModel().onboardings

    var body: some View {
        NavigationStack{
            ZStack {
                Rectangle()
                    .fill(Color.background)
                    .ignoresSafeArea(edges: .all)
                
                VStack{
                    HStack {
                        Image("logo")
                            .resizable()
                            .frame(width: 68, height: 38, alignment: .leading)
                            .padding()
                        Spacer()
                    }
                    
                    TabView(selection: $helpModel.tabIndex){
                        ForEach(0..<2){index in
                            onboardings[index]
                        }
                    }.tabViewStyle(.page(indexDisplayMode: .never))
                        .frame(height: 500)
                    
                    PageControl(currentPage: helpModel.tabIndex)
                        .padding(.bottom, 30)
                    
                    if(onboardings[helpModel.tabIndex].showButton){
                        HStack{
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                Image(systemName: "speaker.wave.2.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(Color.button)
                            })
                            .padding(.trailing)
                            
                            NavigationLink{
                                UploadView()
                            } label: {
                                Image(systemName: "arrow.forward.circle.fill")
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .foregroundStyle(Color.button)
                            }
                        }
                    } else {
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Image(systemName: "speaker.wave.2.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .foregroundStyle(Color.button)
                        })
                    }
                }
            }
        }.navigationBarBackButtonHidden(true)
        
    }
}

#Preview {
    HelpView()
}
