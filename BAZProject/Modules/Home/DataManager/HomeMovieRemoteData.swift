//
//  HomeMovieRemoteData.swift
//  BAZProject
//
//  Created by Brenda Paola Lara Moreno on 24/02/23.
//

import Foundation

final class HomeMovieRemoteData{
    weak var interactor: HomeRemoteDataOutputProtocol?
    let api: MovieAPI
    init(api: MovieAPI) {
        self.api = api
    }
    
}

extension HomeMovieRemoteData: HomeRemoteDataInputProtocol{
    func getMovies(){
      let movies =  api.getMovies()
        interactor?.didGetMovies()
    }
}
