//
//  CardCollectionViewCell.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 5/30/21.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    @IBOutlet var frontImageView: UIImageView!
    @IBOutlet var backImageView: UIImageView!
    
    var card: Card?
    
    func configureCell(card:Card) {
        
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            flipUp(speed: 0)
        }else {
            flipDown(speed: 0, delay: 0)
        }
    }
    
    func flipUp(speed: TimeInterval = 0.3) {
        UIView.transition(from: backImageView, to: frontImageView, duration: speed, options: [.showHideTransitionViews, .transitionFlipFromLeft])
        
        card?.isFlipped = true
    }
    
    
    func flipDown(speed: TimeInterval = 0.3, delay: TimeInterval = 0.5) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + delay) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.showHideTransitionViews, .transitionFlipFromLeft])
        }
        
        card?.isFlipped = false
    }
    
    func remove() {
        
        // Make imageViews invisible
        backImageView.alpha = 0
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            self.frontImageView.alpha = 0
        }, completion: nil)
    }
    
}
