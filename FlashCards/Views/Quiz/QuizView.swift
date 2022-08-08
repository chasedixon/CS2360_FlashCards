//
//  TestView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/4/22.
//

import SwiftUI

struct QuizView: View {
    @EnvironmentObject var subjectList: SubjectList
    @EnvironmentObject var flashCardList: FlashCardList
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: {
                    CardStackView(cards: flashCardList.flashCards.shuffled(), subjectName: "All")
                }, label: { Text("All") })
                ForEach(subjectList.subjects) {
                    subject in
                    NavigationLink(destination: {
                        CardStackView(cards: flashCardList.flashCards.filter {
                            card in
                            card.subject == subject
                        }.shuffled(), subjectName: subject.name)
                    }, label: { Text(subject.name) })
                }
                
            }.navigationTitle("Select Subject")
        }
    }
}
