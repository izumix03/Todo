//
//  Persistence.swift
//  Todo
//
//  Created by mix on 2022/01/05.
//
//

import CoreData

struct PersistenceController {
  static let shared = PersistenceController()

  static var preview: PersistenceController = {
    let result = PersistenceController(inMemory: true)
    let viewContext = result.container.viewContext
    return result
  }()

  static var contextWithSample: NSManagedObjectContext = {
    let controller = preview
    for _ in 0..<10 {
      let _ = TodoEntity.buildSample(controller.container.viewContext)
    }
    do {
      try controller.container.viewContext.save()
      print("saved")
    } catch {
      let nserror = error as NSError
      fatalError("unresolved error \(nserror), \(nserror.userInfo)")
    }
    return controller.container.viewContext
  }()

  let container: NSPersistentContainer

  init(inMemory: Bool = false) {
    container = NSPersistentContainer(name: "Todo")
    if inMemory {
      container.persistentStoreDescriptions.first!.url =
        URL(fileURLWithPath: "/dev/null")
    }
    container.viewContext
      .automaticallyMergesChangesFromParent = true
    container.loadPersistentStores(completionHandler: {
      (storeDescription, error) in
      if let error = error as NSError? {
        fatalError(
          "Unresolved error \(error), \(error.userInfo)")
      }
    })
  }
}
