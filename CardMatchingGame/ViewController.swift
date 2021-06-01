//
//  ViewController.swift
//  CardMatchingGame
//
//  Created by Abdul Dayur on 5/29/21.
//

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
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
//        "CardCell", for: indexPath) as? CardCollectionViewCell else {
//            fatalError("Unable to dequeue CardCell")
//        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)


        return cell
    }
    


}

