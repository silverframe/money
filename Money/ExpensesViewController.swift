//
//  ExpensesViewController.swift
//  Money
//
//  Created by Stefanie Seah on 6/11/18.
//  Copyright © 2018 Stefanie Seah. All rights reserved.
//

import UIKit

class ExpensesViewController: UIViewController {

    @IBOutlet weak var expensesTotalLabel: UILabel!
    @IBOutlet weak var expensesTableView: UITableView!
    @IBAction func addButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "AddExpenseViewController") as? AddExpenseViewController else {
            return
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var expenseSharedInstance: ExpenseSharedInstance = {
        return ExpenseSharedInstance.shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        expensesTableView.delegate = self
        expensesTableView.dataSource = self
        registerNib()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "Cherry")
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationItem.backBarButtonItem?.title = ""
        expensesTableView.reloadData()
        expensesTotalLabel.text = expenseSharedInstance.retrieveTotalExpenses()
    }
    
    func registerNib() {
        let nib = UINib(nibName: "ExpenseTableViewCell", bundle: nil)
        expensesTableView.register(nib, forCellReuseIdentifier: "ExpenseTableViewCell")
    }
}

extension ExpensesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = expensesTableView.dequeueReusableCell(withIdentifier: "ExpenseTableViewCell") as? ExpenseTableViewCell else {
            return UITableViewCell()
        }
        cell.expenseAmountLabel.text = expenseSharedInstance.expensesAsString[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expenseSharedInstance.expensesAsString.count
    }
}

extension ExpensesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
}


