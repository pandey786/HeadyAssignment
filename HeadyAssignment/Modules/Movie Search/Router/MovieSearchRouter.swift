//
//  MovieSearchRouter.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class MovieSearchRouter: MovieSearchWireframe {
    
    var viewController: UIViewController?
    
    static func assembleModule() -> UIViewController {
        
        let view: MovieSearchViewController = movieSearchStoryBoard.instantiateViewController(withIdentifier: "MovieSearchViewController") as! MovieSearchViewController
        
        let interactor = MovieSearchInteractor()
        let presenter = MovieSearchPresenter()
        let router = MovieSearchRouter()
        
        view.presenter = presenter
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.output = presenter
        router.viewController = view
        
        return UINavigationController.init(rootViewController: view)
    }
}
