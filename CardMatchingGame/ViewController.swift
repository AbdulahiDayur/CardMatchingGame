//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 5/29/21.

//Having the viewController assign itself as the delegate and data source of the collectionView

//ViewController gets the data from the model and passes it to the view to be displayed
//user interaction with the view can communicate those actions to the vc to handel those events
import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    // MARK: - CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
        "CardCell", for: indexPath) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue CardCell")
        }
        
        cell.configureCell(card: cardsArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            cell?.flipUp()
            
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
                
            } else {
                checkForMatch(indexPath)
            }
        }
    }
    
    // MARK: - Game Logic Methods
    
    //Comparing Second flipped card to first
    func checkForMatch(_ secondFlippedCard: IndexPath) {
        
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCard.row]
        
        // Get the two collectionViewCells
        let cellOne = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cellTwo = collectionView.cellForItem(at: secondFlippedCard) as? CardCollectionViewCell
        
        
        if cardOne.imageName == cardTwo.imageName {
            // It's a match
            // Set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cellOne?.remove()
            cellTwo?.remove()
        }
        else {
            // It's not a match
            //Flip them back over
            cellOne?.flipDown()
            cellTwo?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    


}

