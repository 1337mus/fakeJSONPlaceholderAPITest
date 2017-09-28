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
    let dataLoader = SearchResultsDataLoader()
    let searchController = UISearchController(searchResultsController: nil)
    var filteredExperiences = [Experience]()
    var dataModel = SearchResultsDataModel(experiences: [])
    
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
        
        dataLoader.reloadData { [weak self] dataModel in
            guard let strongSelf = self, let model = dataModel  else { return }
            strongSelf.dataModel = model
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return isFiltering ? 1 : dataModel.sectionCount
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SearchResultsTableViewCell.self), for: indexPath) as? SearchResultsTableViewCell {
             cell.experiences = isFiltering ? filteredExperiences : dataModel.item(at: indexPath) ?? []
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !isFiltering else { return nil }
        
        let letter = dataModel.sectionTitle(at: section)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 40))
        label.font = UIFont.systemFont(ofSize: 18)
        
        label.text = letter
        
        return label
    }
}

extension SearchResultsTableViewController: UISearchResultsUpdating {
    public func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text ?? ""
        
        if isFiltering {
            filteredExperiences = dataModel.allExperiences()?.filter {
                return $0.title.lowercased().range(of: searchText.lowercased()) != nil
            } ?? []
        }
        
        tableView.reloadData()
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
}

extension String {
    subscript(i: Int) -> String {
        return String(self[index(startIndex, offsetBy: i)])
    }
    
    subscript(range: Range<Int>) -> String {
        let l = index(startIndex, offsetBy: range.lowerBound)
        let r = index(startIndex, offsetBy: range.upperBound)
        
        return self[l..<r]
    }
}
