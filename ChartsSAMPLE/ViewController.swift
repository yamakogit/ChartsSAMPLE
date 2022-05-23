//
//  ViewController.swift
//  ChartsSAMPLE
//
//  Created by 山田航輝 on 2022/05/22.
//

import UIKit
import Charts

class ViewController: UIViewController {
    
    
    @IBOutlet weak var chartView: LineChartView!
    var chartDataSet: LineChartDataSet!
        // 今回使用するサンプルデータ
        let sampleData = [23.0, 8.8, 11.5, 18.7, 21.3, 0.0, 19.2]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view.
            // グラフを表示する
            displayChart(data: sampleData)
        }
    
    
    
        
        func displayChart(data: [Double]) {
            
            // プロットデータ(y軸)を保持する配列
            var dataEntries = [ChartDataEntry]()
            
            for (xValue, yValue) in data.enumerated() {
                let dataEntry = ChartDataEntry(x: Double(xValue), y: yValue)
                dataEntries.append(dataEntry)
            }
            // グラフにデータを適用
            chartDataSet = LineChartDataSet(entries: dataEntries, label: "5/17の週")
            
            chartDataSet.lineWidth = 5.0 // グラフの線の太さを変更
            
            chartDataSet.mode = .linear // 直線グラフにする
//            chartDataSet.mode = .horizontalBezier // くねくねグラフにする
//            chartDataSet.mode = .stepped // タクシーメーターのようなグラフにする
//            chartDataSet.mode = .cubicBezier // 滑らかなグラフの曲線にする
            
            chartView.data = LineChartData(dataSet: chartDataSet)
            
            chartDataSet.colors = [UIColor.purple]
            chartDataSet.drawCirclesEnabled = false
            chartDataSet.drawValuesEnabled = true
            
            // X軸(xAxis)
            chartView.xAxis.labelPosition = .bottom // x軸ラベルをグラフの下に表示する
            
            let formatter = ChartFormatter()
                    chartView.xAxis.valueFormatter = formatter
            //labelCountはChartDataEntryと同じ数だけ入れます。
                    chartView.xAxis.labelCount = 7
                    //granularityは1.0で固定
                    chartView.xAxis.granularity = 1.0
            
            // Y軸(leftAxis/rightAxis)
            chartView.leftAxis.axisMaximum = 25 //y左軸最大値
            chartView.leftAxis.axisMinimum = 0 //y左軸最小値
            chartView.leftAxis.labelCount = 5 // y軸ラベルの数
            chartView.rightAxis.enabled = false // 右側の縦軸ラベルを非表示
            
            // その他の変更
            chartView.highlightPerTapEnabled = true // プロットをタップして選択可
            chartView.legend.enabled = true // グラフ名（凡例）を表示
            chartView.pinchZoomEnabled = false // ピンチズーム不可
            chartView.doubleTapToZoomEnabled = true // ダブルタップズーム可
            chartView.extraTopOffset = 20 // 上から20pxオフセットすることで上の方にある値(99.0)を表示する
            
            
            chartView.xAxis.labelTextColor = UIColor.black
            chartView.xAxis.axisLineColor = UIColor.white
            
            chartView.animate(xAxisDuration: 2) // 2秒かけて左から右にグラフをアニメーションで表示する
            
            view.addSubview(chartView)
        }
    
    
    
    
    
    
    


}


class ChartFormatter: NSObject, IAxisValueFormatter {
        let xAxisValues = ["日", "月", "火", "水", "木", "金", "土"]

        func stringForValue(_ value: Double, axis: AxisBase?) -> String {
            //granularityを１.０、labelCountを１２にしているおかげで引数のvalueは1.0, 2.0, 3.0・・・１１.０となります。
            let index = Int(value)
            return xAxisValues[index]
        }

    }

