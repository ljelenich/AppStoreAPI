//
//  EntityTableViewCell.swift
//  AppleSearch
//
//  Created by LAURA JELENICH on 9/24/20.
//

import UIKit

class EntityTableViewCell: UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var artworkImageView: UIImageView!
    
    var musicTrack: MusicTrack?
    var appItem: AppItem?
    
    func updateViews() {
        var url: URL?
        
        if let musicTrack = musicTrack {
            trackNameLabel.text = musicTrack.trackName
            descriptionLabel.text = musicTrack.artistName
            url = musicTrack.artworkUrl100
        } else if let appItem = appItem {
            trackNameLabel.text = appItem.trackName
            descriptionLabel.text = appItem.description
            url = appItem.artworkUrl100
        }
        
        self.artworkImageView.image = nil
        if let url = url {
            AppleStoreItemController.fetchImageFrom(url: url) { (result) in
                switch result {
                
                case .success(let image):
                    DispatchQueue.main.async {
                        self.artworkImageView.image = image
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
}
