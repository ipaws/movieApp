//
//  TopRatedViewController.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 02/02/23.
//

import Foundation
import UIKit

class SearchiewController: UITableViewController {

    var topRated: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        let movieApi = MovieAPI()
        
        topRated = movieApi.getTopRated()
        tableView.reloadData()
    }

}

// MARK: - TableView's DataSource

extension SearchiewController {

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        topRated.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.dequeueReusableCell(withIdentifier: "TrendingTableViewCell")!
    }

}

// MARK: - TableView's Delegate

extension SearchiewController {

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var config = UIListContentConfiguration.cell()
        config.text = movies[indexPath.row].title
        config.image = UIImage(named: "poster")
        cell.contentConfiguration = config
    }

}
