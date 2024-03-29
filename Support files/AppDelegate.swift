import CoreData
import UIKit
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  func application(_: UIApplication, didFinishLaunchingWithOptions _: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    return true
  }
  func applicationWillResignActive(_: UIApplication) {
  }
  func applicationDidEnterBackground(_: UIApplication) {
  }
  func applicationWillEnterForeground(_: UIApplication) {
  }
  func applicationDidBecomeActive(_: UIApplication) {
  }
  func applicationWillTerminate(_: UIApplication) {
    saveContext()
  }
  lazy var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "BrainCalc")
    container.loadPersistentStores(completionHandler: { _, error in
      if let error = error as NSError? {
        fatalError("Unresolved error \(error), \(error.userInfo)")
      }
    })
    return container
  }()
  func saveContext() {
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
}
