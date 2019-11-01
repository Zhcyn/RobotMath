import UIKit
final class KeyboardViewModel {
  public let keys: [KeyModel]
  private var userNumber: String {
    didSet {
      guard let numberBind = self.bindTrainingNumber else {
        return
      }
      numberBind(userNumber)
    }
  }
  private var userResult: Double {
    didSet {
      guard let enterBind = self.bindTrainingResult else {
        return
      }
      enterBind(userResult)
    }
  }
  var bindTrainingNumber: ((_ userNumber: String) -> Void)?
  var bindTrainingResult: ((_ userResult: Double) -> Void)?
  init() {
    var createKeys: [KeyModel] = []
    for number in 1 ... 9 {
      createKeys.append(KeyModel(name: "\(number)", type: .number))
    }
    createKeys.append(KeyModel(name: "0", type: .number))
    createKeys.append(KeyModel(name: "-", type: .number))
    let keyCancelText = NSLocalizedString("Clean", comment: "Keyboard clean button")
    let keyCancel = KeyModel(name: keyCancelText, type: .clean, imageName: "clean")
    createKeys.append(keyCancel)
    let keyEnterText = NSLocalizedString("Send", comment: "Keyboard enter button")
    let keyEnter = KeyModel(name: keyEnterText, type: .enter, imageName: "enter")
    createKeys.append(keyEnter)
    keys = createKeys
    userNumber = ""
    userResult = 0
  }
  func touchButton(_ keyModel: KeyModel) {
    switch keyModel.buttonType {
    case .clean:
      if userNumber.count > 1 {
        userNumber.removeLast()
      } else {
        userNumber = ""
      }
    case .enter:
      guard let result = Double(self.userNumber) else {
        break
      }
      userNumber = ""
      userResult = result
    default:
      userNumber += "\(keyModel.buttonName)"
    }
  }
}
