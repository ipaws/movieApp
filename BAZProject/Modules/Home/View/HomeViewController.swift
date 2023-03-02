//
//  HomeViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 16/02/23.
//

import UIKit

class HomeViewController: UIViewController {
    
 
    @IBOutlet weak var tableView: UITableView!
    
    let navBar = UINavigationBar()
    
    let movieApi = MovieAPI()
    var movies: [Movie] = []
    var ratedMovies: [Movie] = []
    var imagesMovies: [UIImage] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        configTableView()
        movies = movieApi.getMovies()
        ratedMovies = movieApi.getRatedMovies()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 200
    }
    
    func configTableView(){
        tableView.dataSource = self
        tableView.register(UINib(nibName: "ratedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "ratedCell")
        tableView.register(UINib(nibName: "TrendingTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "trendingCell")
    }
}


// MARK: - TableView's DataSource

extension HomeViewController: UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 2
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         if indexPath.row == 0{
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "ratedCell") as? ratedTableViewCell else { return UITableViewCell() }
             cell.configCollectionView()
             return cell
         }else {
             guard let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell") as? TrendingTableViewCell else { return UITableViewCell() }
              
             return cell
         }
    }
    
}







