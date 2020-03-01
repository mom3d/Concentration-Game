//
//  ViewController.swift
//  Playing Card
//
//  Created by Mohamed Saidi on 10/16/19.
//  Copyright © 2019 Mohamed Saidi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    typealias ThemeValues = (emoji: String, backgroundColor: UIColor, cardBackgroundColor: UIColor)
    //MARK: Proprties
    lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
     var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    var gameThemes: [String:ThemeValues] = ["Faces": ("😀😜😍😂😰🙄🤐🤫😤😕🥳🥺🥶", #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1), #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)),
                                         "Hallowen": ("😈🎃👻💀☠️👽🤖🧛🏽‍♂️🧛‍♀️🧙🏻‍♀️🧙‍♂️😱", #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1), #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)),
                                         "Sport": ("⚽️🏀🏈⚾️🥎🎾🏐🏉🥏🎱🏓🏸🏒🏑", #colorLiteral(red: 0.9835994566, green: 1, blue: 0.1620211964, alpha: 1), #colorLiteral(red: 0.3925954299, green: 0.3681688612, blue: 0.4762055838, alpha: 1)),
                                         "Hands": ("🤟🖕🏿💪👋👈🖖", #colorLiteral(red: 0.7960620241, green: 0.2154051263, blue: 0.1640470997, alpha: 1), #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)),
                                         "Animals": ("🐶🐱🐭🐹🐰🦊🐻🐼🐨🐯🦁🐮🐷", #colorLiteral(red: 0.5257177982, green: 0.374618169, blue: 0.0431074147, alpha: 1), #colorLiteral(red: 0.3600439153, green: 0.7960620241, blue: 0.08363649527, alpha: 1)),
                                         "Flags": ("🇹🇳🇳🇮🇧🇷🇧🇪🇧🇭🏴‍☠️🇩🇿🏴󠁧󠁢󠁥󠁮󠁧󠁿🇮🇱🇫🇷🇮🇳🇺🇸", #colorLiteral(red: 0.4158430321, green: 0.5379061057, blue: 0.8101007297, alpha: 1), #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
                                         
    ]
    var emoji = [Card:String]()
    lazy var emojiChoices = theme.emoji
    var newTheme: ThemeValues {
        let randomIndex = Int.random(in: 0..<gameThemes.count)
        let key = Array(gameThemes.keys)[randomIndex]
        return gameThemes[key]!
    }
    var theme: ThemeValues! {
        didSet {
            view.backgroundColor = theme.backgroundColor
            cardButtons.forEach {
                $0.backgroundColor = theme.cardBackgroundColor
                $0.setTitle("", for: .normal)
            }
            flipCountLabel.textColor = theme.cardBackgroundColor
            scoreLabel.textColor = theme.cardBackgroundColor
            newGameButton.backgroundColor = theme.cardBackgroundColor
            
            
        }
    }
    //MARK: Outlets
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.cornerRadius = 20
        newGameButton.clipsToBounds = true
        startNewGame()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: Methods
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCounts)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = .white
                
            }else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? .clear : theme.cardBackgroundColor
                
            }
        }
        
    }
    func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojiChoices.count > 0 {
            let randomIndex = Int.random(in: 0..<emojiChoices.count)
            let stringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: randomIndex)
            emoji[card] = String(emojiChoices.remove(at: stringIndex))
            
        }
        return emoji[card] ?? "🖕🏿"
    }
    func startNewGame() {
        
        theme = newTheme
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        flipCountLabel.text = "\(game.flipCounts)"
        emoji = [:]
        emojiChoices = theme.emoji
        updateViewFromModel()
    }
    //MARK: Actions
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.firstIndex(of: sender) {
             game.chooseCard(at:cardNumber)
        }
        updateViewFromModel()
       
    }
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        startNewGame()
    }
    
}

