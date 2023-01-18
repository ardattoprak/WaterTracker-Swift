//
//  ViewController.swift
//  Water Tracker
//
//  Created by Arda Toprak on 14.01.2023.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - UI Elements
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
   
    @IBOutlet weak var addWaterConstraint: NSLayoutConstraint!
    
    
    
    // MARK: - Properties
    
    let waterStore = DataStore()
    let targetAmount = 2700.0
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        sifirla()
        updateAppereance()
    }
    // MARK: - Functions
    
    func sifirla(){
        waterStore.defaults.set(0, forKey: "currentAmount")
    }
    
    func updateWaterLevel(amount: Double){
        let screenHeight = Double(view.frame.size.height)
        let ratio = amount / targetAmount
        let calculatedHeight = screenHeight * ratio
        
        addWaterConstraint.constant = CGFloat(calculatedHeight)
        
        UIViewPropertyAnimator.init(duration: 0.5, dampingRatio: 0.75) { self.view.layoutIfNeeded() }.startAnimation()
    }
    
    func updateLabels(amount: Double) {
        let amountToTarget = ((targetAmount - amount) / 1000 )
        
        if amount < targetAmount {
            let subtitleText = String(format: "Bugünkü ihtiyacını karşılamak için \n%g litre daha su içmelisin ", amountToTarget)
            if amount == 0 {
                titleLabel.text = "Merhaba! \nBugün su içtin mi?"
            } else {
                titleLabel.text = "Tebrikler! \nDoğru yoldasın."
            }
        } else {
            titleLabel.text = "Muhteşem! \nKendine iyi baktın"
            subtitleLabel.text = "Bugün vücudun için gereken su miktarının tamamını karşıladın"
        }
    }
    
    func updateAppereance() {
        let currentWaterAmount = waterStore.getCurrentAmount()
        
        updateLabels(amount: currentWaterAmount)
        updateWaterLevel(amount: currentWaterAmount)
    }
    
    
        
        
        // MARK: - Actions
    @IBAction func addWaterButtonTapped(_ sender: Any) {
        var waterAmount = 0.0
        
        switch (sender as AnyObject).tag {
        case 0:
            waterAmount = 200
        case 1:
            waterAmount = 500
        case 2:
            waterAmount = 700
        default:
            break
        }
        waterStore.addWater(amount: waterAmount)
        updateAppereance()
    }
}
    

