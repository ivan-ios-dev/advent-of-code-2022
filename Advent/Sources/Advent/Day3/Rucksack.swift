import Foundation

struct Rucksack {
  struct Compartment {
    let items: [Character]
    init(itemsString: String) {
      self.items = Array(itemsString)
    }
  }
  
  let firstCompartment: Compartment
  let secondCompartment: Compartment
  
  init(itemsString: String) {
    let itemsCount = itemsString.count
    self.firstCompartment = .init(itemsString: String(itemsString.prefix(itemsCount/2)))
    self.secondCompartment = .init(itemsString: String(itemsString.suffix(itemsCount/2)))
  }
  
  var duplicate: Character {
    let firstItems = Set(firstCompartment.items)
    let secondItems = Set(secondCompartment.items)
    let duplicates = firstItems.intersection(secondItems)
    return duplicates.first!
  }
  
  var allItems: [Character] {
    return firstCompartment.items + secondCompartment.items
  }
}
