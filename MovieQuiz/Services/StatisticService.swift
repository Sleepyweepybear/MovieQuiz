import Foundation

final class StatisticService {
    private let storage = UserDefaults.standard
    
    private enum Keys: String {
        case gamesCount, correct, total, date
        case totalCorrect, totalQuestions, correctAnswers
    }
}
    
    extension StatisticService: StatisticServiceProtocol {
        
        var gamesCount: Int {
            get {
                storage.integer(forKey: Keys.gamesCount.rawValue)
            }
            set {
                storage.set(newValue, forKey: Keys.gamesCount.rawValue)
            }
        }
        
       private var correctAnswers: Int {
            get {
                storage.integer(forKey: Keys.correctAnswers.rawValue)
            }
               set {
                   storage.set(newValue, forKey: Keys.correctAnswers.rawValue)
               }
           }
        
        var totalAccuracy: Double {
            let correct = storage.integer(forKey: Keys.totalCorrect.rawValue)
            let total = storage.integer(forKey: Keys.totalQuestions.rawValue)
            guard total != 0 else { return 0 }
            return (Double(correct) / Double(total)) * 100
        }
        
        
        var bestGame: GameResult {
            get {
                let correct = storage.integer(forKey: Keys.correct.rawValue)
                let total = storage.integer(forKey: Keys.total.rawValue)
                let date = storage.object(forKey: Keys.date.rawValue) as? Date ?? Date()
                return GameResult(correct: correct, total: total, date: date)
            }
            
            set {
                storage.set(newValue.correct, forKey: Keys.correct.rawValue)
                storage.set(newValue.total, forKey: Keys.total.rawValue)
                storage.set(newValue.date, forKey: Keys.date.rawValue)
            }
        }
        
        func store(correct count: Int, total amount: Int) {
            gamesCount += 1
            
            let totalCorrect = storage.integer(forKey: Keys.totalCorrect.rawValue)
            storage.set(totalCorrect + count, forKey: Keys.totalCorrect.rawValue)
            
            let totalQuestions = storage.integer(forKey: Keys.totalQuestions.rawValue)
            storage.set(totalQuestions + amount, forKey: Keys.totalQuestions.rawValue)
            
            let newResult = GameResult(correct: count, total: amount, date: Date())
            if newResult.compareResults(bestGame) {
                bestGame = newResult
            }
        }
    }

