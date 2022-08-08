//
//  CardBackView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/4/22.
//

import SwiftUI

struct CardBackView: View {
    let card: FlashCard
    @Binding var degree : Double
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .padding().shadow(radius: 10)
            VStack {
                Text(card.front).font(.title).padding()
                Text(card.back).font(.title2).padding()
            }
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}
