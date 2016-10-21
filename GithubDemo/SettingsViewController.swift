//
//  SettingsViewController.swift
//  GithubDemo
//
//  Created by Ben Jones on 10/20/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var starsSlider: UISlider!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    var searchSettings : GithubRepoSearchSettings?
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(searchSettings.debugDescription)
        starsSlider.value = Float((searchSettings?.minStars) ?? 0)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveAction(_ sender: AnyObject) {
        searchSettings?.minStars = Int(starsSlider.value)
        print(searchSettings.debugDescription)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelAction(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        searchSettings.langs.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "com.lab.repo", for: indexPath as IndexPath)
        
        (cell.textLabel)?.text = searchSettings?.langs.removeValue(forKey: indexPath)
        
        
       
        
        return cell
    }
    
}



