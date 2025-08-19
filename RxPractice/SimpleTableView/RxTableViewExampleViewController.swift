import UIKit
import RxCocoa
import RxSwift
import SnapKit

class RxTableViewExampleViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.register(PracticeRxTableViewCell.self, forCellReuseIdentifier: PracticeRxTableViewCell.identifier)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        
        setTableView()
    }
    
    
    func setTableView() {
        let items = Observable.just(
            (0..<20).map { "\($0)" }
        )
        
        items.bind(to: tableView.rx.items(cellIdentifier: PracticeRxTableViewCell.identifier, cellType: PracticeRxTableViewCell.self)) { (row, element, cell) in
            cell.appNameLabel.text = "element:\(element), row: \(row)"
            cell.testButton.setTitle("테스트 버튼", for: .normal)
            
            cell.testButton.rx.tap
                .bind(with: self) { owner, value in
                    print(#function, "버튼 이벤트 \(value)")
                }.disposed(by: self.disposeBag)
            
            
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(String.self)
            .bind(with: self) { owner, value in
                print("텝: \(value)")
                owner.showAlert(tip: value)
            }.disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .bind(with: self) { owner, value in
                owner.showAlert(tip: "\(value.row)")
            }.disposed(by: disposeBag)
//            .bind { [weak self] value in
//                guard let self = self else { return }
//                showAlert(tip: "\(value.row)")
//            }.disposed(by: disposeBag)
        
        
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        
    }
    
    
   
    
    
}
