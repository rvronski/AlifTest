//
//  CoreDataMeneger.swift
//  AlifTest
//
//  Created by ROMAN VRONSKY on 26.04.2023.
//

import CoreData

protocol CoreDataManagerProtocol: AnyObject {
    func createUser(email: String, name: String, password: String, completion: @escaping (Bool) -> Void)
    func chekUser(email: String, context: NSManagedObjectContext) -> User?
    func getUser(email: String, completion: (((User)?) -> Void))
    func task() -> [Task]
}

class CoreDataManager: CoreDataManagerProtocol {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AlifTest")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()


    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    func createUser(email: String, name: String, password: String, completion: @escaping (Bool) -> Void) {
        persistentContainer.performBackgroundTask { backgroundContext in
            if self.chekUser(email: email, context: backgroundContext) != nil {
                completion(false)
            } else {
                let user = User(context: backgroundContext)
                user.email = email
                user.name = name
                user.password = password
                do {
                    try backgroundContext.save()
                } catch {
                    print(error)
                    completion(false)
                }
                completion(true)
            }
            
        }
    }

    func chekUser(email: String, context: NSManagedObjectContext) -> User?  {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
       return (try? context.fetch(fetchRequest))?.first
    
    }
    
    func getUser(email: String, completion: (((User)?) -> Void) ) {
        let fetchRequest = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        do {
             let user = try persistentContainer.viewContext.fetch(fetchRequest).first
            completion(user)
        } catch {
            print(error)
            completion(nil)
        }
    }
    func task() -> [Task] {
      let request: NSFetchRequest<Task> = Task.fetchRequest()
      var fetchedTasks: [Task] = []
      do {
          fetchedTasks = try persistentContainer.viewContext.fetch(request)
      } catch let error {
         print("Error fetching singers \(error)")
      }
      return fetchedTasks
    }
}
