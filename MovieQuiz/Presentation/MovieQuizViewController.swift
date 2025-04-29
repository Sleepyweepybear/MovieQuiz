import UIKit

final class MovieQuizViewController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
                    // Создаём view, куда будем добавлять слой
                let view = UIView()
                
                // Загружаем изображение
                let image0 = UIImage(named: "MV5BZjY0OTU1YjItZDczMi00MDkxLWE3ZDMtYWI2ZTM2ZjI4NzFmXkEyXkFqcGdeQXVyNDczOTA3ODE@._V1_FMjpg_UX900_.jpg")?.cgImage

                // Создаём слой
                let layer0 = CALayer()
                layer0.contents = image0

                // Применяем трансформацию
                layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1.01, tx: 0, ty: 0))

                // Устанавливаем размеры и позицию слоя
                layer0.bounds = view.bounds
                layer0.position = view.center

                // Добавляем слой в представление
                view.layer.addSublayer(layer0)

                // Настроим края представления
                view.layer.cornerRadius = 20
                view.layer.borderWidth = 8
                view.layer.borderColor = UIColor(red: 0.376, green: 0.761, blue: 0.557, alpha: 1).cgColor

                // Добавляем view в родительский элемент
                let parent = self.view!
                parent.addSubview(view)

                // Настроим автолэйаут для view
                view.translatesAutoresizingMaskIntoConstraints = false
                view.widthAnchor.constraint(equalToConstant: 335).isActive = true
                view.heightAnchor.constraint(equalToConstant: 502).isActive = true
                view.leadingAnchor.constraint(equalTo: parent.leadingAnchor, constant: 20).isActive = true
                view.topAnchor.constraint(equalTo: parent.topAnchor, constant: 98).isActive = true
            }
    }

/*
 Mock-данные
 
 
 Картинка: The Godfather
 Настоящий рейтинг: 9,2
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Dark Knight
 Настоящий рейтинг: 9
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Kill Bill
 Настоящий рейтинг: 8,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Avengers
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Deadpool
 Настоящий рейтинг: 8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: The Green Knight
 Настоящий рейтинг: 6,6
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: ДА
 
 
 Картинка: Old
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: The Ice Age Adventures of Buck Wild
 Настоящий рейтинг: 4,3
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Tesla
 Настоящий рейтинг: 5,1
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
 
 
 Картинка: Vivarium
 Настоящий рейтинг: 5,8
 Вопрос: Рейтинг этого фильма больше чем 6?
 Ответ: НЕТ
*/
