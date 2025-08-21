import UIKit
import SnapKit
import RxSwift
import RxCocoa


class RxNumberViewController: UIViewController {
    let disposeBag = DisposeBag()
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
    
    let divider: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        return view
    }()
    
    let resultLabel = UILabel()
    
    let viewModel = NumberVieModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configLayout()
        
        
        let input = NumberVieModel.Input(
            numberText1: numberTextField1.rx.text.orEmpty,
            numberText2: numberTextField2.rx.text.orEmpty,
            numberText3: numberTextField3.rx.text.orEmpty
        )
        
        let output = viewModel.transform(input: input)
        
        output.resultLabel
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    
    private func configUI() {
        view .backgroundColor = .white
        view.addSubview(numberTextField1)
        view.addSubview(numberTextField2)
        view.addSubview(numberTextField3)
        view.addSubview(divider)
        view.addSubview(resultLabel)
    }
    
    private func configLayout() {
        numberTextField2.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        numberTextField1.snp.makeConstraints { make in
            make.bottom.equalTo(numberTextField2.snp.top).offset(-16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(numberTextField2)
        }
        
        numberTextField3.snp.makeConstraints { make in
            make.top.equalTo(numberTextField2.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(numberTextField2)
        }
        
        divider.snp.makeConstraints { make in
            make.top.equalTo(numberTextField3.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(numberTextField2)
            make.height.equalTo(1)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
    }
}
