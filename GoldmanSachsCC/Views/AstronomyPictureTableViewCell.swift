//
//  AstronomyPictureTableViewCell.swift
//  GoldmanSachsCC
//
//  Created by Sai Pasumarthy on 30/01/22.
//

import UIKit
import SDWebImage

/**
    This class represents the custom AstronomyPictureTableViewCell
*/
class AstronomyPictureTableViewCell: UITableViewCell {
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var pictureTitleLabel: UILabel!
    @IBOutlet weak var pictureDate: UILabel!
    @IBOutlet weak var pictureExplanation: UILabel!
    @IBOutlet weak var favouritePictureImageView: UIImageView!
    
    weak var pictureCellDelegate: AstronomyPictureCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(updateFavorites))
        favouritePictureImageView.addGestureRecognizer(tapGesture)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateAstronomyPicture(astronomyPicture: AstronomyPicture) {
        if astronomyPicture.media_type == "video" {
            pictureImageView.image = UIImage(named: "Video")
        } else {
            pictureImageView.sd_setImage(with: URL(string: astronomyPicture.url), placeholderImage: UIImage(named: "Placeholder"))
        }
        
        if astronomyPicture.favourite {
            favouritePictureImageView.image = UIImage(named: "FavouriteFilled")
        } else {
            favouritePictureImageView.image = UIImage(named: "Favourite")
        }
        
        pictureTitleLabel.text = astronomyPicture.title
        pictureDate.text = astronomyPicture.date
        pictureExplanation.text = astronomyPicture.explanation
    }
    
}

extension AstronomyPictureTableViewCell {
    @objc func updateFavorites() {
        pictureCellDelegate?.updateFavourites(for: self)
    }
}
