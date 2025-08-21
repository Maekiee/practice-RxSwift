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
            input.numberText2,
            input.numberText3,
        ) { (value1, value2, value3) -> Int in
            print("일번 \(value1), 이번 \(value2), 삼번 \(value3)")
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }.map { $0.description }
            .bind(with: self) { owner, value in
                print("뷰 모델:", value)
                result.onNext(value)
            }
            .disposed(by: disposeBag)
            
        return outPut(resultLabel: result)
    }
}
