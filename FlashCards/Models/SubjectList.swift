//
//  SubjectsList.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
public class SubjectList: ObservableObject {
    @Published var subjects: [Subject]
    
    init() {
        self.subjects = []
    }
}
