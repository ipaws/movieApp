//
//  ratedTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 01/03/23.
//

import UIKit

class ratedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var ratedCollectionView: UICollectionView!
    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var ratedMovies: [Movie] = []
    var imagesMovies: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
        ratedCollectionView.reloadData()
        ratedMovies = movieApi.getRatedMovies()
        ratedCollectionView.reloadData()
    }
    
    func configCollectionView(){
        ratedCollectionView.dataSource = self
        ratedCollectionView.delegate = self
        ratedCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 310, height: 400)
        ratedCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            ratedMovies = []
            ratedCollectionView.reloadData()
        }
    
}

//MARK: CollectionView's Delegate
extension ratedTableViewCell: UICollectionViewDelegate {
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController else {
            return
        }
        destination.movie = ratedMovies[indexPath.row]
//        navigationController?.pushViewController(destination, animated: true)
    }
    
    
}
//MARK: CollectionView's DataSource

extension ratedTableViewCell: UICollectionViewDataSource{
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as? MovieCollectionViewCell
        else { return UICollectionViewCell() }
         
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(ratedMovies[indexPath.row].poster_path)") { imageMovie in
            cell.setupCollectionCell(image: imageMovie ?? UIImage(), title: self.ratedMovies[indexPath.row].title)
        }
         //cell.imageMovie.image = UIImage(named: "poster")
        return cell
    }
    
}

