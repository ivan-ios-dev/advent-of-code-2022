import Foundation

struct ElvesSafetyGroupBelongings {
  let first: Rucksack
  let second: Rucksack
  let third: Rucksack
  
  var badgeItem: Character {
    let firstSet = Set(first.allItems)
    let secondSet = Set(second.allItems)
    let thirdSet = Set(third.allItems)
    return firstSet.intersection(secondSet).intersection(thirdSet).first!
  }
}
