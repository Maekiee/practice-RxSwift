import UIKit
import SnapKit
import RxCocoa
import RxSwift


class RxValidationViewController: UIViewController {
    let disposeBag = DisposeBag()
    private let usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let usernameTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let userNameValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        return label
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let tf = UITextField()
        tf.borderStyle = .roundedRect
        tf.isSecureTextEntry = true
        return tf
    }()
    
    private let passwordValidationLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .red
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Do something", for: .normal)
        button.backgroundColor = UIColor.green.withAlphaComponent(0.7)
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configLayout()
        
        let userNameValid = usernameTextField.rx.text.orEmpty
            .map { $0.count >= 5}
            .share(replay: 1)
        
        let passWordValid = passwordTextField.rx.text.orEmpty
            .map { $0.count >= 5}
            .share(replay: 1)
        
        let everyThingValid = Observable.combineLatest(userNameValid, passWordValid) { $0 && $1}.share(replay: 1)
        
        userNameValid.bind(with: self) { owner, value in
            owner.userNameValidationLabel.text = value ? "유효한 닉네임 입니다." : "유효하지 않은 닉네임 입니다."
            owner.userNameValidationLabel.textColor = value ? .green : .red
            owner.userNameValidationLabel.isHidden = !value
        }.disposed(by: disposeBag)
        
        passWordValid.bind(with: self) { owner, value in
            owner.passwordValidationLabel.text = value ? "유효한 비밀번호 입니다." : "유효하지 않은 비밀번호 입니다."
            owner.passwordValidationLabel.textColor = value ? .green : .red
            owner.passwordValidationLabel.isHidden = !value
        }.disposed(by: disposeBag)
        
        everyThingValid.bind(with: self) { owner, value in
            owner.actionButton.isEnabled = !value
            owner.actionButton.backgroundColor = value ? .green : .gray
        }.disposed(by: disposeBag)
        
        //        usernameTextField.rx.text.orEmpty
        //            .map { $0.count >= 5 }
        //            .bind(with: self) { owner, value in
        //                print(value)
        //                owner.userNameValidationLabel.text = value ? "유효한 닉네임 입니다." : "유효하지 않은 닉네임 입니다."
        //                owner.userNameValidationLabel.textColor = value ? .green : .red
        //            }.disposed(by: disposeBag)
        //
        //        passwordTextField.rx.text.orEmpty
        //            .skip(2)
        //            .map { $0.count >= 5 }
        //            .bind(with: self) { owner, value in
        //                print(value)
        //                owner.passwordValidationLabel.text = value ? "유효한 비밀번호 입니다." : "유효하지 않은 비밀번호 입니다."
        //                owner.passwordValidationLabel.textColor = value ? .green : .red
        //            }.disposed(by: disposeBag)
    }
    
    
    
    private func configUI() {
        view.backgroundColor = .white
        [usernameLabel, usernameTextField,
         userNameValidationLabel, passwordLabel,
         passwordTextField, passwordValidationLabel,
         actionButton].forEach { view.addSubview($0) }
    }
    
    private func configLayout() {
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameLabel)
            make.height.equalTo(40)
        }
        
        userNameValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameLabel)
        }
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameValidationLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(usernameLabel)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameLabel)
            make.height.equalTo(40)
        }
        
        passwordValidationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.leading.trailing.equalTo(usernameLabel)
        }
        
        actionButton.snp.makeConstraints { make in
            make.top.equalTo(passwordValidationLabel.snp.bottom).offset(20)
            make.leading.trailing.equalTo(usernameLabel)
            make.height.equalTo(50)
        }
    }
    
}
