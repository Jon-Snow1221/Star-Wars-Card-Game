//
//  CharacterCollectionViewCell.swift
//  StarWarsCardGame
//
//  Created by Jonathan Llewellyn on 11/9/21.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var characterImageView: UIImageView!
    
    //Tells the cell which image to display for each character. Scales photo to fit in the cell.
    func displayImageForCharacter(for character: Character) {
        characterImageView.image = character.photo
        characterImageView.contentMode = .scaleAspectFill
        characterImageView.clipsToBounds = true
    }
}
