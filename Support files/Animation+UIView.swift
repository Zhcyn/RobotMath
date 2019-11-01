import UIKit
extension UIView {
  func animateTransitionDown(duration: Double) {
    transform = CGAffineTransform(translationX: 0, y: 10)
    UIView.animate(withDuration: duration, animations: {
      self.transform = CGAffineTransform.identity
    }, completion: nil)
  }
  func animateFadeInDown(duration: Double, delay: Double = 0, y: CGFloat = 20) {
    transform = CGAffineTransform(translationX: 0, y: y)
    layer.opacity = 0
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      self.transform = CGAffineTransform.identity
      self.layer.opacity = 1
    }, completion: nil)
  }
  func animateFadeIn(duration: Double, delay: Double = 0) {
    layer.opacity = 0
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      self.layer.opacity = 1
    }, completion: nil)
  }
  func animateFadeOut(duration: Double, delay: Double = 0, completion: (() -> Void)?) {
    layer.opacity = 1
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      self.layer.opacity = 0
    }, completion: { _ in
      if let complite = completion {
        complite()
      }
    })
  }
  func animateScaleOut(duration: Double, delay: Double = 0, completion: (() -> Void)? = nil) {
    transform = CGAffineTransform.identity
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }, completion: { _ in
      if let complite = completion {
        complite()
      }
    })
  }
  func animateScaleIn(duration: Double, delay: Double = 0, completion: (() -> Void)? = nil) {
    transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    UIView.animate(withDuration: duration, delay: delay, options: .curveEaseInOut, animations: {
      self.transform = CGAffineTransform.identity
    }, completion: { _ in
      if let complite = completion {
        complite()
      }
    })
  }
  func animateBackgroundColor(colorStart: UIColor, colorEnd: UIColor, duration: Double) {
    UIView.animate(withDuration: duration, animations: {
      self.backgroundColor = colorEnd
    }, completion: { _ in
      UIView.animate(withDuration: duration, animations: {
        self.backgroundColor = colorStart
      }, completion: nil)
    })
  }
}
