import CoreData
import Foundation
final class ScoreViewModel {
  enum Level {
    case light
    case middle
    case hard
  }
  private var coreDataManager: CoreDataManager?
  public var context: NSManagedObjectContext?
  public var userBestScore: Int = 0
  private var maxNumbersInFormula: Int = 3
  private var maxCountInNumber: Int = 100
  private var maxFormulaType: Int = 2
  private var maxMultiplyNumber: Int = 10
  public var trainingLevel: Level = .light {
    didSet {
      switch trainingLevel {
      case .middle:
        maxNumbersInFormula = 5
        maxCountInNumber = 100
        maxFormulaType = 3
        maxMultiplyNumber = 30
      case .hard:
        maxNumbersInFormula = 7
        maxCountInNumber = 100
        maxFormulaType = 4
        maxMultiplyNumber = 30
      default:
        maxNumbersInFormula = 3
        maxCountInNumber = 100
        maxFormulaType = 2
        maxMultiplyNumber = 10
      }
    }
  }
  private var fullScore: Int = 0 {
    didSet {
      guard let trainingScore = self.bindTrainingScore else {
        return
      }
      trainingScore(fullScore, oldValue < fullScore)
    }
  }
  private var formulaModels: [FormulaModel] = [] {
    didSet {
      guard let trainingFormula = self.bindTrainingFormula else {
        return
      }
      var resultFormula = ""
      for item in formulaModels {
        switch item.type {
        case .plus:
          resultFormula.append(" + ")
        case .minus:
          resultFormula.append(" - ")
        case .multiply:
          resultFormula.append(" * ")
        case .divide:
          resultFormula.append(" / ")
        default:
          resultFormula.append("\(item.number)")
        }
      }
      formulaFormat = resultFormula
      trainingFormula(resultFormula)
    }
  }
  private var formulaFormat: String = ""
  var bindTrainingFormula: ((_ formula: String) -> Void)?
  var bindTrainingScore: ((_ score: Int, _ success: Bool) -> Void)?
  func initCoreDataManager(context: NSManagedObjectContext) {
    coreDataManager = CoreDataManager(context: context)
    userBestScore = coreDataManager!.selectScore()
  }
  func nextFormula() {
    var result: [FormulaModel] = []
    var lastFormulaType: FormulaModel.FormulaType = .number
    var isNumber = true
    for _ in 1 ... maxNumbersInFormula {
      if isNumber {
        var number = arc4random_uniform(UInt32(maxCountInNumber))
        if lastFormulaType == .multiply || lastFormulaType == .divide {
          number = arc4random_uniform(UInt32(maxMultiplyNumber))
        }
        result.append(FormulaModel(number: Int(number)))
      } else {
        let random = Int(arc4random_uniform(UInt32(maxFormulaType)))
        if let type = FormulaModel.FormulaType(rawValue: random) {
          result.append(FormulaModel(type: type))
          lastFormulaType = type
        }
      }
      isNumber = !isNumber
    }
    formulaModels = result
  }
  func checkAnswer(_ number: Double) {
    let mathExpression = NSExpression(format: formulaFormat)
    if let mathValue = mathExpression.expressionValue(with: nil, context: nil) as? Double {
      var result = Int(mathValue)
      if result < 0 {
        result = result * -1
      }
      if mathValue == number {
        fullScore += Int(result)
        if fullScore > userBestScore {
          if let dataManager = self.coreDataManager {
            dataManager.updateScore(score: fullScore)
            userBestScore = fullScore
          }
        }
      } else {
        fullScore -= Int(result)
      }
    }
  }
}
