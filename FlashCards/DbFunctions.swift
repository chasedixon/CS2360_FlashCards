//
//  DbFunctions.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/1/22.
//

import Foundation
import SwiftUI
import SQLite3

// Initialize database with Subject and FlashCard tables
func initDatabase() -> OpaquePointer? {
    var db: OpaquePointer?
    
    let fileName = try!
        FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("FlashCards.sqlite")
    
    if sqlite3_open(fileName.path, &db) != SQLITE_OK {
        print("Error opening database")
    }
    
    let createSubjectTableQuery = "CREATE TABLE IF NOT EXISTS Subject (id VARCHAR PRIMARY KEY, name VARCHAR)"
    
    
    if sqlite3_exec(db, createSubjectTableQuery, nil, nil, nil) != SQLITE_OK {
        print("Error creating table")
    }
    
    let createFlashCardTableQuery = "CREATE TABLE IF NOT EXISTS FlashCard (id INTEGER PRIMARY KEY AUTOINCREMENT, front VARCHAR, back VARCHAR, subject VARCHAR, FOREIGN KEY(subject) REFERENCES Subject(id))"
    
    if sqlite3_exec(db, createFlashCardTableQuery, nil, nil, nil) != SQLITE_OK {
        print("Error creating table")
    }
    
    return db
}

// Write given subjects and flash cards to database
func writeDatabase(flashCards: inout [FlashCard], subjects: inout [Subject]) {
    let db = initDatabase()
    let SQLITE_TRANSIENT = unsafeBitCast(OpaquePointer(bitPattern: -1), to: sqlite3_destructor_type.self)
    
    // Clear existing tables
    let clearCardsQuery = "DELETE FROM FlashCard"
    let clearSubjectsQuery = "DELETE FROM Subject"
    
    if sqlite3_exec(db, clearCardsQuery, nil, nil, nil) != SQLITE_OK {
        print("Error clearing cards table")
    }
    
    if sqlite3_exec(db, clearSubjectsQuery, nil, nil, nil) != SQLITE_OK {
        print("Error clearing subjects table")
    }
    
    // Insert subjects
    subjects.forEach { subject in
        var stmt: OpaquePointer?
        
        let insertQuery = "INSERT INTO Subject (id, name) VALUES (?, ?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
            print("Error binding query")
        }
        
        if sqlite3_bind_text(stmt, 1, subject.id.uuidString, -1, nil) != SQLITE_OK {
            print("Error binding subject id")
        }
        
        if sqlite3_bind_text(stmt, 2, subject.name, -1, nil) != SQLITE_OK {
            print("Error binding subject name")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("Error inserting Subject")
        }
    }
    
    // Insert cards
    flashCards.forEach { card in
        print(card.front, card.back, card.subject.name)
        var stmt: OpaquePointer?
        
        let insertQuery = "INSERT INTO FlashCard (front, back, subject) VALUES (?, ?, ?)"
        
        if sqlite3_prepare_v2(db, insertQuery, -1, &stmt, nil) != SQLITE_OK {
            print("Error binding query")
        }
        
        if sqlite3_bind_text(stmt, 1, card.front, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding card front")
        }
        
        if sqlite3_bind_text(stmt, 2, card.back, -1, SQLITE_TRANSIENT) != SQLITE_OK {
            print("Error binding card back")
        }
        
        if sqlite3_bind_text(stmt, 3, card.subject.id.uuidString, -1, nil) != SQLITE_OK {
            print("Error binding card subject")
        }
        
        if sqlite3_step(stmt) != SQLITE_DONE {
            print("Error inserting Card")
        }
    }
}

// Read subjects and flash cards from database
func readDatabase(flashCards: inout [FlashCard], subjects: inout [Subject]) {
    subjects.removeAll()
    flashCards.removeAll()
    
    let db = initDatabase()
    
    let selectSubjectsQuery = "SELECT id, name FROM Subject"
    
    var stmt: OpaquePointer?
    
    if sqlite3_prepare(db, selectSubjectsQuery, -1, &stmt, nil) == SQLITE_OK {
        while sqlite3_step(stmt) == SQLITE_ROW {
            let id = String(cString: sqlite3_column_text(stmt, 0))
            let name = String(cString: sqlite3_column_text(stmt, 1))
            
            subjects.append(Subject(id: UUID(uuidString: id)!, name: name))
        }
    }
    
    let selectCardsQuery = "SELECT front, back, subject FROM FlashCard"
    
    if sqlite3_prepare(db, selectCardsQuery, -1, &stmt, nil) == SQLITE_OK {
        while sqlite3_step(stmt) == SQLITE_ROW {
            let front = String(cString: sqlite3_column_text(stmt, 0))
            let back = String(cString: sqlite3_column_text(stmt, 1))
            let subjectId = String(cString: sqlite3_column_text(stmt, 2))
            let subject = subjects.first { $0.id.uuidString == subjectId }
            
            flashCards.append(FlashCard(front: front, back: back, subject: subject!))
        }
    }
}
