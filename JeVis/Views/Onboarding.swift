//
//  Onboarding.swift
//  JeVis
//
//  Created by Jovanna Melissa on 26/04/24.
//

import SwiftUI

struct Onboarding: View {
    @State var screenshot: String
    var showButton: Bool

    var body: some View {
        ZStack{
            Rectangle()
                .foregroundStyle(Color.background)
                .ignoresSafeArea()
            
            VStack{
                Image(screenshot)
                    .resizable()
                    .frame(width: 200, height: 433)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: 3)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            
        }
    }
}

#Preview {
    Onboarding(screenshot: "upload page", showButton: false)
}
