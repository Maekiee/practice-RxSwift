import UIKit
import SnapKit

class PracticeRxTableViewCell: UITableViewCell {
    static let identifier = "PracticeRxTableViewCell"
    
    let appNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    let testButton: UIButton = {
        let button = UIButton()
        button.setTitle("", for: .normal)
        button.tintColor = UIColor.green
        button.backgroundColor = .blue
        return button
    }()
     
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        configHeiracy()
        configLayout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
     
    
    private func configHeiracy() {
        contentView.addSubview(appNameLabel)
        contentView.addSubview(testButton)
    }
    
    private func configLayout() {
        appNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(16)
        }
        
        testButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(appNameLabel.snp.trailing).offset(20)
        }
        
    }
    
    private func configure() {
        self.selectionStyle = .none
        self.accessoryType = .detailButton
    }

}
