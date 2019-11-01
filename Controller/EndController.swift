import UIKit
final class EndController: UIViewController {
  public var bestScore: Int = 0
  @IBOutlet var labelScore: UILabel!
  @IBOutlet var buttonMenu: UIButton!
  @IBAction func buttonMenu(sender _: UIButton) {
    if let navigation = self.navigationController {
      navigation.popToRootViewController(animated: true)
    }
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    labelScore.text = "\(bestScore)"
    localizationButton()
    animateStart()
  }
  private func localizationButton() {
    if let attributedTitle = self.buttonMenu.attributedTitle(for: .normal) {
      let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
      let title = NSLocalizedString("Menu", comment: "Button return menu")
      mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: title)
      buttonMenu.setAttributedTitle(mutableAttributedTitle, for: .normal)
    }
  }
  private func animateStart() {
    labelScore.animateFadeInDown(duration: 0.3)
    buttonMenu.animateFadeInDown(duration: 0.3, delay: 0.3)
  }
}
