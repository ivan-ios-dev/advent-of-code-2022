import Foundation

class CargoCrane {
  struct MoveCommand {
    let amount: Int
    let fromStackIndex: Int
    let toStackIndex: Int
    
    init?(command: String) {
      let parts = command.components(separatedBy: .letters).filter{ !$0.isEmpty }.map{ $0.replacingOccurrences(of: " ", with: "") }
      guard parts.count == 3 else {
        return nil
      }
      self.amount = Int(parts[0])!
      self.fromStackIndex = Int(parts[1])!
      self.toStackIndex = Int(parts[2])!
    }
  }
  
  let cargoField: [CrateStack]
  let commands: [MoveCommand]
  
  init(cargoField: [CrateStack], commands: [MoveCommand] = []) {
    self.cargoField = cargoField
    self.commands = commands
  }
  
  func perform(command: MoveCommand) {
    if let sourceStack = cargoField.first(where: { $0.index == command.fromStackIndex } ),
        let destinationStack = cargoField.first(where: { $0.index == command.toStackIndex }) {
      
      for _ in 1...command.amount {
        if let crate = sourceStack.takeCrate() {
          destinationStack.add(crate: crate)
        }
      }
    }
  }
  
  func performAllCommands() {
    for command in commands {
      perform(command: command)
    }
  }
  
  func topCratesString() -> String {
    let topCrates = cargoField.sorted(by: { $0.index < $1.index }).compactMap{ $0.topCrate }
    return String(topCrates)
  }
}

extension CargoCrane {
  convenience init?(withInput: String) {
    let rows = withInput.components(separatedBy: "\n")
    
    var crates: [CrateStack] = []
    var commands: [MoveCommand] = []
    
    for row in rows {
      //Crates
      if row.contains("[") {
        let chars = Array(row)

        for i in 0..<chars.count {
          let char = chars[i]
          if char == "[" {
            let crate = chars[i+1]
            let index = i/4 + 1
            
            if let existing = crates.first(where: { $0.index == index }) {
              existing.crates.insert(crate, at: 0)
            } else {
              let new = CrateStack(index: index)
              new.add(crate: crate)
              crates.append(new)
            }
          }
        }
      } else if row.contains("move") { // Command
        if let command = MoveCommand(command: row) {
          commands.append(command)
        }
      } else { //Crate Index or last empty line
        print("Row: \(row)")
      }
    }
    
    self.init(cargoField: crates, commands: commands)
  }
}
