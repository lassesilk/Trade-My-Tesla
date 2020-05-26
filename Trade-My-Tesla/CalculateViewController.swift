//
//  CalculateViewController.swift
//  Trade-My-Tesla
//
//  Created by Lasse Silkoset on 26/05/2020.
//  Copyright © 2020 Lasse Silkoset. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    let tradeForLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Trade your Tesla for: "
        label.textColor = .white
        return label
    }()
    
    let modelLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Model"
           label.textColor = .white
           return label
       }()
    
    let upgradesLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Premium upgrades"
           label.textColor = .white
           return label
       }()
    
    let mileageLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Mileage"
           label.textColor = .white
           return label
       }()
    
    let conditionLabel: UILabel = {
           let label = UILabel()
           label.textAlignment = .center
           label.text = "Condition"
           label.textColor = .white
           return label
       }()
    
    let tradeForPriceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 42)
        return label
    }()
    
    let cars = Cars()
    
    lazy var segmentedControl: UISegmentedControl = {
        let segControl = UISegmentedControl()
        segControl.insertSegment(withTitle: "Model 3", at: 0, animated: false)
        segControl.insertSegment(withTitle: "Model S", at: 1, animated: false)
        segControl.insertSegment(withTitle: "Model X", at: 2, animated: false)
        segControl.selectedSegmentIndex = 2
        segControl.addTarget(self, action: #selector(handleSegmentModelChanged), for: .valueChanged)
        return segControl
    }()
    
    lazy var segmentedUpgradeControl: UISegmentedControl = {
        let segControl = UISegmentedControl()
        segControl.insertSegment(withTitle: "Not Installed", at: 0, animated: false)
        segControl.insertSegment(withTitle: "Installed", at: 1, animated: false)
        segControl.selectedSegmentIndex = 0
        segControl.addTarget(self, action: #selector(handleSegmentModelChanged), for: .valueChanged)
        return segControl
    }()
    
    lazy var mileageSlider: UISlider = {
        let slider = UISlider()
        slider.value = 10000
        slider.maximumValue = 150000
        slider.minimumValue = 5000
        slider.addTarget(self, action: #selector(handleSegmentModelChanged), for: .valueChanged)
        return slider
    }()
    
    lazy var segmentedConditionControl: UISegmentedControl = {
        let segControl = UISegmentedControl()
        segControl.insertSegment(withTitle: "Poor", at: 0, animated: false)
        segControl.insertSegment(withTitle: "Ok", at: 1, animated: false)
        segControl.insertSegment(withTitle: "Good", at: 2, animated: false)
        segControl.insertSegment(withTitle: "Excellent", at: 3, animated: false)
        segControl.selectedSegmentIndex = 2
        segControl.addTarget(self, action: #selector(handleSegmentModelChanged), for: .valueChanged)
        return segControl
    }()
    
    lazy var continueBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Proceed", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        btn.setTitleColor(.white, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .themeColorRed()
        
        let stack = UIStackView(arrangedSubviews: [modelLabel, segmentedControl, upgradesLabel, segmentedUpgradeControl, mileageLabel, mileageSlider, conditionLabel, segmentedConditionControl, tradeForLabel, tradeForPriceLabel])
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        
        view.addSubview(stack)
        stack.fillSuperview(padding: .init(top: 24, left: 16, bottom: 82, right: 16))
        
        handleSegmentModelChanged()
        
    }
    
    @objc fileprivate func handleSegmentModelChanged() {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let formattedMileage = formatter.string(for: mileageSlider.value) ?? "0"
        mileageLabel.text = "Mileage \(formattedMileage) miles"
        
        
        if let prediciton = try? cars.prediction(model: Double(segmentedControl.selectedSegmentIndex), premium: Double(segmentedUpgradeControl.selectedSegmentIndex), milage: Double(mileageSlider.value), condition: Double(segmentedConditionControl.selectedSegmentIndex)) {
            
            let clampedValuation = max(2000, prediciton.price)
            
            formatter.numberStyle = .currency
            formatter.currencySymbol = "$"
            
            tradeForPriceLabel.text = formatter.string(for: clampedValuation)
        } else {
            
            tradeForPriceLabel.text = "Error"
        }
        
        
    }
}
