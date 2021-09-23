
import UIKit

class ForecastTableViewCell: UITableViewCell {
    var iconImageView = UIImageView()
    var timeLabel = ProjectStyleLabel(text: "13:00%")
    var descriptionLabel = ProjectStyleLabel(text:"light intensity drizzle", textColor: UIColor.ProjectColors.descriptionText)
    var tempretureLabel = ProjectStyleLabel(text: "28\u{00B0}C", fontSize: 48)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setUpViews()
    }
    
    
    func configureWith(icon: UIImage?, time: String?, description: String?, temp: String?) {
        setUpViews()
        iconImageView.image = icon
        timeLabel.text = time
        descriptionLabel.text = description
        tempretureLabel.text = temp
    }
    
    func configure(icon: UIImage?, forecast: List?) {
        setUpViews()
        iconImageView.image = icon
        timeLabel.text = forecast?.dtTxt
        descriptionLabel.text = forecast?.weather.first.debugDescription
        if let forecast = forecast {
        tempretureLabel.text = String(forecast.main.temp)
        }
    }
    
    func configureWithTuple(tuple:(String, UIImage, String, String, String)) {
        setUpViews()
        iconImageView.image = tuple.1
        timeLabel.text = tuple.2
        descriptionLabel.text = tuple.3
        tempretureLabel.text = tuple.4
    }
    
    
    fileprivate func setUpViews() {
        let middleStackView = setVerticalStackView(views: [timeLabel, descriptionLabel], spacing: 5)

        contentView.addSubview(middleStackView)
        middleStackView.translatesAutoresizingMaskIntoConstraints = false
        middleStackView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        middleStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        middleStackView.trailingAnchor.constraint(equalTo: tempretureLabel.leadingAnchor).isActive = true
        middleStackView.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor).isActive = true
        
        iconImageView.image = UIImage(named: "mockWeatherIcon")
        iconImageView.contentMode = .scaleAspectFill
        contentView.addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        iconImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        contentView.addSubview(tempretureLabel)
        tempretureLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        tempretureLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        tempretureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        tempretureLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    

}
