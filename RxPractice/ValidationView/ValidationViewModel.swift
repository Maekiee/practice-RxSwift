import Foundation
import RxSwift
import RxCocoa

final class ValidationViewModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let userName: ControlProperty<String>
        let password: ControlProperty<String>
    }
    
    struct Output {
        let userNamevalidationText: BehaviorSubject<(Bool, String)>
        let passwordValidateText: BehaviorSubject<(Bool, String)>
    }
    
    init() { }

    func transform(input: Input) -> Output {
        let userNamevalidateText = BehaviorSubject<(Bool, String)>(value: (false, ""))
        let passwordValidateText = BehaviorSubject<(Bool, String)>(value: (false, ""))
        
        input.userName
            .bind(with: self) { owner, name in
                
                let allow = name.count >= 5
                let text = allow ? "유효한 닉네임 입니다." : "유효하지 않은 닉네임 입니다."
                
                userNamevalidateText.onNext((allow, text))
            }.disposed(by: disposeBag)
        
        input.password
            .bind(with: self) { owner, password in
                
                let allow = password.count >= 5
                let text = allow ? "유효한 비밀번호 입니다." : "유효하지 않은 비밀번호 입니다."
                passwordValidateText.onNext((allow, text))
            }
            .disposed(by: disposeBag)

        
        return Output(userNamevalidationText: userNamevalidateText, passwordValidateText: passwordValidateText)
    }
}
