//
//  MovieCollectionViewCell.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 28/02/23.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var nameMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupCollectionCell(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.imageMovie.image = image
            self.nameMovie.text = title
            self.imageMovie.clipsToBounds = true
            self.imageMovie.layer.cornerRadius = 25
        }
    }

}
