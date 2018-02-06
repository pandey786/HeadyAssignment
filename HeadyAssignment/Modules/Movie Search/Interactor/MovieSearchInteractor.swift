//
//  MovieSearchInteractor.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class MovieSearchInteractor: MovieSearchUseCase {
    
    var output: MovieSearchInteractorOutput!
    
    func fetchMoviesList(for searchText: String, pageCount: Int) {
        
        //Fetch Movies List
        MovieSearchApiService.fetchMoviesList(searchText, pageCount: pageCount) { (movieResultModel, isError, errorString) in
            
            //Check for Error
            if !isError {
                
                //No Error
                if let movieListArr = movieResultModel?.results {
                    
                    //List fetched successfully
                   self.output.moviesListFetchedSuccessfully(movieListArr)
                } else {
                    
                    //No data Received or data could not be parsed
                    self.output.moviesListFetchFailed()
                }
            } else {
                
                //Error
                self.output.moviesListFetchFailed()
            }
        }
    }
}
