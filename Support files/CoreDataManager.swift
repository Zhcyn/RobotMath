import CoreData
import Foundation
class CoreDataManager {
  private let context: NSManagedObjectContext
  init(context: NSManagedObjectContext) {
    self.context = context
  }
  func updateScore(score: Int) {
    guard let entity = NSEntityDescription.entity(forEntityName: "Main", in: context) else { return }
    let main = NSManagedObject(entity: entity, insertInto: context)
    main.setValue(score, forKey: "bestScore")
    do {
      try context.save()
    } catch {
      print("Failed saving")
    }
  }
  func selectScore() -> Int {
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Main")
    do {
      guard let selectObjects = try context.fetch(request) as? [NSManagedObject] else { return 0 }
      if let result = selectObjects.last, let selectScore = result.value(forKey: "bestScore") as? Int {
        return selectScore
      }
    } catch {
      print("Failed select score")
    }
    return 0
  }
}
