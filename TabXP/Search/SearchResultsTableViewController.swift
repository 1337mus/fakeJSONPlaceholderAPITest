//
//  SearchResultsTableViewController.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/25/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import Foundation
import UIKit

class SearchResultsTableViewController: UITableViewController {
    let dataLoader = ExploreTableViewDataLoader()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredExperiences = [Experience]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        self.tableView.backgroundColor = UIColor.white
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        searchController.searchResultsUpdater = self
        tableView.register(SearchResultsTableViewCell.self, forCellReuseIdentifier: String(describing: SearchResultsTableViewCell.self))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataLoader.reloadData { [weak self] success in
            guard let strongSelf = self, success else { return }
            
            strongSelf.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultsTableViewCell.self), for: indexPath) as? SearchResultsTableViewCell {
             cell.experiences = isFiltering ? filteredExperiences : dataLoader.exploreCellViewModel?.experiences ?? []
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

extension SearchResultsTableViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if isFiltering {
            filteredExperiences = dataLoader.exploreCellViewModel?.experiences.filter {
                return $0.title.lowercased().range(of: searchText.lowercased()) != nil
            } ?? []
        }
        
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
}
