//
//  LocationSearchViewController.swift
//  Arogyamitra
//
//  Created by Sangram Powar on 28/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import UIKit

class LocationSearchViewController: UIViewController {
    var resultSearchController:UISearchController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()

        let locationSearchTable = LocationStoryboard.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController?.searchResultsUpdater = locationSearchTable
        
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        resultSearchController?.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        
//        locationSearchTable.mapView = mapView
        
//        locationSearchTable.handleMapSearchDelegate = self
        
    }


}
