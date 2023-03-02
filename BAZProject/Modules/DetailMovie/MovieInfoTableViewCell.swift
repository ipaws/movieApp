//
//  MovieInfoTableViewCell.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionName: UILabel!
    
    let movieApi = MovieAPI()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CastCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "castCell")
    }
}

extension MovieInfoTableViewCell: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "castCell", for: indexPath) as? CastCollectionViewCell
        else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}





extension MovieInfoTableViewCell: UICollectionViewDelegate{
}


