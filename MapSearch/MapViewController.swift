//
//  MapViewController.swift
//  MapSearch
//
//  Created by Hanawa Takuro on 2016/03/27.
//  Copyright © 2016年 Hanawa Takuro. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet var mapView: MKMapView!

    var request = MKLocalSearchRequest()

    override func viewDidLoad() {
        super.viewDidLoad()

        let search = MKLocalSearch(request: request)

        search.startWithCompletionHandler { response, error in
            response?.mapItems.forEach { item in

                let point = MKPointAnnotation()
                point.coordinate = item.placemark.coordinate
                point.title = item.placemark.title
                self.mapView.addAnnotation(point)
            }

            self.mapView.showAnnotations(self.mapView.annotations, animated: true)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
