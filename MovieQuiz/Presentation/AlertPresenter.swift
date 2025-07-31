import UIKit

class AlertPresenter {
    private weak var view: AlertPresenterProtocol?
    private weak var viewController: UIViewController?
    
    init(view: AlertPresenterProtocol, viewController: UIViewController) {
        self.view = view
        self.viewController = viewController
    }
    
    func show(alert model: AlertModel) {
        let alert = UIAlertController(
            title: model.title,
            message: model.message,
            preferredStyle: .alert)
        
        let action = UIAlertAction(title: model.buttonText, style: .default) { _ in
            model.completion?()
        }
        
        alert.addAction(action)
        view?.present(alert: alert, animated: true)
        
        if viewController?.presentedViewController == nil {
            view?.present(alert: alert, animated: true)
        }
    }
}
