//
//  TaskListViewModel.swift
//  CoreDataMVVM
//
//  Created by Hayk Sakulyan on 30.08.23.
//

import Foundation
import CoreData

class TaskListViewModel: ObservableObject {
    
    var title: String = ""
    @Published var tasks: [TaskViewModel] = []
    
    
    func getAllTasks() {
        tasks = CoreDataManager.shared.getAllTasks().map(TaskViewModel.init)
    }
    
    func delete(_ task: TaskViewModel) {
        let existingTask = CoreDataManager.shared.getTaskById(id: task.id)
        if let existingTask = existingTask {
            
            CoreDataManager.shared.deletetask(task: existingTask)
        }
    }
    
    func save() {
        let task = Task(context: CoreDataManager.shared.viewContext)
        task.title = title
        
        CoreDataManager.shared.save()
        
    }
    
}

struct TaskViewModel {
    let task: Task
    
    var id: NSManagedObjectID {
        return task.objectID
    }
    
    var title: String {
        return task.title ?? ""
    }
}
