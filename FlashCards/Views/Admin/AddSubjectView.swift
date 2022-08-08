//
//  EditSubjectView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
import SwiftUI

struct AddSubjectView: View {
    @EnvironmentObject var subjectList: SubjectList
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var name: String = ""
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Subject: ")
                    TextField(text: $name, label: { Text("Subject") })
                }
                Spacer()
            }
            .navigationTitle("Add Subject")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: { self.presentationMode.wrappedValue.dismiss()}) {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        let subject = Subject(name: name)
                        subjectList.subjects.append(subject)
                        self.presentationMode.wrappedValue.dismiss()}) {
                        Text("Save")
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}
