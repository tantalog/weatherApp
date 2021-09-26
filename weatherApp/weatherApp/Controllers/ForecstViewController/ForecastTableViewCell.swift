
import UIKit

class ForecastTableViewCell: UITableViewCell {
    var iconImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.image = UIImage(named: "mockWeatherIcon")
        imageView.contentMode = .scaleAspectFit
    return imageView
}()
    var timeLabel = ProjectStyleLabel(text: "13:00")
    var descriptionLabel = ProjectStyleLabel(text:"light intensity drizzle", textColor: UIColor.ProjectColors.descriptionText)
    var tempretureLabel = ProjectStyleLabel(text: "28\u{00B0}C", fontSize: 48)
    lazy var middleStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [timeLabel, descriptionLabel])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
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
    
    func configureCellWith(icon: UIImage, timestamp: String, description: String, temp: String) {
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
