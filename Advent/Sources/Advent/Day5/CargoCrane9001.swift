import Foundation

final class CargoCrane9001: CargoCrane {
  override func perform(command: CargoCrane.MoveCommand) {
    if let sourceStack = cargoField.first(where: { $0.index == command.fromStackIndex } ),
        let destinationStack = cargoField.first(where: { $0.index == command.toStackIndex }) {
      
      var cratesCache: [Character] = []
      
      for _ in 1...command.amount {
        if let crate = sourceStack.takeCrate() {
          cratesCache.append(crate)
        }
      }
      
      for crate in cratesCache.reversed() {
        destinationStack.add(crate: crate)
      }
    }
  }
}
