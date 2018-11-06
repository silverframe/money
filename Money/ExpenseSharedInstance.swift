//
//  ExpenseSharedInstance.swift
//  Money
//
//  Created by Stefanie Seah on 6/11/18.
//  Copyright © 2018 Stefanie Seah. All rights reserved.
//

import Foundation

class ExpenseSharedInstance {
    
    static let shared: ExpenseSharedInstance = {
        return ExpenseSharedInstance()
    }()
    
    var expensesAsString: [String] = [String]()
    
    var expensesAsInt: [Int] = [Int]()
    
    func retrieveTotalExpenses() -> String {
        let totalExpensesAsInt = expensesAsInt.reduce(0, +)
        return format(cents: totalExpensesAsInt) ?? "$0.00"
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
