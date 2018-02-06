//
//  MovieDetailRouter.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailRouter {
    
    static func assembleModule(with movieModel: MovieSearchModel) -> UIViewController {
        
        let view: MovieDetailViewController = movieDetailStoryBoard.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        view.movieModel = movieModel
        
        return view
    }
}
