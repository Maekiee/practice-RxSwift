import Foundation
import RxSwift
import RxCocoa


class NumberVieModel {
    private let disposeBag = DisposeBag()
    
    struct Input {
        let numberText1: ControlProperty<String>
        let numberText2: ControlProperty<String>
        let numberText3: ControlProperty<String>
    }
    
    struct outPut {
        let resultLabel: BehaviorSubject<String>
    }
    
    init() { }
    
    
    func transform(input: Input) -> outPut {
        
        let result = BehaviorSubject<String>(value: "")
        
        Observable.combineLatest(
            input.numberText1,
            input.numberText1,
            input.numberText1,
        ) { (value1, value2, value3) -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }.map { $0.description }
            .bind(with: self, onNext: { owner, value in
                result.onNext(value)
            })
            .disposed(by: disposeBag)
            
        return outPut(resultLabel: result)
    }
}
