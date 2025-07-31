import UIKit

final class MovieQuizViewController: UIViewController, AlertPresenterProtocol, MovieQuizViewControllerProtocol {
    
    // MARK: - Outlets and Presenter
    
    @IBOutlet private weak var yesButton: UIButton!
    @IBOutlet private weak var noButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var counterLabel: UILabel!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
     
    private var presenter: MovieQuizPresenter!
    private lazy var alertPresenter = AlertPresenter(view: self, viewController: self)
    private var buttonsAreLocked = false

    // MARK: - IBAction
    
    @IBAction private func yesButtonClicked(_ sender: UIButton) {
        guard !buttonsAreLocked else { return }
           buttonsAreLocked = true
           presenter.yesButtonClicked()
    }
    
    @IBAction private func noButtonClicked(_ sender: UIButton) {
        guard !buttonsAreLocked else { return }
           buttonsAreLocked = true
           presenter.noButtonClicked()
    }
    
    // MARK: - AlertPresenterProtocol
    
    func present(alert: UIAlertController, animated: Bool) {
        if presentedViewController == nil {
            self.present(alert, animated: animated)
        }
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MovieQuizPresenter(viewController: self)
        
        imageView.layer.cornerRadius = 20
        showLoadingIndicator()
    }
    
    // MARK: - Public Methods
    
    func setUp () {
        imageView.layer.cornerRadius = 20
        noButton.layer.cornerRadius = 15
        yesButton.layer.cornerRadius = 15
    }
    
    func showLoadingIndicator() {
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
    }
    
    func hideLoadingIndicator() {
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func show(quiz step: QuizStepViewModel) {
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0
        imageView.layer.borderColor = UIColor.clear.cgColor

        imageView.image = step.image
        textLabel.text  = step.question
        counterLabel.text = step.questionNumber
        
        yesButton.isEnabled = true
        noButton.isEnabled = true
        buttonsAreLocked = false
    }
    
    func show(quiz result: QuizResultsViewModel) {
           let message = presenter.makeResultsMessage()
           
           let alert = UIAlertController(
               title: result.title,
               message: message,
               preferredStyle: .alert)
               
           let action = UIAlertAction(title: result.buttonText, style: .default) { [weak self] _ in
                   guard let self = self else { return }
                   
                   self.presenter.restartGame()
           }
           
           alert.addAction(action)
           
           self.present(alert, animated: true, completion: nil)
       }
    
    func highlightImageBorder(isCorrectAnswer: Bool) {
         imageView.layer.masksToBounds = true
         imageView.layer.borderWidth = 8
         imageView.layer.borderColor = isCorrectAnswer ? UIColor.ypGreen.cgColor : UIColor.ypRed.cgColor
     }
    
    func showNetworkError(message: String) {
           hideLoadingIndicator()

           let alert = UIAlertController(
               title: "Ошибка",
               message: message,
               preferredStyle: .alert)

               let action = UIAlertAction(title: "Попробовать ещё раз",
               style: .default) { [weak self] _ in
                   guard let self = self else { return }

                   self.presenter.restartGame()
               }

           alert.addAction(action)
        present(alert: alert, animated: true) 
       }
}


