//
//  CurrentWeatherView.swift
//  PrettyWeather
//
//  Created by Ken Wong on 4/24/16.
//  Copyright © 2016 Ken Wong. All rights reserved.
//

import UIKit
import Cartography

class WeatherHourlyForecastView: UIView {
    private var didSetupConstraints = false
    private let scrollView = UIScrollView()
    private var forecastCells = Array<WeatherHourForecastView>()
    
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
private extension WeatherHourlyForecastView{
    func setup(){
        (0..<7).forEach{ _ in
            let cell = WeatherHourForecastView(frame: CGRectZero)
            forecastCells.append(cell)
            scrollView.addSubview(cell)
        }
        scrollView.showsHorizontalScrollIndicator = false
        addSubview(scrollView)
    }
}
// MARK: - Layout
private extension WeatherHourlyForecastView{
    func layoutView(){
        constrain(self) {
            $0.height == 100
        }
        constrain(scrollView){
            $0.edges == $0.superview!.edges
        }
        constrain(forecastCells.first!){
            $0.left == $0.superview!.left
        }
        constrain(forecastCells.last!){
            $0.right == $0.superview!.right
        }
        for idx in 0..<(forecastCells.count - 1){
            let cell = forecastCells[idx]
            let nextCell = forecastCells[idx+1]
            constrain(cell, nextCell){
                $0.right == $1.left + 5
            }
        }
        forecastCells.forEach{ cell in
            constrain(cell){
                $0.width == $0.height
                $0.height == $0.superview!.height
                $0.top == $0.superview!.top
            }
        }
    }
}
// MARK: - Style
private extension WeatherHourlyForecastView{
    func style(){
    }
}

// MARK: - Render
extension WeatherHourlyForecastView{
    func render(){
        forecastCells.forEach {
            $0.render()
        }
    }
}