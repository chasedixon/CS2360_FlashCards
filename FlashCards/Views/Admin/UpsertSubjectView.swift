//
//  UpsertSubjectView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
import SwiftUI

// View to Update or Insert new subject
struct UpsertSubjectView: View {
    @EnvironmentObject var subjectList: SubjectList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var index: Int?
    @State var action: String = "Add"
    @State var name: String = ""
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Subject: ")
                    TextField(text: $name, label: { Text("Subject") })
                }
                if (index != nil) {
                    Button(action: {
                        subjectList.subjects.remove(at: index!)
                    }, label: { Text("Delete Subject") })
                }
            }
            .navigationTitle(action + " Subject")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        if index == nil {
                            subjectList.subjects.append(Subject(name: name))
                        } else {
                            subjectList.subjects[index!].name = name
                        }
                        self.presentationMode.wrappedValue.dismiss()}) {
                        Text("Save")
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}
