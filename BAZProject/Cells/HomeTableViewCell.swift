//
//  HomeTableViewCell.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 03/02/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    
    func setupCell(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.imgView.image = image
            self.labelTitle.text = title
        }
    }
 
}
