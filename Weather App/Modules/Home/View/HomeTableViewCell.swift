//
//  HomeTableViewCell.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var numberOfViewsLabel: UILabel!
    @IBOutlet weak var areaNameLabel: UILabel!
    
    //MARK:- UIView Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    //MARK:- UIView populate data
    func populateData(searchData:SearchResult) {
        areaNameLabel.text = searchData.areaName
        countryLabel.text = searchData.country
        regionLabel.text = searchData.region
        if(searchData.numberOfViews == 0) {
        numberOfViewsLabel.text = "No views"
        }else {
            numberOfViewsLabel.text = searchData.numberOfViews == 1 ? String(format: "%d View", searchData.numberOfViews) : String(format: "%d Views", searchData.numberOfViews)
        }
    }
    
}
