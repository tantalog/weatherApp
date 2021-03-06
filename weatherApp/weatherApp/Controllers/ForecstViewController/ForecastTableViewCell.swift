
import UIKit

class ForecastTableViewCell: UITableViewCell {
    var iconImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.image = UIImage()
        imageView.contentMode = .scaleAspectFit
    return imageView
}()
    var timeLabel = ProjectStyleLabel()
    var descriptionLabel = ProjectStyleLabel(textColor: UIColor.ProjectColors.descriptionText)
    var tempretureLabel = ProjectStyleLabel(fontSize: 48)
    
    lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        return stackView
    }()
    
    lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [iconImageView, middleStackView, tempretureLabel])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.ProjectColors.background
        setUpViews()
    }
    
    func configureCellWith(icon: UIImage?, timestamp: String, description: String, temp: String) {
        iconImageView.image = icon
        timeLabel.text = timestamp
        descriptionLabel.text = description
        tempretureLabel.text = temp
    }
    
    fileprivate func setUpViews() {
        contentView.addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        horizontalStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        horizontalStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        horizontalStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        horizontalStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  

}
