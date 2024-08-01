//
//  SearchManager.swift
//  IOSSwift
//
//  Created by Crest Infosystems on 30/07/19.
//  Copyright © 2019 Crest Infosystems. All rights reserved.
//

import UIKit

/// Singleton class use to manage searching feature in required screens
class SearchManager: NSObject {
    
    static let shared: SearchManager = {
        let instance = SearchManager.init()
        return instance
    }()
    
    override init() {
        super.init()
    }
    
    let searchController = UISearchController(searchResultsController: nil)
    var isSearching: Bool = false
    
    fileprivate var currentViewController: UIViewController!
    
    typealias SearchResultClosure = ((String, String?)->())
    
    fileprivate var updateSearchResults: SearchResultClosure?
    var cancelButtonTapped: (()->())?
    fileprivate var searchButtonTapped: SearchResultClosure?

}

extension SearchManager: UISearchResultsUpdating {
    
    /**
     Method to update search result
     - parameter searchController: Represent UISearchController
     */
    func updateSearchResults(for searchController: UISearchController) {
        let text = searchController.searchBar.text ?? ""
        if searchController.searchBar.selectedScopeButtonIndex < searchController.searchBar.scopeButtonTitles?.count ?? 0 {
            let value = searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex]
            self.updateSearchResults?(text, value)
        } else {
            self.updateSearchResults?(text, nil)
        }
    }
    
}

extension SearchManager: UISearchControllerDelegate {
    /**
     Method to present search controller on screen
     - parameter searchController: Represent UISearchController
     */
    func presentSearchController(_ searchController: UISearchController) {
        DispatchQueue.main.async {
            searchController.searchBar.becomeFirstResponder()
        }
    }
    
}

extension SearchManager: UISearchBarDelegate {
    
    /**
     Method to handle cancel button click of search controller
     - parameter searchBar: Represent UISearchBar
     */
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.resetSearch()
        self.cancelButtonTapped?()
    }
    
    /**
     Method to handle search button click of search controller
     - parameter searchBar: Represent UISearchBar
     */
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text ?? ""
        if searchBar.selectedScopeButtonIndex < searchBar.scopeButtonTitles?.count ?? 0 {
            let value = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
            self.searchButtonTapped?(text, value)
        } else {
            self.searchButtonTapped?(text, nil)
        }
    }
    
    /**
     Method to handle scope did change event
     - parameter searchBar: Represent UISearchBar
     - parameter selectedScope: Represent selected scope
     */
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let value = searchBar.scopeButtonTitles![selectedScope]
        self.updateSearchResults?(searchBar.text ?? "", value)
    }
    
}

extension SearchManager {
    
    /**
     Method to setup search controller on screen
     - parameter viewController: Represent viewController which will have search controller
     - parameter searchPlaceholder: Represent placeholder string to show in search bar textfield
     - parameter scopeButtonTitles: Represent array of scop string
     - parameter selectedScopeButtonIndex: Represent select scope index
     - parameter updateSearchResults: Represent callback block for search result upate
     - parameter cancelButtonTapped: Represent callback block for cancel click
     - parameter searchButtonTapped: Represent callback block for search click
     */
    func setupSearchController(on viewController: UIViewController, searchPlaceholder: String = "Search", scopeButtonTitles: [String]? = nil, selectedScopeButtonIndex: Int = 0, updateSearchResults: @escaping SearchResultClosure, cancelButtonTapped: (()->())? = nil, searchButtonTapped: SearchResultClosure? = nil) {
        
        self.currentViewController = viewController
        self.updateSearchResults = updateSearchResults
        self.cancelButtonTapped = cancelButtonTapped
        self.searchButtonTapped = searchButtonTapped
        
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.searchBarStyle = .minimal
        self.searchController.searchBar.backgroundColor = UIColor.clear
            
        self.searchController.searchBar.set(textColor: UIColor.white)
        self.searchController.searchBar.setPlaceholder(textColor: UIColor.white.withAlphaComponent(0.7))
        self.searchController.searchBar.setSearchImage(color: UIColor.white)
        self.searchController.searchBar.setClearButton(color: UIColor.white)
        
        self.searchController.searchBar.tintColor = UIColor.white
        self.searchController.searchBar.barStyle = .black
        
        self.searchController.searchBar.placeholder = searchPlaceholder
        
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.delegate = self
        self.searchController.delegate = self
        
        self.isSearching = true
        
        viewController.navigationItem.searchController = self.searchController
        self.searchController.isActive = true
        
        viewController.definesPresentationContext = false
        
        if scopeButtonTitles?.count ?? 0 > 0 {
            self.searchController.searchBar.scopeButtonTitles = scopeButtonTitles
            self.searchController.searchBar.selectedScopeButtonIndex = selectedScopeButtonIndex
            //let segmentedControlScope = UISegmentedControl.appearance(whenContainedInInstancesOf: [UISearchBar.self])
           
        } else {
            self.searchController.searchBar.scopeButtonTitles = nil
            self.searchController.searchBar.selectedScopeButtonIndex = 0
        }
        
        self.searchController.searchBar.sizeToFit()
        
    }
    
    /**
     Method to reset search controller
     */
    func resetSearch() {
        self.searchController.isActive = false
        self.isSearching = false
        self.searchController.dismiss(animated: true, completion: nil)
        self.currentViewController?.navigationItem.searchController = nil
        self.currentViewController?.navigationController?.view.setNeedsLayout()
        self.currentViewController?.navigationController?.view.layoutIfNeeded()
    }
    
}
