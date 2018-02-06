//
//  MovieDetailViewController.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import Nuke

class MovieDetailViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var imageViewMoviePoster: UIImageView!
    @IBOutlet weak var labelMovieTitle: UILabel!
    @IBOutlet weak var labelMovieSynopsis: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelUserRatings: UILabel!
    
    //Varibales
    var movieModel: MovieSearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set up View Data
        setUpViewData()
    }
    
    func setUpViewData() {
        
        if let movieModelObj = self.movieModel {
            
            //Set Image
            if let imageUrl = URL.init(string: movieModelObj.getImageUrl()) {
                Manager.shared.loadImage(with: imageUrl, into: self.imageViewMoviePoster)
            }
            
            //Set original Title
            self.labelMovieTitle.text = movieModelObj.original_title
            
            //Set Synopsis
            self.labelMovieSynopsis.text = movieModelObj.overview
            
            //set Release Date
            self.labelReleaseDate.text = movieModelObj.release_date
            
            //set Ratings
            self.labelUserRatings.text = movieModelObj.vote_average != nil ? "\(String(movieModelObj.vote_average!))/10.0": "Not Available"
        }
        
    }

}
