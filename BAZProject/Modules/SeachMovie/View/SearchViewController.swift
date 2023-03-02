//
//  TopRatedViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 02/02/23.
//

import Foundation
import UIKit

class SearchViewController: UITableViewController {
    
    // The search bar used to enter search terms.
    @IBOutlet weak var searchBarMovies: UISearchBar!{
        didSet{
            searchBarMovies.returnKeyType = .done
            searchBarMovies.enablesReturnKeyAutomatically = false
            searchBarMovies.backgroundColor = .brown
            if #available(iOS 13.0, *) {
                searchBarMovies.searchTextField.leftViewMode = .never
                searchBarMovies.searchTextField.leftView = nil
                searchBarMovies.searchTextField.defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
                searchBarMovies.searchTextField.layer.borderWidth = 1
                searchBarMovies.searchTextField.layer.cornerRadius = 12
                searchBarMovies.searchTextField.layer.borderColor = UIColor.lightGray.cgColor
                searchBarMovies.searchTextField.backgroundColor = .white
            } else {
                // Fallback on earlier versions
            }
            searchBarMovies.placeholder = "¿Qué pelicula estás buscando?"
            searchBarMovies.searchBarStyle = .default
            searchBarMovies.tintColor = .black
            searchBarMovies.backgroundColor = .clear
        }
    }
    
    var movies: [Movie] = []
    let movieApi = MovieAPI()

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Configure table view
        configTableview()
        
       tableView.reloadData()
        searchBarMovies.delegate = self
       
        func configTableview(){
            tableView.register(UINib(nibName: "HomeTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Home")
        }
    }
}

// MARK: - TableView's DataSource
extension SearchViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Home") as? HomeTableViewCell else { return UITableViewCell() }
        movieApi.getImageMovie(urlString: "https://image.tmdb.org/t/p/w500\(movies[indexPath.row].poster_path)") { imageMovie in
            cell.setupCell(image: imageMovie ?? UIImage(), title: self.movies[indexPath.row].title)
        }
        return cell
    }
}
// MARK: - TableView's Delegate
extension SearchViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let destination = storyboard.instantiateViewController(withIdentifier: "DetailMovieViewController") as? DetailMovieViewController else {
            return
        }
        destination.movie = movies[indexPath.row]
        navigationController?.pushViewController(destination, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 120.0
    }
}
// MARK: - Search Bar's Delegate

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            movies = movieApi.getMovies()
            self.tableView.reloadData()
        } else {
            searchBar.showsCancelButton = true
            movieApi.searchMovies(query: searchText) { [weak self] (movies, error) in
                guard let self = self else { return }
                if let error = error {
                    print("Error searching movies: \(error.localizedDescription)")
                } else if let movies = movies {
                    self.movies = movies
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text?.removeAll()
        searchBar.showsCancelButton = false
    }
}
