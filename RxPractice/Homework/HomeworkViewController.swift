
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let profileImage: String
}

class HomeworkViewController: UIViewController {
    let tableView = UITableView()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    let searchBar = UISearchBar()
    let disposeBag = DisposeBag()
    
    let viewModel = HomeworkViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        
        let input = HomeworkViewModel.Input(
            searchBarEvent: searchBar.rx.searchButtonClicked,
            searchText: searchBar.rx.text.orEmpty,
            selectedCellEvent: tableView.rx.modelSelected(Person.self)

        )
        
        let output = viewModel.transform(input: input)
        
        output.personList
            .bind(to: tableView.rx.items) { (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: PersonTableViewCell.identifier) as! PersonTableViewCell
                let urlString = URL(string: element.profileImage)
                cell.usernameLabel.text = element.name
                cell.profileImageView.kf.setImage(with: urlString)
                return cell
            }
            .disposed(by: disposeBag)
        
        output.selectedPersonList
            .bind(to: collectionView.rx.items(cellIdentifier: UserCollectionViewCell.identifier, cellType: UserCollectionViewCell.self)) { row, name, cell in
                cell.label.text = name
            }.disposed(by: disposeBag)
        
    }
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        view.addSubview(collectionView)
        view.addSubview(searchBar)
        
        navigationItem.titleView = searchBar
        
        collectionView.register(UserCollectionViewCell.self, forCellWithReuseIdentifier: UserCollectionViewCell.identifier)
        collectionView.backgroundColor = .lightGray
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(50)
        }
        
        tableView.register(PersonTableViewCell.self, forCellReuseIdentifier: PersonTableViewCell.identifier)
        tableView.backgroundColor = .systemGreen
        tableView.rowHeight = 100
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 80, height: 40)
        layout.scrollDirection = .horizontal
        return layout
    }
    
}

