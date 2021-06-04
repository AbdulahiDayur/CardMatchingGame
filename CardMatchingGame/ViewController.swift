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
    
    @IBOutlet var timerLabel: UILabel!
    
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var timer: Timer?
    var milliseconds: Int = 10 * 1000
    
    var soundPlayer = SoundManager()
    
    
    var firstFlippedCardIndex: IndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // Initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //play shuffle sound
        soundPlayer.playSound(effect: .shuffle)
        
    }
    
    // MARK - Timer Methods
    
    @objc func timerFired() {
        // Decrement the counter
        milliseconds -= 1
        
        // Update the label
        let seconds: Double = Double(milliseconds)/1000.0
        timerLabel.text = String(format: "Time Remaining: %.2f", seconds)
        
        // Stop the timer if it reaches Zero
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
        }
        
        // Check if the user has cleared all the pairs
        checkForGameEnd()
    }
    
    
    // MARK: - CollectionView Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardsArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//        "CardCell", for: indexPath) as? CardCollectionViewCell else {
//            fatalError("Unable to dequeue CardCell")
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        // Configure the state of the cell based on the properties of the Card that it represents
        let Customcell = cell as? CardCollectionViewCell
        
        // Get the card from the card array
        let card = cardsArray[indexPath.row]
        
        // Finish configuring the cell
        Customcell?.configureCell(card: card)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionViewCell
        
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false {
            cell?.flipUp()
            //play flip sound
            soundPlayer.playSound(effect: .Flip)
            
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
            //play match sound
            soundPlayer.playSound(effect: .match)
            
            // Set the status and remove them
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cellOne?.remove()
            cellTwo?.remove()
            
            // Was that the last pair?
            checkForGameEnd()
        }
        else {
            // It's not a match
            
            //play no sound
            soundPlayer.playSound(effect: .nomatch)
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            //Flip them back over
            cellOne?.flipDown()
            cellTwo?.flipDown()
        }
        
        // Reset the firstFlippedCardIndex property
        firstFlippedCardIndex = nil
    }
    
    func checkForGameEnd() {
        
        // Check if any card is unmatched
        var hasWon = true
        
        for card in cardsArray {
            if card.isMatched == false {
                hasWon = false
                break
            }
        }
        
        if hasWon {
            showAlert(title: "YOU WON", message: "You've managed to match all the cards!")
        } else {
            
            if milliseconds <= 0 {
                showAlert(title: "TIme's up Bud", message: "Better luck next time....LOSER")
            }
        }
        
        
    }
    
    func showAlert(title: String, message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: nil))
        present(ac, animated: true)
    }


}

