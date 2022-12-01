import Foundation

final class TestBundle {
  
  static func inputData(for day: Int) -> Data {
    let inputsBundlePath = Bundle.module.path(forResource: "days", ofType: "bundle")!
    let txtFilePath: String = inputsBundlePath + "/\(day)/input.txt"
    return try! Data.init(contentsOf: URL(fileURLWithPath: txtFilePath))
  }
}

