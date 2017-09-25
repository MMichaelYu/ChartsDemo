//
//  ViewController.swift
//  ChartTest
//
//  Created by Michael Yu on 7/19/17.
//  Copyright © 2017 Michael Yu. All rights reserved.
//

import UIKit
import Charts
import RealmSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateChartWithData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //Properties
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var pieView: PieChartView!
    @IBOutlet weak var tfName: UITextField!
    
    //Button Tap
    @IBAction func btnAddTapped(_ sender: UIButton) {
        if let value = tfValue.text , value != "", let coinName = tfName.text, coinName != "" {
            let coin = Coin()
            coin.count = (NumberFormatter().number(from: value)?.intValue)!
            coin.name = coinName
            coin.save()
            tfValue.text = ""
            tfName.text = ""
        }
        updateChartWithData()
        view.endEditing(true)
    }
    
    //Update Chart
    func updateChartWithData() {
        var dataEntries: [PieChartDataEntry] = []
        let coins = getCoinsFromDatabase()
        for i in 0..<coins.count {
            let dataEntry = PieChartDataEntry(value: Double(coins[i].count), label: coins[i].name)
            //let dataEntry = PieChartDataEntry(x: Double(i), y: Double(coins[i].count))
            dataEntries.append(dataEntry)
        }
        let chartDataSet = PieChartDataSet(values: dataEntries, label: "My coins")
        let chartData = PieChartData(dataSet: chartDataSet)
        pieView.data = chartData
        
        var colors: [UIColor] = []
        
        for _
            in 0..<coins.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        
        chartDataSet.colors = colors
    }
    
    //Get From Database
    func getCoinsFromDatabase() -> Results<Coin>
    {
        do {
            let realm = try Realm()
            return realm.objects(Coin.self)
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
}

