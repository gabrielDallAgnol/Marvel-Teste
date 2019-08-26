//
//  CharacterDetailController.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterDetailController: UIViewController {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var char: Character!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = char.name
        descriptionLabel.text = char.description
        
        imageView.kf.indicatorType = .activity
        imageView.kf.setImage(
            with: URL(string: char.thumbnail?.url() ?? ""),
            placeholder: UIImage(named: Constants.imagePlaceholder),
            options: [
                .transition(.fade(0.3)),
            ])
        {
            result in
            switch result {
            case .success( _):
                self.viewDidLayoutSubviews()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
}
