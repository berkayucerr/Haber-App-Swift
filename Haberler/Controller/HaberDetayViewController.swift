//
//  HaberDetayViewController.swift
//  Haberler
//
//  Created by Berkay ÜÇER on 29.11.2022.
//

import UIKit

class HaberDetayViewController: UIViewController {

    var label = String()
    var imageURL = String()
    @IBOutlet weak var haberLabel: UITextView!
    @IBOutlet weak var photoV: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        haberLabel.text = label
        photoV.loadFrom(from: imageURL)
        
    }
    
    @IBAction func kapat(_ sender: Any) {
        dismiss(animated: true)
    }
    
   
}
