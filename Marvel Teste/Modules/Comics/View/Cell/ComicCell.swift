//
//  ComicCell.swift
//  Marvel Teste
//
//  Created by Palmsoft  on 26/08/19.
//  Copyright © 2019 Gabriel. All rights reserved.
//

import UIKit

class ComicCell: UITableViewCell {

    @IBOutlet var comicImageView: UIImageView!
    @IBOutlet var comicLabelName: UILabel!
    @IBOutlet var comicView: UIView!
    
    
    func setup(comic: Comic) {
        comicLabelName.text = comic.title
        setupImage(url: comic.thumbnail?.url() ?? "")
    }
    
    private func setupImage(url: String) {
        print(url)
        comicImageView.kf.indicatorType = .activity
        comicImageView.kf.setImage(
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
        comicView.layer.cornerRadius = 15
        comicView.layer.masksToBounds = true
        comicLabelName.layer.cornerRadius = 10
        comicLabelName.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
