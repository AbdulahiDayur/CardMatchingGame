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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    
    
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
        
        if cell?.card?.isFlipped == false {
            cell?.flipUp()
        } else {
            cell?.flipDown()
        }
    }
    


}

