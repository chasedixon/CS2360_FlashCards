//
//  Subject.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation

struct Subject: Identifiable, Hashable {
    var id: UUID = UUID()
    var name: String
}
