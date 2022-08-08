//
//  CardStackView.swift
//  FlashCards
//
//  Created by Chase Dixon on 7/4/22.
//

import SwiftUI

struct CardStackView: View {
    @State var backDegree = 90.0
    @State var frontDegree = 0.0
    @State var isFlipped = true
    @State var offset = CGSize.zero
    
    @State var cards: [FlashCard]
    @State var subjectName: String
    @State var index = 0
    
    let width : CGFloat = 200
    let height : CGFloat = 250
    let durationAndDelay : CGFloat = 0.3
    
    // resets card so front is showing
    func resetCard() {
        // show the front of the card
        backDegree = 90.0
        frontDegree = 0.0
        isFlipped = true
        
        // If card has been swiped, move to other side of screen
        // before resetting for correct animation
        offset.width *= -1
        
        // reset position of card
        withAnimation(.easeInOut) {
            offset = .zero
        }
    }
    
    // flips card between front and back view
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }
    
    // view next card
    func swipeCardLeft () {
        index = (index + 1) % cards.count
        resetCard()
    }
    
    // view previous card
    func swipeCardRight () {
        if index == 0 {
            index = cards.count - 1
        } else {
            index -= 1
        }
        resetCard()
    }
    
    var body: some View {
        NavigationView {
            if (cards.isEmpty) {
                ZStack {
                    RoundedRectangle(cornerRadius: 20).fill(.white)
                        .padding().shadow(radius: 10)
                    Text("Selected subject is empty.").font(.title2)
                }
            } else {
                VStack {
                    ZStack {
                        CardFrontView(card: cards[index], degree: $frontDegree)
                        CardBackView(card: cards[index],  degree: $backDegree)
                    }.onTapGesture {
                        flipCard ()
                    } // When dragged, slide and rotate card
                    .rotationEffect(.degrees(Double(offset.width / 5)))
                    .offset(x: offset.width * 2, y: 0)
                    .opacity(2 - Double(abs(offset.width / 50)))
                    .gesture(DragGesture().onChanged() { gesture in
                        offset = gesture.translation
                    }// If card wasn't dragged far, reset position
                     // Otherwise, swipe card in direction dragged
                    .onEnded() { _ in
                        if offset.width < -100 {
                            swipeCardLeft()
                        } else if offset.width > 100 {
                            swipeCardRight()
                        } else {
                            offset = .zero
                        }
                    })
                    HStack {
                        Button(action: {
                            offset.width = 200
                            swipeCardRight()
                        }, label: { Text("Previous") })
                        Button(action: {
                            offset.width = -200
                            swipeCardLeft()
                        }, label: { Text("Next") })
                    }
                }
            }
        }.navigationTitle("Quiz - " + subjectName)
    }
}

