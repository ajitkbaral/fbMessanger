//
//  FriendsControllerHelper.swift
//  fbMessanger
//
//  Created by Ajit Kumar Baral on 2/25/17.
//  Copyright © 2017 Ajit Kumar Baral. All rights reserved.
//

import UIKit

////Create a Friend class
//class Friend: NSObject{
//    //Friend's name
//    var name: String?
//    
//    //Friend's profile image name
//    var profileImageName: String?
//}
//
////Create a Message class
//class Message: NSObject{
//    
//    //message text
//    var text: String?
//    
//    //Date for receiving the message
//    var date: NSDate?
//    
//    //From the friend
//    var friend: Friend?
//}
import CoreData
extension FriendsController{

    func clearData(){
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            do{
                let entityNames = ["Friend", "Message"]
                
                for entityName in entityNames{
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
                    let objects = try(context.fetch(fetchRequest)) as? [NSManagedObject]
                    
                    for object in objects!{
                            context.delete(object)
                        
                    }
                }

                try(context.save())
                
            }catch let err{
                print(err)
            }
        }
    }
    
    //Setting up the data to add in the message
    func setupData(){
        
        clearData()
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
    
        if let context = delegate?.persistentContainer.viewContext{
            
            
            let ajit = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            
            ajit.name = "Ajit Kumar Baral"
            ajit.profileImageName = "ajit"
            
            createMessageWithText(text: "Hi! My name is Ajit. Nice to meet you", friend: ajit, minutesAgo: 0, context: context)
            
            
            let naren = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            naren.name = "Naren Maharjan"
            naren.profileImageName = "naren"
            
            createMessageWithText(text: "Good Morning..", friend: naren, minutesAgo: 2, context: context)
            createMessageWithText(text: "Hello how are you?", friend: naren, minutesAgo: 1, context: context)
            createMessageWithText(text: "Are u intrested in buying the apple device?", friend: naren, minutesAgo: 0, context: context)
            
            
            let yugesh = NSEntityDescription.insertNewObject(forEntityName: "Friend", into: context) as! Friend
            yugesh.name = "Yugesh Shrestha"
            yugesh.profileImageName = "yugesh"
            
            createMessageWithText(text: "Hello...", friend: yugesh, minutesAgo: 2, context: context)
            createMessageWithText(text: "Whats up?", friend: yugesh, minutesAgo: 1, context: context)
            
            do{
                try(context.save())
            }catch let err{
                print(err)
            }
            
        }
        
        loadData()
        
    }
    
    private func createMessageWithText(text: String, friend: Friend, minutesAgo: Double, context: NSManagedObjectContext){
        let message = NSEntityDescription.insertNewObject(forEntityName: "Message", into: context) as! Message
        message.friend = friend
        message.text = text
        message.date = NSDate().addingTimeInterval(-minutesAgo * 60)
    }
    
    func loadData(){
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            if let friends = fetchFriends(){
                
                messages = [Message]()
                
                for friend in friends{
                    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Message")
                    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
                    fetchRequest.predicate = NSPredicate(format: "friend.name = %@", friend.name!)
                    fetchRequest.fetchLimit = 1
                    
                    do{
                        let fetchedMessages = try(context.fetch(fetchRequest)) as? [Message]
                        messages?.append(contentsOf: fetchedMessages!)
                    }catch let err{
                        print(err)
                    }
                    
                    messages = messages?.sorted(by: {$0.date!.compare($1.date! as Date) == .orderedDescending})
                }
            }
            
        
        }
    }
    
    private func fetchFriends() -> [Friend]?{
        
        let delegate = UIApplication.shared.delegate as? AppDelegate
        
        if let context = delegate?.persistentContainer.viewContext{
            
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Friend")
            
            do{
                return try context.fetch(request) as? [Friend]
            }catch let err{
                print(err)
            }
        }
        return nil
    }
}
