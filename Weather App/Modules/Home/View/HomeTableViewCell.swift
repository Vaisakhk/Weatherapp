//
//  HomeTableViewCell.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var areaNameLabel: UILabel!
    
    //MARK:- UIView Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK:- UIView populate data
    func populateData(searchData:SearchResult) {
        areaNameLabel.text = searchData.areaName
        print("name == " + (searchData.areaName ?? "NO AREA"))
    }
    
}
