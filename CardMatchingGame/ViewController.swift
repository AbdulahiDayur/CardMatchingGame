//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 5/29/21.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let model = CardModel()
    var cardsArray = [Card]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsArray = model.getCards()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
        "CardCell", for: indexPath) as? CardCollectionViewCell else {
            fatalError("Unable to dequeue PersonCell")
        }
        
        
        return cell
    }
    


}

