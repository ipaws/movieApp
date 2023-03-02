//
//  CastCollectionViewCell.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class CastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var actorImage: UIImageView!
    @IBOutlet weak var actorName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCell(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.actorImage.image = image
            self.actorName.text = title
            self.actorImage.clipsToBounds = true
            self.actorImage.layer.cornerRadius = self.actorImage.frame.width/2.0
        }
    }
}
