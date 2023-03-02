//
//  TrendingTableViewCell.swift
//  MovieBucket
//
//  Created by Brenda Paola Lara Moreno on 02/03/23.
//

import UIKit

class TrendingTableViewCell: UITableViewCell {

    @IBOutlet weak var trendingCollectionView: UICollectionView!
    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var ratedMovies: [Movie] = []
    var imagesMovies: [UIImage] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
        setUpCell()
        trendingCollectionView.reloadData()
        ratedMovies = movieApi.getRatedMovies()
    }
    
    func configCollectionView(){
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        trendingCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "movieCell")
    }
    
    func setUpCell() {
        let configureCell = UICollectionViewFlowLayout()
        configureCell.scrollDirection = .horizontal
        configureCell.itemSize =  CGSize(width: 310, height: 400)
        trendingCollectionView.setCollectionViewLayout(configureCell, animated: false)
    }
    
}


//MARK: CollectionView's Delegate
extension TrendingTableViewCell: UICollectionViewDelegate {
    
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

extension TrendingTableViewCell: UICollectionViewDataSource{
    
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


    
   
