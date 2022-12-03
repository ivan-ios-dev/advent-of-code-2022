import Foundation

struct Game {
  let rounds: [GameRound]
  var score: Int {
    rounds.map{ $0.myScore }.reduce(0, +)
  }
  
  init(data: Data) {
    let str = String(decoding: data, as: UTF8.self)
    
    let rows = str.components(separatedBy: "\n").filter{ !$0.isEmpty }
    
    var rounds: [GameRound] = []
    
    for row in rows {
      let rivalLetter = row.first!
      let myLetter = row.last!
      
      let round = GameRound(myLetter: myLetter, rivalLetter: rivalLetter)
      rounds.append(round)
    }
    
    self.rounds = rounds
  }
}
