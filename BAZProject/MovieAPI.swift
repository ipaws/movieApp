//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation
import UIKit

class MovieAPI {
    
    private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    let urlBase: String = "https://api.themoviedb.org"
    
    
    func getMovies() -> [Movie] {
        guard let url = URL(string: "\(urlBase)/3/trending/movie/day?api_key=\(apiKey)&language=es&region=MX&page=1"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        var movies: [Movie] = []
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                movies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
            }
        }
        return movies
    }
    
    func getImageMovie(urlString: String, completion: @escaping (UIImage?) -> ()) {
        guard let url = URL(string: urlString) else {return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if error == nil{
                guard let dataImage = data, let image = UIImage(data: dataImage) else {return}
                completion(image)
            }
        }.resume()
    }
        
    func getRatedMovies() -> [Movie]{
        guard let url = URL(string: "\(urlBase)/3/movie/top_rated?api_key=\(apiKey)&language=es&region=MX&page=1"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        var allMovies: [Movie] = []
        
        for result in results {
            if let id = result.object(forKey: "id") as? Int,
               let title = result.object(forKey: "title") as? String,
               let overview = result.object(forKey: "overview") as? String,
               let poster_path = result.object(forKey: "poster_path") as? String {
                allMovies.append(Movie(id: id, title: title, poster_path: poster_path, overview: overview))
            }
        }
        return allMovies

    }
    
    func getMovieCast(idMovie: Int) -> [Cast]{
        guard let url = URL(string: "\(urlBase)/3/movie/\(idMovie)/credits?api_key=\(apiKey)&language=es&region=MX&page=1"),
              let data = try? Data(contentsOf: url),
              let json = try? JSONSerialization.jsonObject(with: data) as? NSDictionary,
              let results = json.object(forKey: "results") as? [NSDictionary]
        else {
            return []
        }
        
        var castMovie: [Cast] = []
        
        for result in results {
            if let name = result.object(forKey: "name") as? String,
               let profile_path = result.object(forKey: "profile_path") as? String,
               let character = result.object(forKey: "character") as? String {
                castMovie.append(Cast(name: name, profile_path: profile_path, character: character))
            }
        }
        return castMovie
    }
    
    func searchMovies(query: String, completion: @escaping ([Movie]?, Error?) -> Void) {
        // construir la URL de la API para realizar la solicitud GET
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&query=\(query)"
        guard let url = URL(string: urlString) else {
            completion(nil, NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
            return
        }

        // crear la solicitud HTTP GET
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            // manejar los errores de la solicitud
            guard let data = data, error == nil else {
                completion(nil, error)
                return
            }
            
            // analizar la respuesta JSON de la API y construir un arreglo de películas
            do {
                let decoder = JSONDecoder()
                let moviesResponse = try decoder.decode(MoviesResponse.self, from: data)
                completion(moviesResponse.results, nil)
            } catch {
                completion(nil, error)
            }
        }

        // comenzar la tarea de la solicitud
        task.resume()
    }

}
