//
//  CryptoSOS
//
//  Created by Trushant Kawale on 21/02/18.
//  Copyright © 2018 Esense. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON


class WebService {
    
    static let sharedInstance = WebService()
    
    // MARK:- Objects For Static URLStrings
    let top10UrlString : String? = "https://rss.itunes.apple.com/api/v1/us/apple-music/top-songs/all/10/explicit.json"

    // MARK:- For GET Method
    
    func requestGETURL(_ strURL: String, headers : [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void) {
        
        Alamofire.request(strURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value!
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    // MARK:- For POST Method
    
    func requestPOSTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(strURL, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value!
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    // MARK:- For PUT Method
    
    func requestPUTURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(strURL, method: .put, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value!
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
        
    }

    
    
    
    // MARK:- For DELETE Method
    
    func requestDeleteURL(_ strURL : String, params : [String : AnyObject]?, headers : [String : String]?, success:@escaping (Any) -> Void, failure:@escaping (Error) -> Void){
        Alamofire.request(strURL, method: .delete, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { (responseObject) -> Void in
            if responseObject.result.isSuccess {
                let resJson = responseObject.result.value!
                success(resJson)
            }
            if responseObject.result.isFailure {
                let error : Error = responseObject.result.error!
                failure(error)
            }
        }
    }
    
    
    // MARK:- Reachability Check Methods

    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }

    
    
    
    // MARK:- All Main Methods
    
    
    func getTheTop10Songs( success:@escaping (Bool, [Song]) -> Void, failure:@escaping (String) -> Void) {

        requestGETURL(top10UrlString! , headers: nil, success: { (result) in
            
            let jsonObj : JSON = JSON(result)
            
            if jsonObj["feed"]["results"].arrayValue.count == 0
            {
                success (false, [Song()])
            }
            else
            {
                let arrayOfSongModelObj = self.parseTheResultToGetSongsArray(jsonToAnalyse:  jsonObj["feed"]["results"])
                success (true, arrayOfSongModelObj)
            }
            
        }) { (error) in
            
            print(error.localizedDescription)
            failure (error.localizedDescription)
            
        }
        
    }
    
    
  
    // MARK:- All Parser Methods

    func parseTheResultToGetSongsArray(jsonToAnalyse:JSON) -> [Song]
    {
        var arrayToSend : [Song] = Array()
        for jsonObjElement in jsonToAnalyse.arrayValue
        {
            let donateModelObj = self.parseTheJsonToGetSongModelObj(jsonToAnalyse: jsonObjElement)
            arrayToSend.append(donateModelObj)
        }
        return arrayToSend
    }
    
    func parseTheJsonToGetSongModelObj(jsonToAnalyse: JSON) -> Song
    {
        
        let songModelObj : Song = Song()
        songModelObj.title = jsonToAnalyse["name"].stringValue
        songModelObj.artist = jsonToAnalyse["artistName"].stringValue
        songModelObj.urlString = jsonToAnalyse["artworkUrl100"].stringValue
        
        return songModelObj
        
    }
    

    
    
}


