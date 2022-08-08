//
//  FlashCard.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation

struct FlashCard: Identifiable {
    let id = UUID()
    var front: String
    var back: String
    var subject: Subject
}
