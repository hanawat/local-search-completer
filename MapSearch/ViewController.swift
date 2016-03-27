//
//  ViewController.swift
//  MapSearch
//
//  Created by Hanawa Takuro on 2016/03/26.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import UIKit
import MapKit

@available(iOS 9.3, *)
class ViewController: UIViewController, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, MKLocalSearchCompleterDelegate {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!

    let completer = MKLocalSearchCompleter()

    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        completer.delegate = self

        completer.filterType = .LocationsOnly
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UISearchBarDelegate

    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {

        guard let text = searchBar.text else { return false }

        completer.queryFragment = text
        return true
    }

    // MARK: - UITableViewDelegate

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let mapViewController = storyboard.instantiateViewControllerWithIdentifier("MapViewController") as? MapViewController else { return }

        mapViewController.request = MKLocalSearchRequest(completion: completer.results[indexPath.row])
        self.showViewController(mapViewController, sender: nil)
    }

    // MARK: - UITableViewDataSource

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return completer.results.count
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let identifier = "Cell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)

        if (cell == nil) {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
        }

        cell?.textLabel?.text = completer.results[indexPath.row].title
        return cell!
    }

    // MARK: - MKLocalSearchCompleterDelegate

    func completerDidUpdateResults(completer: MKLocalSearchCompleter) {

        tableView.reloadData()
    }

    func completer(completer: MKLocalSearchCompleter, didFailWithError error: NSError) {

        print(error)
    }
}

