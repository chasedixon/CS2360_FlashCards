//
//  CardView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/3/22.
//

import SwiftUI

struct CardFrontView: View {
    let card: FlashCard
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .padding().shadow(radius: 10)
            Text(card.front).font(.title)
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
