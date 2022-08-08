//
//  EditFlashCardView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
import SwiftUI

struct UpsertFlashCardView: View {
    @EnvironmentObject var subjectList: SubjectList
    @EnvironmentObject var flashCardList: FlashCardList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var action: String = "Add"
    @State var index: Int?
    @State var front: String = ""
    @State var back: String = ""
    @State var subject: Subject = Subject(name: "")
    @State private var subjectAlert = false
    @State private var deleteConfirmation = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    HStack {
                        Text("Front: ")
                        TextField(text: $front, label: { Text("Front") })
                    }
                    HStack {
                        Text("Back: ")
                        TextField(text: $back, label: { Text("Back") })
                    }
                    
                    HStack {
                        Text("Subject: ")
                        Picker(selection: $subject, label: Text("Subject")) {
                            ForEach(subjectList.subjects) { subject in
                                Text(subject.name).tag(subject)
                            }
                        }.pickerStyle(.menu)
                    }
                    NavigationLink(destination: UpsertSubjectView()) {
                        Image(systemName: "plus.circle")
                        Text("Add new Subject")
                    }
                    if( index != nil) {
                        Button("Delete Card", role: .destructive, action: {
                            deleteConfirmation = true
                        })
                        .confirmationDialog("Are you sure?", isPresented: $deleteConfirmation, titleVisibility: .visible) {
                            Button("Yes", role: .destructive, action: {
                                flashCardList.flashCards.remove(at: index!)
                            })
                        }
                    }
                }
                Spacer()
            }
                .navigationTitle(action + " Flash Card")
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                            Text("Cancel")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            if (subject.name.isEmpty) {
                                subjectAlert = true
                            }
                            else {
                                if(index == nil) {
                                    let flashCard = FlashCard(front: front, back: back, subject: subject)
                                    flashCardList.flashCards.append(flashCard)
                                    self.presentationMode.wrappedValue.dismiss()
                                } else {
                                    flashCardList.flashCards[index!].front = front
                                    flashCardList.flashCards[index!].back = back
                                    flashCardList.flashCards[index!].subject = subject
                                    self.presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }.alert("Please select a subject.", isPresented: $subjectAlert) {
                            Button("Ok", role: .cancel) {}
                        }
                    }
                }
        }.navigationBarHidden(true)
    }
}
