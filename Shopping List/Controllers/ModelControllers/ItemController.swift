//
//  TodoController.swift
//  Shopping List
//
//  Created by Sebastian Banks on 3/25/22.
//

import Foundation

class ItemController {
    
    static let shared = ItemController()
    
    // Source of Truth
    var items: [Item] = []
    
    // Crud
    // Create
    func addTodoItem(itemName: String) {
        items.append(Item(itemName: itemName))
        saveToPersistantStore()
    }
    // Update
    func updateTodoIsDone(for item: Item) {
        item.isDone = !item.isDone
        saveToPersistantStore()
    }
    // Delete
    func deleteTodo(item: Item) {
        guard let index = items.firstIndex(of: item) else { return }
        items.remove(at: index)
        saveToPersistantStore()
    }
    
    // Persistance
    // Create URL
    func persistantStore() -> URL {
        let urls = FileManager.default.urls(
            for: .documentDirectory,
            in: .userDomainMask
        )
        let fileURL = urls[0].appendingPathComponent("Todo.json")
        return fileURL
    }
    // Save
    func saveToPersistantStore() {
        do {
            let data = try JSONEncoder().encode(items)
            try data.write(to: persistantStore())
        } catch {
            print("Error saving to persistant store: \(error)")
        }
    }
    // Load
    func loadFromPersistantStore() {
        do {
            let data = try Data(contentsOf: persistantStore())
            items = try JSONDecoder().decode([Item].self, from: data)
        } catch {
            print("Error loading from persistant store: \(error)")
        }
    }
}
