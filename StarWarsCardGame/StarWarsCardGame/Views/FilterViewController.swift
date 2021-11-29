//
//  FilterViewController.swift
//  StarWarsCardGame
//
//  Created by Jonathan Llewellyn on 11/9/21.
//

import UIKit

protocol FilterSelectionDelegate : AnyObject {
    //Inform the delegate of the user's selection:
    func selected(faction: String)
}

class FilterViewController: UIViewController {
    
    //Delegate to handle the selected method from Protocol:
    weak var delegate: FilterSelectionDelegate?
    
    
    // ACTIONS
    @IBAction func sithButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "sith")
        self.dismiss(animated: true)
    }
    
    
    @IBAction func jediButtonTapped(_ sender: Any) {
        delegate?.selected(faction: "jedi")
        self.dismiss(animated: true)
    }
    



}
