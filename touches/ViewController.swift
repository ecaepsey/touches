//
//  ViewController.swift
//  touches
//
//  Created by yespeace on 20/1/21.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = ConcentrationGame(numberOfPairsCards: (buttonCollection.count  + 1) / 2)
    
    
    
    
    var touches = 0 {
        didSet {
            Tochable.text =
            "Touches: \(touches)"
        }
    }
    
    
    
    var emojiCollection = ["😎","😉"]
    
    
    var emojiDictionary = [Int: String]()
    
    func emojiIdentifier(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiCollection.count)))
            emojiDictionary[card.identifier] = emojiCollection.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    

    @IBOutlet var buttonCollection: [UIButton]!
    
    func updateViewFromModel() {
        for index in buttonCollection.indices {
            let button = buttonCollection[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emojiIdentifier(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: .normal
                )
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0): #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
            }
            
        }
    }
    
    @IBOutlet weak var Tochable: UILabel!
    @IBAction func buttonAction(_ sender: UIButton) {
        touches += 1
        if let buttonIndex = buttonCollection.firstIndex(of: sender) {
            game.choosedCard(at: buttonIndex)
            updateViewFromModel()
        }
       
    }
}

