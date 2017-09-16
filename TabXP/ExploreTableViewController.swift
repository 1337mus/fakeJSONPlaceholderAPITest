//
//  ExploreTableViewController.swift
//  TabXP
//
//  Created by Rajath Bhagavathi on 9/14/17.
//  Copyright © 2017 HashMap. All rights reserved.
//

import UIKit

class ExploreTableViewController: UITableViewController {

    fileprivate let dataSourceLoader = ExploreTableViewDataLoader()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ExploreTableViewSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: String(describing: ExploreTableViewSectionHeaderView.self))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        dataSourceLoader.reloadData { [weak self] success in
            guard success else { return }
            self?.tableView.reloadData()
        }
    }
}

extension ExploreTableViewController {
    public override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceLoader.numberOfItems(in: section)
    }
    
    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let item = dataSourceLoader.item(at: indexPath) else { return UITableViewCell() }
        
        if let vm = item as? ExploreCellViewModel, let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ExploreTableViewCell.self), for: indexPath) as? ExploreTableViewCell {
            cell.viewModel = vm
            return cell
        }
        
        return UITableViewCell()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return dataSourceLoader.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: String(describing: ExploreTableViewSectionHeaderView.self)) as? ExploreTableViewSectionHeaderView {
            return headerView
        }
        
        return nil
    }
}
