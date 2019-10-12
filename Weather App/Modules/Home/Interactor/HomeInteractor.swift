//
//  HomeInteractor.swift
//  Weather App
//
//  Created by User on 10/12/19.
//  Copyright © 2019 VK. All rights reserved.
//

import UIKit

class HomeInteractor: HomePresenterToInteractorProtocol {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var presenter: HomeInteractorToPresenterProtocol?
    
    //MARK:- Search weather result from Local Db
    func getWeatherData(by date: String) {
        let predicate = NSPredicate(format: "createdDate == %@",date)
        presenter?.weatherDataResult(data:  CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "SearchResult", predicate: predicate, sortDescriptor: NSSortDescriptor(key: "areaName", ascending: true)) as! [SearchResult])
    }
    
    //MARK:- Search weather result From Api
    func searchWeather(searchTerm :String ) {
        dataTask?.cancel()
        let queryString = String(format: "search.ashx?query=%@&num_of_results=3&format=json&key=%@",searchTerm,Constants.APIKEY )
        let url = URLGenerator.sharedInstance.urlWithType(type: .URLTYPESEARCH, parameters: queryString)
            dataTask =
                defaultSession.dataTask(with: url) { [weak self] data, response, error in
                    defer {
                        self?.dataTask = nil
                    }
                    if let error = error {
                        print(error)
                        self?.presenter?.weatherFetchFailed(message: error.localizedDescription)
                    }else if
                        let data = data,
                        let response = response as? HTTPURLResponse,
                        response.statusCode == 200 {
                        let date = CLDateHandler.sharedHandlerInsatnce.convertDateToFormatedString(currentDate: Date(), formatedString: Constants.TIMEFORMAT, timezone: TimeZone.current)
                        self?.processWeatherResult(resultData: data, currentDate: date)
                        DispatchQueue.main.async {
                            self?.presenter?.weatherFetchedSuccess(dateString: date)
                        }
                    }
            }
            dataTask?.resume()
    }
    
    //MARK:- Process the weather result
    func processWeatherResult(resultData:Data,currentDate:String) {
        do {
            if let result:[String:[String:[[String:AnyObject]]]] =  try JSONSerialization.jsonObject(with: resultData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:[String:[[String:AnyObject]]]] {
                if let data =  result["search_api"]?["result"] {
                    var weatherData:[SearchResult] = []
                    
                    for dataResult in data {
                        if let tempSearchResult = saveSearchResult(searchResult: dataResult, date:currentDate) {
                            weatherData.append(tempSearchResult)
                        }
                    }
                     CoreDataHandler.sharedInstance.saveBulkData(data: weatherData)
                }
            }
        }catch{
            
        }
    }
    
    //MARK:- Save search result in Core data
    func saveSearchResult(searchResult:[String:AnyObject], date:String) -> SearchResult? {
        let lattitude:String? = searchResult["latitude"] as? String
        let longitude:String? = searchResult["longitude"] as? String
        let population:String? = searchResult["population"] as? String
        var searchResultData = checkSearchResultExist(latValueValue: lattitude ?? "", longitudeValue: longitude ?? "")
        if(searchResultData == nil) {
            searchResultData =   CoreDataHandler.sharedInstance.newEntityForName(entityName: "SearchResult") as? SearchResult
        }
        searchResultData?.latitude = lattitude
        searchResultData?.latitude = longitude
        searchResultData?.createdDate = date
        searchResultData?.population = population
        searchResultData?.areaName = getChildValue(dataValue: searchResult["areaName"] as? [[String : AnyObject]])
        searchResultData?.country =  getChildValue(dataValue: searchResult["country"] as? [[String : AnyObject]])
        searchResultData?.region = getChildValue(dataValue: searchResult["region"] as? [[String : AnyObject]])
        return searchResultData
    }
    
    //MARK:- Get child value
    func getChildValue(dataValue:[[String:AnyObject]]?) ->String {
        var resultString = ""
        if let tempData = dataValue {
            for data in tempData {
                if let tempString = data["value"] as? String {
                    resultString = tempString
                }
            }
        }
        return resultString
    }
    
    //MARK:- Check Search results exist in local
    func checkSearchResultExist(latValueValue:String,longitudeValue:String) -> SearchResult? {
        let predicate = NSPredicate(format: "latitude == %@ && longitude == %@",latValueValue,longitudeValue)
        if let result = CoreDataHandler.sharedInstance.getAllDatasWithPredicate(entity: "SearchResult", predicate: predicate, sortDescriptor: NSSortDescriptor(key: "createdDate", ascending: true)) as? [SearchResult] {
            if(result.count == 0) {
                return nil
            }else {
                return result.first
            }
        }
        return nil
    }
}
