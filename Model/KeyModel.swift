final class KeyModel {
  let buttonName: String
  let buttonType: KeyType
  let imageName: String?
  init(name: String, type: KeyType, imageName: String? = nil) {
    buttonName = name
    buttonType = type
    self.imageName = imageName
  }
  enum KeyType {
    case number
    case clean
    case enter
  }
}
