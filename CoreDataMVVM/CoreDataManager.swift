//
//  CoreDataManager.swift
//  CoreDataMVVM
//
//  Created by Hayk Sakulyan on 30.08.23.
//

import Foundation
import CoreData

class CoreDataManager {
    
    let persistantContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistantContainer.viewContext
    }
    
    private init() {
        persistantContainer = NSPersistentContainer(name: "ToDoAppModel")
        persistantContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error.localizedDescription)")
            }
            
        }
    }
    func save(){
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
    
    func getTaskById(id: NSManagedObjectID) -> Task? {
        do {
            return try viewContext.existingObject(with: id) as? Task

        } catch {
            return nil
        }
    }
    func deletetask(task: Task) {
        viewContext.delete(task)
        save()
    }
    
    func getAllTasks() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
}
