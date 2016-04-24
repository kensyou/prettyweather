//
//  CurrentWeatherView.swift
//  PrettyWeather
//
//  Created by Ken Wong on 4/24/16.
//  Copyright © 2016 Ken Wong. All rights reserved.
//

import UIKit
import Cartography
import WeatherIconsKit

class WeatherDayForecastView: UIView {
    private var didSetupConstraints = false
    private let iconLabel = UILabel()
    private let dayLabel = UILabel()
    private let tempsLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        style()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func updateConstraints() {
        if didSetupConstraints{
            super.updateConstraints()
            return
        }
        layoutView()
        super.updateConstraints()
        didSetupConstraints = true
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
// MARK: - Setup
private extension WeatherDayForecastView{
    func setup(){
        addSubview(iconLabel)
        addSubview(dayLabel)
        addSubview(tempsLabel)
    }
}
// MARK: - Layout
private extension WeatherDayForecastView{
    func layoutView(){
        constrain(self) {
            $0.height == 50
        }
        constrain(iconLabel){
            $0.centerY == $0.superview!.centerY
            $0.left == $0.superview!.left + 20
            $0.width == $0.height
            $0.height == 50
        }
        constrain(dayLabel, iconLabel){
            $0.centerY == $1.centerY
            $0.left == $1.right + 20
        }
        constrain(tempsLabel){
            $0.centerY == $0.superview!.centerY
            $0.right == $0.superview!.right - 20
            
        }
    }
}
// MARK: - Style
private extension WeatherDayForecastView{
    func style(){
        iconLabel.textColor = .whiteColor()
        dayLabel.textColor = .whiteColor()
        tempsLabel.textColor = .whiteColor()
        dayLabel.font = UIFont.latoLightFontOfSize(20)
        tempsLabel.font = UIFont.latoLightFontOfSize(20)
    }
}
// MARK: - Render
extension WeatherDayForecastView{
    func render(){
        var dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dayLabel.text = dateFormatter.stringFromDate(NSDate())
        iconLabel.attributedText = WIKFontIcon.wiDaySunnyIconWithSize(30).attributedString()
        tempsLabel.text = "7°    11°"
    }
}