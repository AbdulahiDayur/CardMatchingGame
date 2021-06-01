//
//  CardModel.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 5/29/21.
//

//responsible for the data

import Foundation

class CardModel {
    
    //method that generates the cards
    func getCards() -> [Card] {
        
        var generatedCards = [Card]()
        var arr = [Int]()
        var i = 0
        
        while i < 8 {
            
            var randNum = Int.random(in: 1...13)
                
            let firstCard = Card()
            let secCard = Card()
            
            if !arr.contains(randNum){
                firstCard.imageName = "card\(randNum)"
                secCard.imageName = "card\(randNum)"
                
                generatedCards += [firstCard, secCard]
                
                arr.append(randNum)
                print(randNum)
            } else {
                randNum = Int.random(in: 1...13)
                i -= 1
            }
            
            i += 1
        }
        
        //Randomize the cards within the array
        generatedCards.shuffle()
        
        return generatedCards
    }
}
