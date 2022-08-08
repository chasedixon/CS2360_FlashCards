//
//  FlashCardsList.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation

public class FlashCardList: ObservableObject {
    @Published var flashCards: [FlashCard]
    
    init() {
        self.flashCards = []
    }
}
