//
//  ResultView.swift
//  JeVis
//
//  Created by Rizki Maulana on 26/04/24.
//

import SwiftUI

struct ResultView: View {
    var body: some View {
        VStack {
            AnimationView(name: "progressBar")
                .frame(width: 600, height: 70)
        }.padding(.top, 500)
    }
}

#Preview {
    ResultView()
}
