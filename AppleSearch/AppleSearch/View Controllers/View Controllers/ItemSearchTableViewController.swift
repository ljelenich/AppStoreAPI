//
//  ItemSearchTableViewController.swift
//  AppleSearch
//
//  Created by LAURA JELENICH on 9/24/20.
//

import UIKit

class ItemSearchTableViewController: UITableViewController {
    @IBOutlet weak var entitySearchBar: UISearchBar!
    @IBOutlet weak var entitySegmentedControl: UISegmentedControl!
    
    var musicItems: [MusicTrack] = []
    var appItems: [AppItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entitySearchBar.delegate = self
    }
    
    @IBAction func segmentedControlValueChanged(_ sender: Any) {
        search()
    }
    
    func search() {
        guard let searchTerm = entitySearchBar.text, !searchTerm.isEmpty else { return }
        if entitySegmentedControl.selectedSegmentIndex == 0 {
            AppleStoreItemController.fetchMusicItems(searchTerm: searchTerm) { (result) in
                switch result {
                    
                case .success(let musicTracks):
                    DispatchQueue.main.async {
                        self.musicItems = musicTracks
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            AppleStoreItemController.fetchAppItems(searchTerm: searchTerm) { (result) in
                switch result {
                
                case .success(let apps):
                    DispatchQueue.main.async {
                        self.appItems = apps
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch entitySegmentedControl.selectedSegmentIndex {
        case 0:
            return self.musicItems.count
        case 1:
            return self.appItems.count
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "entityCell", for: indexPath) as? EntityTableViewCell else { return UITableViewCell() }
        switch entitySegmentedControl.selectedSegmentIndex {
        case 0:
            let track = musicItems[indexPath.row]
            cell.musicTrack = track
            cell.appItem = nil
        case 1:
            let app = appItems[indexPath.row]
            cell.appItem = app
            cell.musicTrack = nil
        default:
            break
        }
        cell.updateViews()
        return cell
    }
}

extension ItemSearchTableViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search()
    }
}
