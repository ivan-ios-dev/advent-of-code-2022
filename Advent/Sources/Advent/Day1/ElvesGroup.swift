import Foundation

public struct ElvesGroup {
  let elves: [Elf]
  
  init?(from data: Data) {
    let str = String(decoding: data, as: UTF8.self)
    let itemsPerElf = str.components(separatedBy: "\n\n")
    
    var elves: [Elf] = []
    for elfItems in itemsPerElf {
      let items = elfItems.components(separatedBy: "\n")
      let elf = Elf(itemsCalories: items.compactMap{ Int($0) } )
      elves.append(elf)
    }
    self.elves = elves
  }
  
  var topCarrier: (index: Int, load: Int) {
    var currentTop: (index: Int, load: Int) = (-1, -1)
    
    for (i, elf) in elves.enumerated() {
      if elf.totalCalories > currentTop.load {
        currentTop.index = i
        currentTop.load = elf.totalCalories
      }
    }
    
    return currentTop
  }
  
  var topThreeCarriersLoad: Int {
    let sortedLoad = elves.map{ $0.totalCalories }.sorted()
    return sortedLoad.suffix(3).reduce(0, +)
  }
}
