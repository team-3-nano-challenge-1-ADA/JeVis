//
//  PageControl.swift
//  JeVis
//
//  Created by Jovanna Melissa on 26/04/24.
//

import SwiftUI

struct PageControl: View {
    var currentPage: Int

    var body: some View {
        HStack {
            ForEach(0..<2) { index in
                if(index == currentPage){
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(Color.gray)
                } else {
                    Circle()
                        .frame(width: 8, height: 8)
                        .foregroundStyle(Color.gray)
                        .opacity(0.3)
                }
            }
        }
        .padding()
        .background(Color.button)
        .clipShape(RoundedRectangle(cornerRadius: 20.0))
    }
}

#Preview {
    PageControl(currentPage: 0)
}
