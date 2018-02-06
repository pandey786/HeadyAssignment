//
//  MovieSearchPresenter.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation

class MovieSearchPresenter: MovieSearchPresentation {
    
    var view: MovieSearchView?
    var interactor: MovieSearchUseCase!
    var router: MovieSearchWireframe!
    
    var movieSearchResults = [MovieSearchModel]()
    
    func viewDidLoad() {
        
    }
    
    func fetchMoviesList(for searchText: String, pageCount: Int) {
        
        //Show Activity Indicator for first page
        if pageCount == 1 {
            view?.showActivityIndicator()
        }
        
        //fetch Movies
        interactor.fetchMoviesList(for: searchText, pageCount: pageCount)
    }

}

extension MovieSearchPresenter: MovieSearchInteractorOutput {
    
    func moviesListFetchedSuccessfully(_ movieSearchModel: [MovieSearchModel]) {
        self.movieSearchResults = movieSearchModel
        
        view?.hideActivityIndicator()
        view?.showMovieList(self.movieSearchResults)
    }
    
    func moviesListFetchFailed() {
        view?.hideActivityIndicator()
        view?.showNoContentScreen()
    }
}

