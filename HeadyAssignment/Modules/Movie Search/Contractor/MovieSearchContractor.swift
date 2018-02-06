//
//  MovieSearchContractor.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

protocol MovieSearchView: IndicatableView {
    
    var presenter: MovieSearchPresentation! { get set }
    
    func showMovieList(_ movieSearchModel: [MovieSearchModel])
    func showNoContentScreen()
    func clearLastSearchedData()
}

protocol MovieSearchPresentation: class {
    
    weak var view: MovieSearchView? { get set }
    var interactor: MovieSearchUseCase! { get set }
    var router: MovieSearchWireframe! { get set }
    
    func viewDidLoad()
    func fetchMoviesList(for searchText: String, pageCount: Int)
}

protocol MovieSearchUseCase: class {
    
    var output: MovieSearchInteractorOutput! { get set }
    
    func fetchMoviesList(for searchText: String, pageCount: Int)
}

protocol MovieSearchInteractorOutput: class {
    
    func moviesListFetchedSuccessfully(_ movieSearchModel: [MovieSearchModel])
    func moviesListFetchFailed()
}

protocol MovieSearchWireframe: class {
    
    weak var viewController: UIViewController? { get set }
    
    static func assembleModule() -> UIViewController
}
