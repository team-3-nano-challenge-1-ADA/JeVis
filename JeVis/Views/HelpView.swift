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
        ZStack {
            Rectangle()
                .fill(Color.background)
                .ignoresSafeArea(edges: .all)
            
            VStack{
                HStack{
                    Image("Logo Jevis")
                        .resizable()
                        .frame(width: 68, height: 62)
                    Spacer()
                }
                .padding(.leading, 30)
                
                TabView(selection: $helpModel.tabIndex){
                    ForEach(0..<2){index in
                        onboardings[index]
                    }
                }.tabViewStyle(.page(indexDisplayMode: .never))
                    .padding(.bottom, -40)
                
                PageControl(currentPage: helpModel.tabIndex)
                    .padding(.bottom, 20)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "speaker.wave.2.circle.fill")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .foregroundStyle(Color.button)
                })
                .padding(.bottom, 50)
                
                Spacer()
            }
        }
    }
}

#Preview {
    HelpView()
}
