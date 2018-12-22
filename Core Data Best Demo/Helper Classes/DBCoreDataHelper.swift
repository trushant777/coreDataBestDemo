//
//  CryptoSOS
//
//  Created by Trushant Kawale on 21/02/18.
//  Copyright © 2018 Esense. All rights reserved.
//


import Foundation
import CoreData
import UIKit

class DBCoreDataHelper
{
    
    static let sharedManager = DBCoreDataHelper()
    
    //MARK:
    //MARK: Objects of Use

    var appDel : AppDelegate
    var context :NSManagedObjectContext

    private init()
    {
        appDel = UIApplication.shared.delegate as! AppDelegate
        context = DBCoreDataMain.managedObjectContext
    }
    

    
    //MARK:- CoreData Save Methods
    

    
    func saveSongsToLocalDB(arrayOfSongs: [Song])
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SongTable")
        
        for songModelObj in arrayOfSongs
        {
            let predicate1 = NSPredicate(format: "title == %@", songModelObj.title)
            
            let predicate = NSCompoundPredicate.init(andPredicateWithSubpredicates: [predicate1])
            
            fetchRequest.predicate = predicate
            
            do {
                let fetchResults = try context.fetch(fetchRequest)
                var songTableObj : SongTable = SongTable()
                
                if (fetchResults.count == 0){
                    songTableObj = NSEntityDescription.insertNewObject(forEntityName: "SongTable",into: context) as! SongTable
                }else{
                    songTableObj = fetchResults[0] as! SongTable
                }
                
                songTableObj.title = songModelObj.title
                songTableObj.artist = songModelObj.artist
                songTableObj.urlString = songModelObj.urlString
                
                try context.save()
                
            } catch  {
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    
    
    //MARK:- CoreData Fetch Methods

    
    func fetchAllTheSongs() -> [Song]
    {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SongTable")
        
        do {
            let fetchResults = try context.fetch(fetchRequest)
            
            var arrayOfSongModel : [Song] = Array()
            for fetchRes in fetchResults
            {
                let songDBObj : SongTable = fetchRes as! SongTable
                let songModelObj: Song = Song()
                
                songModelObj.title = songDBObj.title!
                songModelObj.artist = songDBObj.artist!
                songModelObj.urlString = songDBObj.urlString!
                
                arrayOfSongModel.append(songModelObj)
            }
            return arrayOfSongModel
            
        } catch  {
            print(error.localizedDescription)
        }
        
        return  [Song()]
    }
    
    
    
    //MARK:- CoreData Delete Methods
    
    func DeleteSongsFromLocalDB()
    {
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SongTable")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }


    }
    

}


