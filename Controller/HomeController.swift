import UIKit
final class HomeController: UIViewController {
  @IBOutlet var buttonLight: UIButton!
  @IBOutlet var buttonMiddle: UIButton!
  @IBOutlet var buttonHard: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    localizationButtons()
    animateStart()
  }
  override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
    guard let id = segue.identifier else {
      return
    }
    guard let trainingController = segue.destination as? TrainingController else {
      return
    }
    switch id {
    case "LevelMiddle":
      trainingController.trainingLevel = .middle
    case "LevelHard":
      trainingController.trainingLevel = .hard
    default:
      trainingController.trainingLevel = .light
    }
  }
  private func localizationButtons() {
    if let attributedTitle = self.buttonLight.attributedTitle(for: .normal) {
      let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
      let title = NSLocalizedString("Ease", comment: "Button level training")
      mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: title)
      buttonLight.setAttributedTitle(mutableAttributedTitle, for: .normal)
    }
    if let attributedTitle = self.buttonMiddle.attributedTitle(for: .normal) {
      let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
      let title = NSLocalizedString("Medium", comment: "Button level training")
      mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: title)
      buttonMiddle.setAttributedTitle(mutableAttributedTitle, for: .normal)
    }
    if let attributedTitle = self.buttonHard.attributedTitle(for: .normal) {
      let mutableAttributedTitle = NSMutableAttributedString(attributedString: attributedTitle)
      let title = NSLocalizedString("Hard", comment: "Button level training")
      mutableAttributedTitle.replaceCharacters(in: NSMakeRange(0, mutableAttributedTitle.length), with: title)
      buttonHard.setAttributedTitle(mutableAttributedTitle, for: .normal)
    }
  }
  private func animateStart() {
    buttonLight.animateFadeInDown(duration: 0.5, delay: 0)
    buttonMiddle.animateFadeInDown(duration: 0.5, delay: 0.3)
    buttonHard.animateFadeInDown(duration: 0.5, delay: 0.6)
  }
}
