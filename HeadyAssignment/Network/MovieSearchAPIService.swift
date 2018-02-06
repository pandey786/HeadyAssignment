//
//  MovieSearchApiService.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper

class MovieSearchApiService {
    
    static func fetchMoviesList(_ searchText: String, pageCount: Int, completionHandler: @escaping (_ moviesList: MovieSearchResultModel?, _ isError: Bool, _ error: String?) -> ()) {
        
        let params = ["api_key": API.movieDBAPIKey,
                      "query": searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)! ,
                      "page": pageCount] as [String : Any]
 
        Alamofire.request(API.movieDBMovieSearchUrl, method: .get, parameters: params, encoding: URLEncoding.default, headers: nil)
            .validate()
            .responseString(completionHandler: { (responseString) in
                print(responseString.value ?? "Could not get proper response")
            })
            .responseObject { (response: DataResponse<MovieSearchResultModel>) in
                
                switch response.result {
                case .success(let movieResultModel):
                    
                    //Response received successfully
                    completionHandler(movieResultModel, false, nil)
                    break
                case .failure(let error):
                    
                    //There was an error
                    completionHandler(nil, true, error.localizedDescription)
                    break
                }
        }
    }
}
