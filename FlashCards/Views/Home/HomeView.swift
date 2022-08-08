//
//  HomeView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/3/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var subjectList: SubjectList
    @EnvironmentObject var flashCardList: FlashCardList
    var body: some View {
        NavigationView {
            List {
                let subjectIndices = subjectList.subjects.indices
                let subjectPairs = Array(zip(subjectList.subjects, subjectIndices))
                ForEach(subjectPairs, id: \.0.id, content: {
                    subject, index in
                    Section(content: {
                        CardsInSubjectView(subject: subject)
                    }, header: {
                        NavigationLink(destination: UpsertSubjectView(index: index, action: "Edit", name: subject.name), label: {
                            Text(subject.name).font(.title2)
                        })
                    })
                })
            }
            .navigationTitle("Flash Cards")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: UpsertFlashCardView()) {
                        Text("Add")
                    }
                }
            }
        }
    }
}
