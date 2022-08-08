//
//  FlashCardsApp.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import SwiftUI

@main
struct FlashCardsApp: App {
    @StateObject var subjectList: SubjectList = SubjectList()
    @StateObject var flashCardList: FlashCardList = FlashCardList()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(subjectList)
                .environmentObject(flashCardList)
        }
    }
}
