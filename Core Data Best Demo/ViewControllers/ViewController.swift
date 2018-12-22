//
//  ViewController.swift
//  Core Data Best Demo
//
//  Created by Trushant on 17/12/18.
//  Copyright © 2018 Esense. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var songsTableViewObj: UITableView!
    var arrayOfSongModels : [Song] = Array()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.checkTheNetworkAndProceedAccordingly()
        
    }
    
    
    func checkTheNetworkAndProceedAccordingly()
    {
        if WebService.isConnectedToInternet()
        {
            
            // Internet present time to refresh the core data and show the new values to the tableview.....

            WebService.sharedInstance.getTheTop10Songs(success: { (success, arrayOfSongModel) in
                
                print(arrayOfSongModel)
                self.arrayOfSongModels = arrayOfSongModel
                self.songsTableViewObj.reloadData()
                
                
                // time to store the updated values into core data......
                DBCoreDataHelper.sharedManager.DeleteSongsFromLocalDB()
                DBCoreDataHelper.sharedManager.saveSongsToLocalDB(arrayOfSongs: arrayOfSongModel)
                
                
            }) { (errorString) in
                
                print(errorString)
                
            }
        }
        else
        {
            // Internet not present time to load the values from core data
            
            self.arrayOfSongModels = DBCoreDataHelper.sharedManager.fetchAllTheSongs()
            self.songsTableViewObj.reloadData()

        }
    }

}




extension ViewController : UITableViewDataSource, UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfSongModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : TableViewCell = self.songsTableViewObj.dequeueReusableCell(withIdentifier: "TableViewCell") as! TableViewCell
        
        cell.configureCellAccordingToModel(songModel: self.arrayOfSongModels[indexPath.row])
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

