import Foundation

public enum HandShape {
  case rock
  case paper
  case scissors
  
  public func beats() -> Self {
    switch self {
    case .rock: return .scissors
    case .paper: return .rock
    case .scissors: return .paper
    }
  }
  
  //A for Rock, B for Paper, and C for Scissors
  public init?(playerLetter: Character) {
    switch playerLetter {
    case "A":
      self = .rock
    case "B":
      self = .paper
    case "C":
      self = .scissors
    default:
      return nil
    }
  }

  //(1 for Rock, 2 for Paper, and 3 for Scissors)
  public var score: Int {
    switch self {
    case .rock: return 1
    case .paper: return 2
    case .scissors: return 3
    }
  }
}
