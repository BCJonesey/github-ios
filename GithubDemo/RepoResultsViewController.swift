//
//  ViewController.swift
//  GithubDemo
//
//  Created by Nhan Nguyen on 5/12/15.
//  Copyright (c) 2015 codepath. All rights reserved.
//

import UIKit
import MBProgressHUD
import AFNetworking

// Main ViewController
class RepoResultsViewController: UIViewController {

    var searchBar: UISearchBar!
    var searchSettings = GithubRepoSearchSettings()

    @IBOutlet weak var tableView: UITableView!
    var repos: [GithubRepo]?

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        // Initialize the UISearchBar
        searchBar = UISearchBar()
        searchBar.delegate = self

        // Add SearchBar to the NavigationBar
        searchBar.sizeToFit()
        navigationItem.titleView = searchBar
        
        let settingsButton = UIBarButtonItem()
        settingsButton.title = "Settings"
        settingsButton.action = #selector(settingsButtonPressed)
        settingsButton.target = self
        navigationItem.leftBarButtonItem = settingsButton

        // Perform the first search when the view controller first loads
        doSearch()
    }

    // Perform the search.
    fileprivate func doSearch() {

        MBProgressHUD.showAdded(to: self.view, animated: true)

        // Perform request to GitHub API to get the list of repositories
        GithubRepo.fetchRepos(searchSettings, successCallback: { (newRepos) -> Void in

            self.repos = newRepos
            self.tableView.reloadData()
            
            MBProgressHUD.hide(for: self.view, animated: true)
            }, error: { (error) -> Void in
                print(error)
        })
    }
    
    func settingsButtonPressed() {
        performSegue(withIdentifier: "showSettingsView", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let settingsViewController = segue.destination as! SettingsViewController
        settingsViewController.searchSettings = self.searchSettings
        
    }
}

// SearchBar methods
extension RepoResultsViewController: UISearchBarDelegate {

    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }

    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchSettings.searchString = searchBar.text
        searchBar.resignFirstResponder()
        doSearch()
    }
}




extension RepoResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return (self.repos ?? []).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.lab.repo", for: indexPath as IndexPath) as! RepoViewCell
        
        let repo = repos![indexPath.row]
        
        cell.nameLabel.text = repo.name
        cell.descriptionLabel.text = repo.repoDescription
        cell.forksLabel.text = "\(repo.forks ?? 0)"
        cell.ownerLabel.text = repo.ownerHandle
        cell.avatarImageView.setImageWith(URL(string: (repo.ownerAvatarURL ?? ""))!)
        cell.starsLabel.text = "\(repo.stars ?? 0)"
        
        return cell
    }
    
}
