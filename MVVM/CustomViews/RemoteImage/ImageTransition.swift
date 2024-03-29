import UIKit
import Foundation

enum ImageTransitionTiming: String {
  case easeInOut = "ease-in-out"
  case easeIn = "ease-in"
  case easeOut = "ease-out"
  case linear = "linear"

  func toAnimationOption() -> UIView.AnimationOptions {
    switch self {
    case .easeInOut:
      return .curveEaseInOut
    case .easeIn:
      return .curveEaseIn
    case .easeOut:
      return .curveEaseOut
    case .linear:
      return .curveLinear
    }
  }
}

enum ImageTransitionEffect: String {
  case crossDissolve = "cross-dissolve"
  case flipFromTop = "flip-from-top"
  case flipFromRight = "flip-from-right"
  case flipFromBottom = "flip-from-bottom"
  case flipFromLeft = "flip-from-left"
  case curlUp = "curl-up"
  case curlDown = "curl-down"

  func toAnimationOption() -> UIView.AnimationOptions {
    switch self {
    case .crossDissolve:
      return .transitionCrossDissolve
    case .flipFromLeft:
      return .transitionFlipFromLeft
    case .flipFromRight:
      return .transitionFlipFromRight
    case .flipFromTop:
      return .transitionFlipFromTop
    case .flipFromBottom:
      return .transitionFlipFromBottom
    case .curlUp:
      return .transitionCurlUp
    case .curlDown:
      return .transitionCurlDown
    }
  }
}

struct ImageTransition {
  var duration: Double = 100
  var timing: ImageTransitionTiming = .easeInOut
  var effect: ImageTransitionEffect = .crossDissolve

  func toAnimationOptions() -> UIView.AnimationOptions {
    return [timing.toAnimationOption(), effect.toAnimationOption()]
  }
}
