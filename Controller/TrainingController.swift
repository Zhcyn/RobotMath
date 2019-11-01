import CoreData
import UIKit
final class TrainingController: UIViewController {
  public var trainingLevel: ScoreViewModel.Level?
  private var delayLastAnimationCell: Double = 0
  private let keyboardViewModel = KeyboardViewModel()
  private let scoreViewModel = ScoreViewModel()
  @IBOutlet var labelFormula: UILabel!
  @IBOutlet var labelUserNumber: UILabel!
  @IBOutlet var labelUserScore: UILabel!
  @IBOutlet var viewAnswerBackground: UIView!
  @IBAction func buttonEndGame(_: UIButton) {
    navigationController?.popToRootViewController(animated: true)
  }
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  override func prepare(for segue: UIStoryboardSegue, sender _: Any?) {
    guard let id = segue.identifier else {
      return
    }
    if id == "EndTraining", let endController = segue.destination as? EndController {
      endController.bestScore = scoreViewModel.userBestScore
    }
  }
  private func configure() {
    keyboardViewModel.bindTrainingNumber = { number in
      self.labelUserNumber.text = number
    }
    keyboardViewModel.bindTrainingResult = { result in
      self.scoreViewModel.checkAnswer(result)
      self.scoreViewModel.nextFormula()
    }
    scoreViewModel.bindTrainingFormula = { formula in
      self.labelFormula.animateFadeOut(duration: 0.3, completion: {
        self.labelFormula.text = formula
        self.labelFormula.animateFadeIn(duration: 0.3)
      })
    }
    scoreViewModel.bindTrainingScore = { score, success in
      self.labelUserScore.animateFadeOut(duration: 0.5, completion: {
        self.labelUserScore.text = "\(score)"
        self.labelUserScore.animateFadeIn(duration: 0.5)
      })
      let colorStart = self.viewAnswerBackground.backgroundColor ?? UIColor.white
      let colorSuccess = UIColor.green
      let colorError = UIColor.red
      if success {
        self.viewAnswerBackground.animateBackgroundColor(colorStart: colorStart, colorEnd: colorSuccess, duration: 0.5)
      } else {
        self.viewAnswerBackground.animateBackgroundColor(colorStart: colorStart, colorEnd: colorError, duration: 0.5)
      }
      if score < 0 {
        self.performSegue(withIdentifier: "EndTraining", sender: self)
      }
    }
    if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
      let context = appDelegate.persistentContainer.viewContext
      scoreViewModel.trainingLevel = trainingLevel ?? .light
      scoreViewModel.initCoreDataManager(context: context)
      scoreViewModel.nextFormula()
    }
  }
}
extension TrainingController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_: UICollectionView, numberOfItemsInSection _: Int) -> Int {
    return keyboardViewModel.keys.count
  }
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let keyModel = keyboardViewModel.keys[indexPath.row]
    if keyModel.buttonType == .number {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardNumberCell", for: indexPath)
      if let keyboardCell = cell as? KeyboardNumberCell {
        keyboardCell.labelNumber.text = keyModel.buttonName
      }
      cell.animateFadeInDown(duration: 0.2, delay: delayLastAnimationCell)
      delayLastAnimationCell += 0.1
      return cell
    } else {
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "KeyboardFuncCell", for: indexPath)
      if let keyboardCell = cell as? KeyboardFuncCell {
        keyboardCell.labelName.text = keyModel.buttonName
        if let imageName: String = keyModel.imageName {
          keyboardCell.imageIcon.image = UIImage(named: imageName)
        }
        keyboardCell.animateFadeInDown(duration: 0.2, delay: delayLastAnimationCell)
        delayLastAnimationCell += 0.1
      }
      return cell
    }
  }
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let keyModel = keyboardViewModel.keys[indexPath.row]
    if let cell = collectionView.cellForItem(at: indexPath) {
      cell.animateScaleOut(duration: 0.2, completion: {
        cell.animateScaleIn(duration: 0.2)
      })
    }
    keyboardViewModel.touchButton(keyModel)
  }
  func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt _: IndexPath) -> CGSize {
    let bounds = collectionView.bounds
    let width = bounds.width / CGFloat(5) - CGFloat(5)
    return CGSize(width: width, height: width)
  }
}
