import UIKit
import SnapKit

class ViewController: UIViewController {
    let numberTextField1: UITextField = {
        let tf = UITextField()
        tf.placeholder = "숫자 입력 1"
        tf.borderStyle = .roundedRect
        return tf
    }()
    let numberTextField2: UITextField = {
        let tf = UITextField()
        tf.placeholder = "숫자 입력 2"
        tf.borderStyle = .roundedRect
        return tf
    }()
    let numberTextField3: UITextField = {
        let tf = UITextField()
        tf.placeholder = "숫자 입력 3"
        tf.borderStyle = .roundedRect
        return tf
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configLayout()
    }
    
    private func configUI() {
        view .backgroundColor = .white
        view.addSubview(numberTextField1)
        view.addSubview(numberTextField1)
        view.addSubview(numberTextField1)
    }
    
    private func configLayout() {
        numberTextField1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
            make.height.equalTo(44)
        }
        numberTextField2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(numberTextField1.snp.bottom).offset(8)
            make.height.equalTo(44)
        }
        
        numberTextField3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(numberTextField2.snp.bottom).offset(80)
            make.height.equalTo(44)
        }
    }
}


