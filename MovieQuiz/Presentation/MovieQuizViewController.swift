import UIKit

final class MovieQuizViewController: UIViewController, QuestionFactoryDelegate {
    
    // MARK: - ViewModels

    private struct ViewModel {
        let image: UIImage
        let question: String
        let questionNumber: String
    }

    private struct QuizResultsAnswerViewModel {
        let title: String
        let text: String
        let buttonText: String
    }
    
    // MARK: - Button Actions

    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        noButton.isEnabled = false
        guard let currentQuestion = currentQuestion else { return }
        let givenAnswer = true
        
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        yesButton.isEnabled = false
        guard let currentQuestion = currentQuestion else { return }
        let givenAnswer = false
            
        showAnswerResult(isCorrect: givenAnswer == currentQuestion.correctAnswer)
    }
    
    // MARK: - Outlets

    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    
    // MARK: - Properties

    private var currentQuestionIndex = 0
    private var correctAnswers = 0
    private let questionsAmount = 10
    private var questionFactory: QuestionFactoryProtocol?
    private var currentQuestion: QuizQuestion?
    private var alertPresenter: AlertPresenterProtocol?
    private var statisticService: StatisticServiceProtocol?

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        alertPresenter = AlertPresenter(viewController: self)
        questionFactory = QuestionFactory(delegate: self)
        questionFactory?.requestNextQuestion()
        statisticService = StatisticService()

    }
    // MARK: - QuestionFactoryDelegate.
    
    func didReceiveNextQuestion(question: QuizQuestion?) {
        guard let question = question else {
            return
        }
        
        currentQuestion = question
        let viewModel = convert(model: question)
        
        DispatchQueue.main.async { [weak self] in
            self?.show(quiz: viewModel)
        }
    }
    
    private func setUp () {
        imageView.layer.cornerRadius = 20
        noButton.layer.cornerRadius = 15
        yesButton.layer.cornerRadius = 15
    }
    
    private func convert(model: QuizQuestion) -> QuizStepViewModel {
        return QuizStepViewModel(
            image: UIImage(named: model.image) ?? UIImage(),
            question: model.text,
            questionNumber: "\(currentQuestionIndex + 1)/\(questionsAmount)")
    }
    
    private func showAnswerResult(isCorrect: Bool) {
        if isCorrect {
            correctAnswers += 1
        }
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 8
        imageView.layer.borderColor = isCorrect ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            guard let self = self else { return }
            self.imageView.layer.borderWidth = 0
            self.showNextQuestionOrResults()
        }
    }
    
    private func show(quiz step: QuizStepViewModel) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        
        imageView.image = step.image
        textLabel.text = step.question
        counterLabel.text = step.questionNumber
    }
    
    private func setAnswerButtonsState(isEnabled: Bool) {
        yesButton.isEnabled = isEnabled
        noButton.isEnabled = isEnabled
    }
    
    private func showNextQuestionOrResults() {
        setAnswerButtonsState(isEnabled: true)
        
        if currentQuestionIndex == questionsAmount - 1 {
            statisticService?.store(correct: correctAnswers, total: questionsAmount)

            let bestGame = statisticService?.bestGame
            let totalAccuracy = statisticService?.totalAccuracy ?? 0
            let gamesCount = statisticService?.gamesCount ?? 0
            let formattedDate = bestGame?.date.dateTimeString ?? ""
            let message = """
            Ваш результат: \(correctAnswers)/\(questionsAmount)
            Количество сыгранных квизов: \(gamesCount)
            Рекорд: \(bestGame?.correct ?? 0)/\(bestGame?.total ?? 0) (\(formattedDate))
            Средняя точность: \(String(format: "%.2f", totalAccuracy))%
            """

            let alertModel = AlertModel(
                title: "Этот раунд окончен!",
                message: message,
                buttonText: "Сыграть ещё раз",
                completion: { [weak self] in
                    guard let self = self else { return }
                    self.currentQuestionIndex = 0
                    self.correctAnswers = 0
                    self.questionFactory?.requestNextQuestion()
                }
            )
            alertPresenter?.present(alertModel)
            
        } else {
            currentQuestionIndex += 1
            questionFactory?.requestNextQuestion()
        }
    }
}

