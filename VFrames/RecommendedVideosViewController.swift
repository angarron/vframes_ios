//
//  RecommendedVideosViewController.swift
//  VFrames
//
//  Created by Andy Garron on 3/3/16.
//  Copyright © 2016 VFrames. All rights reserved.
//

import UIKit

class RecommendedVideosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, GetVideosTaskListenerProtocol {
    
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var videosTableView: UITableView!
    
    var targetCharacterId: CharacterID!
    
    var youtubeVideos: [String:Array<YoutubeVideo>]!
    var tableHeaders: Array<String>!

    override func viewDidLoad() {
        super.viewDidLoad()
        videosTableView.hidden = true
        let getVideosTask = GetRecommendedVideosTask()
        getVideosTask.loadData(self, character: getCharacterStringForUrl(targetCharacterId))
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let category = tableHeaders[indexPath.section]
        let video = youtubeVideos[category]![indexPath.item]
        
        let cell = videosTableView.dequeueReusableCellWithIdentifier("youtubeVideoCell")
        
        let youtubeVideoCell = cell as! YoutubeVideoCell
        youtubeVideoCell.setVideo(video)
        return youtubeVideoCell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableHeaders != nil) {
            let category = tableHeaders[section]
            return youtubeVideos[category]!.count
        } else {
            return 0
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if (tableHeaders != nil) {
            return tableHeaders.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (tableHeaders != nil) {
            return tableHeaders[section]
        } else {
            return nil
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let category = tableHeaders[indexPath.section]
        let video = youtubeVideos[category]![indexPath.item]
        let id = video.id
        let url = NSURL(string: "https://youtube.com/watch?v=\(id)")!
        UIApplication.sharedApplication().openURL(url)
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    private func getCharacterStringForUrl(characterId: CharacterID) -> String {
        switch(characterId) {
        default:
            return "ryu"
        }
    }
    
    private func setupTableHeaders() {
        tableHeaders = Array<String>()
        for category in youtubeVideos.keys {
            tableHeaders.append(category)
        }
    }
    
    func onResult(result: [String:Array<YoutubeVideo>]) {
        loadingIndicator.stopAnimating()
        videosTableView.hidden = false
        self.youtubeVideos = result
        setupTableHeaders()
        videosTableView.reloadData()
    }
    
    func onError() {
        print("onError")
    }
}