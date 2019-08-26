//
//  CreatorCell.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit
import Kingfisher

class CreatorCell: UITableViewCell {

    @IBOutlet var creatorView: UIView!
    @IBOutlet var creatorImage: UIImageView!
    @IBOutlet var creatorLabel: UILabel!
    
    func setup(creator: Creator) {
        creatorLabel.text = creator.fullName
        setupImage(url: creator.thumbnail?.url() ?? "")
    }
    
    private func setupImage(url: String) {
        print(url)
        creatorImage.kf.indicatorType = .activity
        creatorImage.kf.setImage(
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
        creatorView.layer.cornerRadius = 15
        creatorView.layer.masksToBounds = true
        creatorLabel.layer.cornerRadius = 10
        creatorLabel.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
