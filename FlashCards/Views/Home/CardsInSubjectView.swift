//
//  EditSubjectView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
import SwiftUI

struct CardsInSubjectView: View {
    @EnvironmentObject var flashCardList: FlashCardList
    var subject: Subject
    var body: some View {
        let flashCardEnum = flashCardList.flashCards.enumerated()
        let flashCards = flashCardEnum.filter {
            index, card in
            card.subject == subject
        }
        ForEach(flashCards, id: \.1.id) {
            index, card in
            NavigationLink(destination: UpsertFlashCardView(action: "Edit", index: index, front: card.front, back: card.back, subject: card.subject), label: {
                VStack {
                    Text(card.front).font(.title2)
                    Text(card.back).font(.title3)
                }
            })
        }.onDelete(perform: { indexSet in
            var listIndexSet = IndexSet()
            indexSet.forEach { i in
                listIndexSet.insert(flashCards[i].offset)
            }
            flashCardList.flashCards.remove(atOffsets: listIndexSet)
        })
    }
}
