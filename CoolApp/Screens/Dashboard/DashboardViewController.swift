//
//  DashboardViewController.swift
//  CoolApp
//
//  Created by Nichita Zloteanu on 22/07/2019.
//  Copyright © 2019 Nichita Zloteanu. All rights reserved.
//

import UIKit
import Charts

class DashboardViewController: UIViewController {

    @IBOutlet weak var horizontalBarChartView: HorizontalBarChartView!
    @IBOutlet weak var barChartView: BarChartView!
    
    @IBOutlet weak var firstPieChart: PieChartView!
    @IBOutlet weak var secondPieChart: PieChartView!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.beautify()

        setupFirstPieChart()
        setupSecondPieChart()
        setupLineChart()
        setupHBarChart()
        setupBarChart()
    }
}

extension DashboardViewController {
    
    func setupFirstPieChart() {
        let dollars1 = [17,30.0, 20, 26]
        let values = ["8:30 - 11:45", "11:45 - 14:00", "14:00 - 18:00", "18:00 - 21:00"]
        
        let data = PieChartData()
        
        var yValues : [PieChartDataEntry] = [PieChartDataEntry]()
        
        var i = 0;
        for each in dollars1 {
            yValues.append(PieChartDataEntry(value: each, label: values[i]))
            i+=1;
        }
        
        let ds = PieChartDataSet(entries: yValues, label: "Customers per hour")
        
        
        ds.colors = ChartColorTemplates.material()
        
        data.addDataSet(ds)
        data.setValueFormatter(DefaultValueFormatter(decimals: 0))
        
        firstPieChart.data = data
        
        firstPieChart.backgroundColor = .white
    }
    
    func setupSecondPieChart() {
        let dollars1 = [10, 50, 34, 26, 60]
        let values = ["1 item", "2 items", "3 items", "4 items", "5+ items"]
        
        let data = PieChartData()
        
        var yValues : [PieChartDataEntry] = [PieChartDataEntry]()
        
        var i = 0;
        for each in dollars1 {
            yValues.append(PieChartDataEntry(value: Double(each), label: values[i]))
            i+=1;
        }
        
        let ds = PieChartDataSet(entries: yValues, label: "# of items ordered")
        
        
        ds.colors = ChartColorTemplates.pastel()
        
        data.addDataSet(ds)
        data.setValueFormatter(DefaultValueFormatter(decimals: 0))
        
        secondPieChart.data = data
        
        secondPieChart.backgroundColor = .white
    }
    
    func setupLineChart() {
        let dollars1 = [(0.0, 0.0), (2.0, 5.0), (4.0, 4.0), (6.0,9.0)]
        let dollars2 = [(0.0, 1.0), (2.0, 3.0), (4.0, 6.0), (6.0,5.0)]
        
        let data = LineChartData()
        
        var sw = false
        for each in [dollars1, dollars2] {
            
            var yValues : [ChartDataEntry] = [ChartDataEntry]()
            
            for each in each {
                yValues.append(ChartDataEntry(x: each.0, y: each.1))
            }
            
            let ds = LineChartDataSet(entries: yValues, label: sw == false ? "Some stuff" : "Some other stuff")
            sw = true
            
            
            ds.colors = ChartColorTemplates.material()
            
            data.addDataSet(ds)
        }
        
        lineChartView.data = data
        
        lineChartView.doubleTapToZoomEnabled = false
        lineChartView.backgroundColor = .white
        lineChartView.drawBordersEnabled = false
    }
    
}

extension DashboardViewController {
    
    func setupHBarChart() {
        
        let unitsSold = [20, 16, 12]
        
        var dataEntryList: [BarChartDataSet] = []
        
        for padding in 1..<3 {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<3
            {
                let xValue = Double(i+1) + Double(padding * 4)
                let dataEntry = BarChartDataEntry(x: xValue, y: Double(unitsSold[i] - padding * 3), data: "Test")
                
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Customer count \(padding)")
            chartDataSet.colors = ChartColorTemplates.joyful()
            
            dataEntryList.append(chartDataSet)
        }
        
        horizontalBarChartView.data = BarChartData(dataSets: dataEntryList)
        
        horizontalBarChartView.backgroundColor = .white
        horizontalBarChartView.drawBordersEnabled = false
        
        horizontalBarChartView.xAxis.drawGridLinesEnabled = false
        horizontalBarChartView.xAxis.drawLabelsEnabled = false
        horizontalBarChartView.leftAxis.drawGridLinesEnabled = false
        
    }
    
    func setupBarChart() {
        
        let unitsSold = [20, 16, 12]
        
        var dataEntryList: [BarChartDataSet] = []
        
        for padding in 1..<3 {
            var dataEntries: [BarChartDataEntry] = []
            for i in 0..<3
            {
                let xValue = Double(i+1) + Double(padding * 4)
                let dataEntry = BarChartDataEntry(x: xValue, y: Double(unitsSold[i] - padding * 3), data: "Test")
                
                dataEntries.append(dataEntry)
            }
            
            let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Customer count \(padding)")
            chartDataSet.colors = ChartColorTemplates.joyful()
            
            dataEntryList.append(chartDataSet)
        }
        
        barChartView.data = BarChartData.init(dataSets: dataEntryList)
        
        barChartView.backgroundColor = .white
        barChartView.drawBordersEnabled = false
        
        barChartView.xAxis.drawGridLinesEnabled = false
        barChartView.xAxis.drawLabelsEnabled = false
        barChartView.leftAxis.drawGridLinesEnabled = false
        
    }
    
}
