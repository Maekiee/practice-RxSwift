import UIKit
import SnapKit
import RxCocoa
import RxSwift


class RxValidationViewController: UIViewController {
    let disposeBag = DisposeBag()
    let viewModel = ValidationViewModel()
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
        bind()
    }
    
    func bind() {
        
        let input = ValidationViewModel.Input(
            userName: usernameTextField.rx.text.orEmpty,
            password: passwordTextField.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.userNamevalidationText
            .skip(2)
            .bind(with: self) { owner, value in
                owner.userNameValidationLabel.text = value.1
                owner.userNameValidationLabel.textColor = value.0 ? .green : .red
            }
            .disposed(by: disposeBag)
        
        output.passwordValidateText
            .skip(2)
            .bind(with: self) { owner, value in
                owner.passwordValidationLabel.text = value.1
                owner.passwordValidationLabel.textColor = value.0 ? .green : .red
            }
            .disposed(by: disposeBag)
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
