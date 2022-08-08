//
//  ContentView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var subjectList: SubjectList
    @EnvironmentObject var flashCardList: FlashCardList
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        TabView {
            HomeView().tabItem {
                Image(systemName: "house")
                Text("Home")
            }
            QuizView().tabItem {
                Image(systemName: "book.closed")
                Text("Quiz")
            }
        }.onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                readDatabase(flashCards: &flashCardList.flashCards, subjects: &subjectList.subjects)
            } else if newPhase == .inactive {
                writeDatabase(flashCards: &flashCardList.flashCards, subjects: &subjectList.subjects)
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(SubjectList())
            .environmentObject(FlashCardList())
    }
}
