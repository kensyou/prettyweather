//
//  PrettyWeatherViewController.swift
//  PrettyWeather
//
//  Created by Ken Wong on 4/24/16.
//  Copyright © 2016 Ken Wong. All rights reserved.
//

import UIKit
import Cartography
import FXBlurView

class PrettyWeatherViewController: UIViewController {

    private let backgroundView = UIImageView()
    private let overlayView = UIImageView()
    private let gradientView = UIView()
    private let scrollView = UIScrollView()
    
    private let currentWeatherView = CurrentWeatherView(frame: CGRectZero)
    private let hourlyForecastView = WeatherHourlyForecastView(frame: CGRectZero)
    private let daysForecastView = WeatherDaysForecastView(frame: CGRectZero)
    static var INSET: CGFloat {get { return 20}}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layoutView()
        style()
        render(UIImage(named: "DefaultImage"))
        renderSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: - Setup
private extension PrettyWeatherViewController{
    func setup(){
        backgroundView.contentMode = .ScaleAspectFill
        backgroundView.clipsToBounds = true
        view.addSubview(backgroundView)
        overlayView.contentMode = .ScaleAspectFill
        overlayView.clipsToBounds = true
        view.addSubview(overlayView)
        view.addSubview(gradientView)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.addSubview(currentWeatherView)
        scrollView.addSubview(hourlyForecastView)
        scrollView.addSubview(daysForecastView)
        scrollView.delegate = self
        view.addSubview(scrollView)
        
    }
}
// MARK: - Layout
private extension PrettyWeatherViewController{
    func layoutView(){
        constrain(backgroundView){ view in
            // view.top == view.superview!.top
            // view.bottom == view.superview!.bottom
            // view.left == view.superview!.left
            // view.right == view.superview!.right
            view.edges == view.superview!.edges
        }
        constrain(overlayView){
            $0.edges == $0.superview!.edges
        }
        constrain(gradientView){
            $0.edges == $0.superview!.edges
        }
        constrain(scrollView){view in
            view.edges == view.superview!.edges
        }
        
        let currentWeatherInsect: CGFloat =
          view.frame.height -
          CurrentWeatherView.HEIGHT -
          PrettyWeatherViewController.INSET
        constrain(currentWeatherView){ view in
            view.width == view.superview!.width
            view.centerX == view.superview!.centerX
            view.top == view.superview!.top + currentWeatherInsect
        }
        constrain(hourlyForecastView, currentWeatherView){
            $0.top == $1.bottom + PrettyWeatherViewController.INSET
            $0.width == $0.superview!.width
            $0.centerX == $0.superview!.centerX
        }
        constrain(daysForecastView, hourlyForecastView){
            $0.top == $1.bottom
            $0.width == $1.width
            $0.bottom == $0.superview!.bottom - PrettyWeatherViewController.INSET
            $0.centerX == $0.superview!.centerX
        }
    }
}
// MARK: - Render
private extension PrettyWeatherViewController{
    func render(image: UIImage?){
        guard let image = image else { return }
        backgroundView.image = image
        overlayView.image = image.blurredImageWithRadius(10, iterations: 20, tintColor: UIColor.clearColor())
        overlayView.alpha = 0
    
    }
    func renderSubviews(){
        currentWeatherView.render()
        hourlyForecastView.render()
        daysForecastView.render()
    }
    
}
// MARK: - Style
private extension PrettyWeatherViewController{
    func style(){
        gradientView.backgroundColor = UIColor(white:0, alpha: 0.7)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = gradientView.bounds
        
        let blackColor = UIColor(white: 0, alpha: 0.0)
        let clearColor = UIColor(white: 0, alpha: 1.0)
        
        gradientLayer.colors = [blackColor.CGColor, clearColor.CGColor]
        gradientLayer.startPoint = CGPointMake(1.0, 0.5)
        gradientLayer.endPoint = CGPointMake(1.0, 1.0)
        gradientView.layer.mask = gradientLayer
    }
}
// MARK: - UIScrollViewDelegate
extension PrettyWeatherViewController: UIScrollViewDelegate{
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        let threshold:CGFloat = CGFloat(view.frame.height)/2
        overlayView.alpha = min(1.0, offset/threshold)
    }
}