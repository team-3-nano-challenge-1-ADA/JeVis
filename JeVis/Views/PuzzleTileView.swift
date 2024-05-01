//
//  PuzzleTileView.swift
//  JeVis
//
//  Created by Haliza Syafa Oktaviani on 01/05/24.
//

import SwiftUI

struct PuzzleTileView: View {
    let tile: PuzzleTile
    
    var body: some View {
        VStack{
            if let image = tile.image{
                    Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else{
                Color.background
            }
        }
        .overlay{
            RoundedRectangle(cornerRadius: 5)
                .stroke(Color.background, lineWidth: 2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

#Preview {
    PuzzleTileView(tile: PuzzleTile(image: nil, isSpareTile: true))
}
