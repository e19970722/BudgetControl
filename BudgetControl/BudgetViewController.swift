//
//  BudgetViewController.swift
//  BudgetControl
//
//  Created by Yen Lin on 2023/3/27.
//

import UIKit

class BudgetViewController: UIViewController {

    var expenseRecord: Double = 0
    var index: Int = 0
    var recordDetail: String = ""

    @IBOutlet weak var budgetSlider: UISlider!
    @IBOutlet weak var expenseTextField: UITextField!
    @IBOutlet weak var budgetTextLabel: UILabel!
    @IBOutlet weak var expensePercentLabel: UILabel!
    
    @IBOutlet weak var cumulateExpenseLabel: UILabel!
    @IBOutlet weak var recordNameText: UITextField!
    @IBOutlet weak var showRecordLabel: UILabel!
    
    @IBOutlet weak var reminderLabel: UILabel!
    
    //第一個主畫面
    override func viewDidLoad() {
        super.viewDidLoad()
        reminderLabel.isHidden = true
    }
    
    //設定預算
    @IBAction func updateBudget(_ sender: UISlider) {
        var intervals = 1000
        var budget = Int(sender.value / Float(intervals)) * intervals
        sender.value = Float(budget)
        budgetTextLabel.text = String(budget)
        }
    
    //新增消費
    @IBAction func addExpense(_ sender: Any) {
        
        reminderLabel.isHidden = true
        
        if let bugetTextLabel = budgetTextLabel.text,
           var budget = Double(bugetTextLabel){
            
            //必須要有設定預算大於0
            if budget > 0.0{
                if let expenseText = expenseTextField.text,
                   let expense = Double(expenseText),
                   let recordText = recordNameText.text{
                    
                    //累計花費金額
                    expenseRecord += expense
                    cumulateExpenseLabel.text = String(expenseRecord)
                    
                    //計算預算使用百分比
                    let budgetPercent = (expenseRecord/budget) * 100
                    expensePercentLabel.text = "\(String(format: "%.2f", (budgetPercent))) %"
                    
                    //累計花費數量
                    index+=1
                    
                    //累計消費紀錄
                    recordDetail += "\(index). \(recordText) $ \(expense)\n"
                    showRecordLabel.text = recordDetail

                    //提示消費，當超過預算80%
                    if budgetPercent >= 80{
                        reminderLabel.text = "糟糕，花太兇囉！"
                        reminderLabel.isHidden = false
                    }
                }
            }else{
                reminderLabel.text = "您的預算必須大於0"
                reminderLabel.isHidden = false
            }
        }
    }
    
    //收鍵盤
    @IBAction func buttonPressed(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    
    //清除所有消費紀錄
    @IBAction func deleteRecords(_ sender: Any) {
        expenseRecord = 0
        expensePercentLabel.text = "0.0 %"
        cumulateExpenseLabel.text = "0"
        index = 0
        recordDetail = ""
        showRecordLabel.text = "尚無消費紀錄"
        reminderLabel.isHidden = true
    }

    
}
