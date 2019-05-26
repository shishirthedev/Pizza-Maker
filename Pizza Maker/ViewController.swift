//
//  ViewController.swift
//  Pizza Maker
//
//  Created by Developer Shishir on 5/25/19.
//  Copyright © 2019 Shishir's App Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pizzaSizeT:UITextField!
    @IBOutlet weak var pizzaTypeT: UITextField!
    @IBOutlet weak var cheeseTypeT: UITextField!
    @IBOutlet weak var sauceT: UITextField!
    @IBOutlet weak var toppingsL: UILabel!
    
    @IBOutlet weak var totalPriceL: UILabel!
    @IBOutlet weak var toppingsTableView: UITableView!
    
    // DATA FOR EACH TYPE..........
    let DATA_PIZZA_TYPE: [String] = [ "Thin Crust", "Pan", "Chicago" ]
    let DATA_PIZA_SIZE: [String] = ["Regular", "Medium", "Large" ]
    let DATA_CHEESE: [String] = ["White", "Brown"]
    let DATA_SAUCE: [String] = ["Tomato", "BBQ", "Marinara"]
    let DATA_TOPPINGS: [String] = [ "Onion", "Pepperoni", "Green Pepper"]
    
    // PRICE FOR EACH ITEM........
    let PRICE_PIZZA_TYPE = ["Thin Crust": 50, "Pan": 40, "Chicago": 60]
    let PRICE_PIZZA_SIZE = ["Regular": 40, "Medium": 60, "Large" : 70]
    let PRICE_CHEESE = ["White": 10 , "Brown": 20]
    let PRICE_SAUCE = ["Tomato": 20, "BBQ": 15, "Marinara": 30 ]
    let PRICE_TOPPINGS = ["Onion": 5, "Pepperoni": 30, "Green Pepper": 20]
    
    //  DATA PICKERVIEW.................
    fileprivate let pizzaSizePickerView: SSPickerView = SSPickerView()
    fileprivate let pizzaTypePickerView: SSPickerView = SSPickerView()
    fileprivate let cheeseTypePickerView: SSPickerView = SSPickerView()
    fileprivate let sauceTypePickerView: SSPickerView = SSPickerView()
    
    
    let defaultToppings : String = "Onion\nPepperoni\nGreen Pepper" // DAFAULT TOPPINGS..............
    var selectedToppings:[Int] = [0, 1, 2] // Here 0, 1, 2 is the inedex for toppings in DATA_TOPPINGS array
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting all pickerView ........
        setUpPickerView()
        configToppingTableView()
        
        // Adding tap gesture for selecting toppings..................
        let toppingTapGesture = UITapGestureRecognizer(target: self, action: #selector(toppingsLDidTapped))
        toppingsL.addGestureRecognizer(toppingTapGesture)
        
        toppingsL.text = defaultToppings // Showing the default topping items.....
        calculatePrice() // Initially calculating the total price for the default items...
    }
    
    func setUpPickerView(){
        
        pizzaTypePickerView.delegate = self
        pizzaTypePickerView.dataSource = self
        pizzaTypePickerView.toolbarDelegate = self
        
        pizzaSizePickerView.delegate = self
        pizzaSizePickerView.dataSource = self
        pizzaSizePickerView.toolbarDelegate = self
        
        cheeseTypePickerView.delegate = self
        cheeseTypePickerView.dataSource = self
        cheeseTypePickerView.toolbarDelegate = self
        
        sauceTypePickerView.delegate = self
        sauceTypePickerView.dataSource = self
        sauceTypePickerView.toolbarDelegate = self
        
        pizzaSizeT.inputView = self.pizzaSizePickerView
        pizzaSizeT.inputAccessoryView = self.pizzaSizePickerView.toolbar
        
        pizzaTypeT.inputView = self.pizzaTypePickerView
        pizzaTypeT.inputAccessoryView = self.pizzaTypePickerView.toolbar
        
        cheeseTypeT.inputView = self.cheeseTypePickerView
        cheeseTypeT.inputAccessoryView = self.cheeseTypePickerView.toolbar
        
        sauceT.inputView = self.sauceTypePickerView
        sauceT.inputAccessoryView = self.sauceTypePickerView.toolbar
    }
    
    @objc func toppingsLDidTapped(){
        toppingsTableView.isHidden = !toppingsTableView.isHidden
    }
    
    func calculatePrice(){
        let priceForPizzaType = PRICE_PIZZA_TYPE[pizzaTypeT.text!]
        let priceForPizzaSize = PRICE_PIZZA_SIZE[pizzaSizeT.text!]
        let priceForCheese = PRICE_CHEESE[cheeseTypeT.text!]
        let priceFourSauce = PRICE_SAUCE[sauceT.text!]
        
        var priceForToppings = 0
        for item in selectedToppings {
            priceForToppings += PRICE_TOPPINGS[DATA_TOPPINGS[item]]!
        }
        
        let totalPrice = priceForPizzaType! + priceForPizzaSize! + priceForCheese! + priceFourSauce! + priceForToppings
        totalPriceL.text = "TOTAL: \(totalPrice)"
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if !toppingsTableView.isHidden{
            toppingsTableView.isHidden = true // Just closing the toppings picker view if it is not hidden...
        }
        
        if pickerView == pizzaSizePickerView {
            return DATA_PIZA_SIZE.count
        }else if pickerView == pizzaTypePickerView {
            return DATA_PIZZA_TYPE.count
        }else if pickerView == cheeseTypePickerView {
            return DATA_CHEESE.count
        }else if pickerView == sauceTypePickerView {
            return DATA_SAUCE.count
        }
        return 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == pizzaSizePickerView {
            return DATA_PIZA_SIZE[row]
        }else if pickerView == pizzaTypePickerView {
            return DATA_PIZZA_TYPE[row]
        }else if pickerView == cheeseTypePickerView {
            return DATA_CHEESE[row]
        }else if pickerView == sauceTypePickerView {
            return DATA_SAUCE[row]
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == pizzaSizePickerView {
            pizzaSizeT.text = DATA_PIZA_SIZE[row]
        }else if pickerView == pizzaTypePickerView {
            pizzaTypeT.text = DATA_PIZZA_TYPE[row]
        }else if pickerView == cheeseTypePickerView {
            cheeseTypeT.text = DATA_CHEESE[row]
        }else if pickerView == sauceTypePickerView {
            sauceT.text = DATA_SAUCE[row]
        }
        calculatePrice() // Calculating price on each item change..........
    }
}


extension ViewController: SSPickerViewDelegate {
    func didTapDone() {
        if(pizzaTypeT.isFirstResponder){
            pizzaTypeT.resignFirstResponder()
        }else if (pizzaSizeT.isFirstResponder){
            pizzaSizeT.resignFirstResponder()
        }else if (cheeseTypeT.isFirstResponder){
            cheeseTypeT.resignFirstResponder()
        }else if (sauceT.isFirstResponder){
            sauceT.resignFirstResponder()
        }
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func configToppingTableView(){
        toppingsTableView.delegate = self
        toppingsTableView.dataSource = self
        toppingsTableView.tableFooterView = UIView(frame: CGRect.zero)
        toppingsTableView.isHidden = true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DATA_TOPPINGS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = DATA_TOPPINGS[indexPath.row]
        if (selectedToppings.contains(indexPath.row)){ // Giving checkMark if the item already selected
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
            selectedToppings.remove(at: selectedToppings.index(of: indexPath.row)!)
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
            selectedToppings.append(indexPath.row)
        }
        
        var toppingsItem = ""
        for i in selectedToppings{
            toppingsItem += DATA_TOPPINGS[i] + "\n"
        }
        toppingsL.text = toppingsItem
        calculatePrice() // Calculating Price on each Topping change..
    }
}
