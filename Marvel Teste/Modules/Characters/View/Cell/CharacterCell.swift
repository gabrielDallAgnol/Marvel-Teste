//
//  CharacterCell.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Kingfisher

class CharacterCell: UITableViewCell {

    @IBOutlet var charImageView: UIImageView!
    @IBOutlet var charLabelName: UILabel!
    @IBOutlet var charView: UIView!
    
    func setup(char: Character) {
        charLabelName.text = char.name
        setupImage(url: char.thumbnail?.url() ?? "")
    }
    
    private func setupImage(url: String) {
        print(url)
        charImageView.kf.indicatorType = .activity
        charImageView.kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: Constants.imagePlaceholder),
            options: [
                .transition(.fade(0.3)),
            ])
        {
            result in
            switch result {
            case .success( _):
                self.setNeedsLayout()
            case .failure(let error):
                print("Job failed: \(error.localizedDescription)")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        charView.layer.cornerRadius = 15
        charView.layer.masksToBounds = true
        charLabelName.layer.cornerRadius = 10
        charLabelName.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
