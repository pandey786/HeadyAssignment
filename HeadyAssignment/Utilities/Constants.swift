//
//  Constants.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import Foundation
import UIKit

enum Constants {
    static let imagePlaceholder = "white_placeholder"
}

var movieSearchStoryBoard: UIStoryboard {
    return UIStoryboard.init(name: "MovieSearchStoryboard", bundle: nil)
}

var popOverStoryBoard: UIStoryboard {
    return UIStoryboard.init(name: "PopOverStoryboard", bundle: nil)
}

var movieDetailStoryBoard: UIStoryboard {
    return UIStoryboard.init(name: "MovieDetailStoryboard", bundle: nil)
}

// MARK: - HardCoded Sort order Array
// MARK: -
var sortOrderArray = ["Popularity", "Rating", "Release Date"]







