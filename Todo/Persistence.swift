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
    for i in 0..<10 {
      if (i % 4 == 0) {
        TodoEntity.new(
            in: viewContext,
            category: .ImpUrg_1st, task: "炎上プロジェクト"
        )
      }
      else if (i % 3 == 0) {
        TodoEntity.new(
            in: viewContext,
            category: .NImpUrg_3rd, task: "良いプロジェクト"
        )
      }
      else if (i % 2 == 0) {
        TodoEntity.new(
            in: viewContext,
            category: .ImpNUrg_2nd, task: "まあまあプロジェクト"
        )
      }
      else {
        TodoEntity.new(
            in: viewContext,
            category: .NImpNUrg_4th, task: "普通プロジェクト"
        )
      }
    }
    do {
      try viewContext.save()
      print("saved")
    } catch {
      let nserror = error as NSError
      fatalError("unresolved error \(nserror), \(nserror.userInfo)")
    }
    return result
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
