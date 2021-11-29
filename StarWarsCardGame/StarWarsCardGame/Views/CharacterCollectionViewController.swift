//
//  CharacterCollectionViewController.swift
//  StarWarsCardGame
//
//  Created by Jonathan Llewellyn on 11/9/21.
//

import UIKit

class CharacterCollectionViewController: UICollectionViewController {
    
    private var displayedCharacters: [Character] = []
    private var targetCharacter: Character?
    private var selectedFaction = "jedi"

    override func viewDidLoad() {
        super.viewDidLoad()
        shuffleCharacters(for: selectedFaction)
        
    }
    // Populates 3 elements from jedi/sith array(SOT), then sets target character to a random character from opposing faction
    func shuffleCharacters(for faction: String) {
        if faction == "jedi" {
            CharacterController.jedi.shuffle()      // Shuffles the array of jedi to get more randomized options
            let jediGroup = CharacterController.jedi.prefix(3)
            displayedCharacters = Array(jediGroup)
            targetCharacter = CharacterController.sith.randomElement()
        } else if faction == "sith" {
            CharacterController.sith.shuffle()
            let sithGroup = CharacterController.sith.prefix(3)
            displayedCharacters = Array(sithGroup)
            targetCharacter = CharacterController.jedi.randomElement()
        }
        updateViews()
    }
    // MARK: - Helper Functions:
    
    // Unwrap target character, then add targetCharacter to displayedCharacters array, then update view
    func updateViews() {
        guard let character = targetCharacter else {return}
        displayedCharacters.append(character)
        displayedCharacters.shuffle()   //Randomizes displayed characters
        collectionView.reloadData()
        title = "Find \(character.name)"    // To display instructions on which character to find
    }
    // Present Alert helper function. Compares user selected character and the targetCharacter.
    func presentAlert(for character: Character) {
        let success = character == targetCharacter
        
        // ternary operator for success message. If click correct character display "good job", else display "try again".
        let alertController = UIAlertController(title: success ? "Good Job!" : "Try Again!", message: nil, preferredStyle: .alert)
        
        let doneAction = UIAlertAction(title: "Done", style: .cancel)
        let shuffleAction = UIAlertAction(title: "Shuffle!", style: .default) {
            _ in self.shuffleCharacters(for: self.selectedFaction)
        }
        
        alertController.addAction(doneAction)
        
        if success {
            alertController.addAction(shuffleAction)
        }
        //Tell the viewController to present it to the user:
        present(alertController, animated: true)
    }
    
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FilterVIewController" {
            let vc = segue.destination as? FilterViewController
            vc?.delegate = self
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // Array count of objects from SOT
        return displayedCharacters.count
    }
    
    // How the cells(character images) will be displayed to the user:
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "characterCell", for: indexPath) as? CharacterCollectionViewCell else {return UICollectionViewCell()}
      
        let character = displayedCharacters[indexPath.row]
        cell.displayImageForCharacter(for: character)
    
        return cell
    }

    // MARK: UICollectionViewDelegate
    //Present AlertController to user to let them know if they chose the correct targetCharacter or not
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let character = displayedCharacters[indexPath.row]

        presentAlert(for: character)
    }

}

extension CharacterCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = view.frame.width / 2
        return CGSize(width: width - 15, height: width + 30)
    }
}

extension CharacterCollectionViewController: FilterSelectionDelegate {
    func selected(faction: String) {
        selectedFaction = faction
        shuffleCharacters(for: selectedFaction)
    }
}
