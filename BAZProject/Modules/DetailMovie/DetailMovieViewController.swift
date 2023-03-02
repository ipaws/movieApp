//
//  DetailMovieViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 02/02/23.
//


import Foundation
import UIKit

class DetailMovieViewController: UIViewController{
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var rateMovie: UILabel!
    @IBOutlet weak var resumeMovie: UILabel!
    @IBOutlet weak var datePremiere: UILabel!
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieNameLabel.text = movie?.title
        resumeMovie.text = movie?.overview
        rateMovie.text = "⭐️⭐️⭐️⭐️"
        
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(movie?.poster_path ?? "")") { imageMovie in
            self.setupImage(image: imageMovie ?? UIImage(), title: self.movie?.title ?? "")
        }
        
    }
    func setupImage(image: UIImage, title: String){
        DispatchQueue.main.async {
            self.imageMovie.image = image
        }
        
    }
}




