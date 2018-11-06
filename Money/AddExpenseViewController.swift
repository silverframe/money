//
//  AddExpenseViewController.swift
//  Money
//
//  Created by Stefanie Seah on 6/11/18.
//  Copyright © 2018 Stefanie Seah. All rights reserved.
//

import UIKit

class AddExpenseViewController: UIViewController {

    @IBOutlet weak var expenseAmountTextField: UITextField!
    @IBAction func addButtonTapped(_ sender: Any) {
        expenseSharedInstance.expensesAsString.append(expenseAmountTextField.text!)
        expenseSharedInstance.expensesAsInt.append(amountAsInt)
        self.navigationController?.popViewController(animated: true)
    }
    
    fileprivate var amountAsString = "" {
        didSet {
            formatCurrency()
        }
    }
    
    private var amountAsInt: Int {
        return Int(amountAsString) ?? 0
    }
    
    lazy var addExpenseViewModel: AddExpenseViewModel = {
        return AddExpenseViewModel()
    }()
    
    lazy var expenseSharedInstance: ExpenseSharedInstance = {
        return ExpenseSharedInstance.shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expenseAmountTextField.delegate = self
        expenseAmountTextField.keyboardType = .numberPad
        expenseAmountTextField.becomeFirstResponder()
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Dusk")
    }
}

extension AddExpenseViewController {
    
    private func formatCurrency() {
        expenseAmountTextField.text = format(cents: amountAsInt)
    }
    
    private func removeCurrencySymbols(amount: String) -> String {
        return amount.replacingOccurrences(of: "$", with: "").replacingOccurrences(of: ".", with: "").replacingOccurrences(of: ",", with: "")
    }
    
    private func getCurrencyFormatter(groupingSeparator: String? = nil,
                                     decimalSeparator: String? = nil) -> NumberFormatter {
        let numberFormatter = NumberFormatter.init()
        numberFormatter.positivePrefix = "$"
        numberFormatter.negativePrefix = "-$"
        numberFormatter.groupingSeparator = groupingSeparator
        numberFormatter.decimalSeparator = decimalSeparator
        numberFormatter.currencySymbol = ""
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = Locale.init(identifier: "en_SG")
        
        return numberFormatter
    }
    
    private func format(cents: Int) -> String? {
        let formatter = getCurrencyFormatter()
        let dollarsAndCents = Decimal.init(cents) * Decimal.init(string: "0.01")!
        return formatter.string(for: dollarsAndCents)
    }
}

extension AddExpenseViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        let prospectiveText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if (["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"].contains(string) &&
            amountAsString.count < 8) || (string.count == 0) {
            amountAsString = removeCurrencySymbols(amount: prospectiveText)
            return false
        }
        return false
    }
}
