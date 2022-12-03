import Foundation

public struct Elf {
  let itemsCalories: [Int]
  var totalCalories: Int {
    return itemsCalories.reduce(0, +)
  }
}


