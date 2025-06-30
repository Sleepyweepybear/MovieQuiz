import Foundation

protocol StatisticServiceProtocol {
    var gamesCount: Int { get set }
    var bestGame: GameResult { get set }
    var totalAccuracy: Double { get }
    
    
    func store(correct count: Int, total amount: Int)
}

struct GameResult: Codable {
    let correct: Int
    let total: Int
    let date: Date
    
    func compareResults(_ another: GameResult) -> Bool {
        correct > another.correct
    }
 }
