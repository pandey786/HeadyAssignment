//
//  MovieSearchViewController.swift
//  HeadyAssignment
//
//  Created by Durgesh Pandey on 06/02/18.
//  Copyright © 2018 Durgesh Pandey. All rights reserved.
//

import UIKit
import Nuke

class MovieSearchViewController: UIViewController {
    
    //Outlets
    @IBOutlet weak var collectionViewMovieSearch: UICollectionView!
    @IBOutlet weak var viewNoContent: UIView!
    @IBOutlet weak var viewSelectSortOrder: UIView!
    @IBOutlet weak var labelSortOrder: UILabel!
    @IBOutlet weak var viewTopHeader: UIView!
    
    //Varibales
    var currentPageCount = 1
    var textSearched = ""
    var presenter: MovieSearchPresentation!
    var movieSearchResults = [MovieSearchModel]()
    let searchController = UISearchController.init(searchResultsController: nil)
    var selectedSortOrder = ""
    var selectedMovie: MovieSearchModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Set Up View
        setUpView()
        
        //Set Up Bottom Refresh
        addBottomRefresh()
        
    }
    
    func addBottomRefresh() {
        
        //Bind Kafka Refresh
        self.collectionViewMovieSearch.bindRefreshStyle(.replicatorTriangle, fill: UIColor.red, at: .footer) {
            
            //Fetch Movies
            self.currentPageCount += 1
            self.fetchMoviesList(for: self.textSearched, pageCount: self.currentPageCount)
        }
    }
    
    func setUpView() {
        
        //set Navigation Bar
        setupNavigationBar()
        
        //Set Default Label Titles
        self.labelSortOrder.text = selectedSortOrder.count > 0 ? selectedSortOrder : "Sort By"
        
        //Customize Select Category View
        self.viewSelectSortOrder.setDefaultBorder()
        
        //set up Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
        //Register Nibs
        self.collectionViewMovieSearch.register(UINib.init(nibName: "MovieSearchCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MovieSearchCollectionViewCell")
        
    }
    
    func setupNavigationBar() {
        
        //Set Large Title for Navigation Bar
        self.title = "Search Movies"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.largeTitleDisplayMode = .never
        
        //Change Fontcolor for Large navigation Title
        let attributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        navigationController?.navigationBar.largeTitleTextAttributes = attributes
        
    }
    
    func fetchMoviesList(for searchText: String, pageCount: Int) {
        
        //Clear Search Data for First Page
        if pageCount == 1 {
            clearLastSearchedData()
        }
        
        //fetch Movies
        presenter.fetchMoviesList(for: searchText, pageCount: pageCount)
    }
    
    // MARK: - Actions
    // MARK: -
    @IBAction func buttonSortOrderTapped(_ sender: Any) {
        
        //Present popover to select Category
        self.presentPopOverFrom(sourceView: sender as! UIView, dataSourceArray: sortOrderArray, popOverDelegate: self, popOverType: .SelectSortingOrder, selectedItem: selectedSortOrder)
    }
    
}

// MARK: - View Protocol
// MARK: -
extension MovieSearchViewController: MovieSearchView {
    
    func showMovieList(_ movieSearchModel: [MovieSearchModel]) {
        self.viewNoContent.isHidden = true
        self.viewTopHeader.isHidden = false
        self.collectionViewMovieSearch.isHidden = false
        
        //Append Contents
        self.movieSearchResults.append(contentsOf: movieSearchModel)
        self.collectionViewMovieSearch.reloadData()
        
        //Sort List
        self.sortMoviesListBy(sortOrder: self.selectedSortOrder)
        
        //End Refresh
        self.collectionViewMovieSearch.footRefreshControl.endRefreshing()
        
        //Check If there are no Objects Fetched show no content screen
        if self.movieSearchResults.count == 0 {
            self.showNoContentScreen()
        }
    }
    
    func showNoContentScreen() {
        
        //Check If there are no Objects Fetched show no content screen
        if self.movieSearchResults.count == 0 {
            self.viewNoContent.isHidden = false
            self.viewTopHeader.isHidden = true
            self.collectionViewMovieSearch.isHidden = true
        }
        
        //End Refresh
        self.collectionViewMovieSearch.footRefreshControl.endRefreshing()
    }
    
    func clearLastSearchedData() {
        
        self.viewNoContent.isHidden = true
        self.viewTopHeader.isHidden = false
        self.collectionViewMovieSearch.isHidden = false
        
        //Remove current records and remove from UI as well
        self.movieSearchResults.removeAll()
        self.collectionViewMovieSearch.reloadData()
    }
}

// MARK: - Search Controller
// MARK: -
extension MovieSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchtext = searchController.searchBar.text else {
            return
        }
        
        if searchtext.count > 0 {
            
            //Fetch Movies
            self.textSearched = searchtext
            self.currentPageCount = 1
            self.fetchMoviesList(for: searchtext, pageCount: currentPageCount)
        } else {
            
            //Present Alert
            self.presentAlertWith(alertTitle: "Alert", alertMessage: "Please Enter Something to Search")
        }
    }
}

// MARK: - PopOverDelegate
// MARK: -
extension MovieSearchViewController: PopOverDelegate {
    
    func selectedPopOverItem(selectedItem: Any, popOverType: PopOverType) {
        
        switch popOverType {
        case .SelectSortingOrder:
            
            let selectedSortOrder = selectedItem as! String
            self.selectedSortOrder = selectedSortOrder
            self.labelSortOrder.text = selectedSortOrder
            
            //Sort List
            self.sortMoviesListBy(sortOrder: self.selectedSortOrder)
            
        }
    }
    
    func sortMoviesListBy(sortOrder: String) {
        
        if sortOrder == "Popularity" {
            
            //Sort Array Based On Popularity
            self.movieSearchResults.sort(by: { (firstMovieObj, secondMovieObj) -> Bool in
                return firstMovieObj.popularity ?? 0.0 > secondMovieObj.popularity ?? 0.0
            })
            
        } else if sortOrder == "Rating" {
            
            //Sort Array Based On Rating
            self.movieSearchResults.sort(by: { (firstMovieObj, secondMovieObj) -> Bool in
                return firstMovieObj.vote_average ?? 0 > secondMovieObj.vote_average ?? 0
            })
            
        } else if sortOrder == "Release Date" {
            
            //Sort Array Based On Release Date
            self.movieSearchResults.sort(by: { (firstMovieObj, secondMovieObj) -> Bool in
                
                let firstObjReleaseDateStr = firstMovieObj.release_date ?? ""
                let secondObjReleaseDateStr = secondMovieObj.release_date ?? ""
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                
                let firstObjReleaseDate = firstObjReleaseDateStr.count > 0 ? dateFormatter.date(from: firstMovieObj.release_date!)! : Date()
                let secondObjReleaseDate = secondObjReleaseDateStr.count > 0 ? dateFormatter.date(from: secondMovieObj.release_date!)! : Date()
                
                return firstObjReleaseDate.compare(secondObjReleaseDate) == .orderedDescending
            })
        }
        
        //Reload Collection View
        self.collectionViewMovieSearch.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
// MARK: -
extension MovieSearchViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.movieSearchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let movieCell: MovieSearchCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieSearchCollectionViewCell", for: indexPath) as! MovieSearchCollectionViewCell
        
        //Configure Cell
        let movieModel = self.movieSearchResults[indexPath.row]
        
        //Set Image
        if let imageUrl = URL.init(string: movieModel.getImageUrl()) {
            Manager.shared.loadImage(with: imageUrl, into: movieCell.imageViewMovieThumbnail)
        }
        
        //Set title
        movieCell.labelMovieTitle.text = movieModel.title
        
        return movieCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize.init(width: collectionView.frame.size.width/2 - 10, height: 250)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //Set Selected Movie
        let selectedMovie = self.movieSearchResults[indexPath.row]
        self.selectedMovie = selectedMovie
        
        //Navigate To Movie details page
        let movieDetailCtrl = MovieDetailRouter.assembleModule(with: self.selectedMovie!)
        self.navigationController?.pushViewController(movieDetailCtrl, animated: true)
    }
}
