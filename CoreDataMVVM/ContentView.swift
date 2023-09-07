//
//  ContentView.swift
//  CoreDataMVVM
//
//  Created by Hayk Sakulyan on 30.08.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var taskListVM = TaskListViewModel()
    
    func deletetask(at offset: IndexSet) {
        offset.forEach { index in
            let task = taskListVM.tasks[index]
            taskListVM.delete(task)
        }
        taskListVM.getAllTasks()
    }
    var body: some View {
        VStack {
            HStack {
                TextField("Enter task name", text: $taskListVM.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button("Save") {
                    taskListVM.save()
                    taskListVM.getAllTasks()
                }
            }
           
            List {
                ForEach(taskListVM.tasks, id: \.id) { task in
                    Text(task.title)
                }.onDelete(perform: deletetask)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //
            .scrollContentBackground(.hidden)
            .environment(\.defaultMinListHeaderHeight, 0)
            .edgesIgnoringSafeArea(.all)
            .listStyle(GroupedListStyle())
            Spacer()
        }
        .padding()
        .onAppear {
            taskListVM.getAllTasks()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
