
import UIKit

class ViewController: UIViewController {
    
    private let imgView: UIImageView = {
        let logo = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 185))
        logo.image = UIImage(named: "logo")
        return logo
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imgView)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            loginVC.modalTransitionStyle = .crossDissolve
            self.present(loginVC, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imgView.center = view.center
    }
    
}

