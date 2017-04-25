//
//  ViewController.swift
//  CurrencyConversion
//
//  Created by Kaleb Cooper on 4/21/17.
//  Copyright © 2017 Kaleb Cooper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var toggleValue:Int = 0
    var pickingToggle:Int = 0
    var outputString:String = ""
    var parsed = false
    var currencySumbol:String = "$"
    var currencySymbolSuffix:String = ""
    var inputCurrencySymbol:String = "$"
    var inputCurrencySymbolSuffix:String = ""
    var inputValueString:String = "1"
    
    var pickerInputAlreadyOpen = false
    var pickerOutputAlreadyOpen = false
    
    var conversionRate:[Double] = []
    
    
    //MARK: Outlets
    @IBOutlet weak var pickerOutlet: UIPickerView!
    @IBOutlet weak var inputButtonOutlet: UIButton!
    @IBOutlet weak var outputButtonOutlet: UIButton!
    @IBOutlet weak var currencyTitleOutlet: UILabel!

    @IBOutlet weak var inputValueOutlet: UITextField!
    //@IBOutlet weak var outputValueOutlet: UITextField!
    @IBOutlet weak var outputButtonValueOutlet: UIButton!
    @IBOutlet weak var inputSymbolOutlet: UILabel!
    @IBOutlet weak var outputSymbolOutlet: UILabel!
    @IBOutlet weak var inputSymbolSuffixOutlet: UILabel!
    @IBOutlet weak var outputSymbolSuffixOutlet: UILabel!
    
    //MARK: Actions
    @IBAction func inputButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        toggleValue = 0
        
        if(pickingToggle == 0 && pickerOutputAlreadyOpen == false){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = true
            pickerOutputAlreadyOpen = false
        }
        else if (pickingToggle == 0 && pickerOutputAlreadyOpen == true){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = true
            pickerOutputAlreadyOpen = false
        }
        else if (pickingToggle == 1 && pickerOutputAlreadyOpen == false){
            pickerOutlet.isHidden = true
            pickingToggle = 0
            pickerInputAlreadyOpen = false
            pickerOutputAlreadyOpen = false
        }
        else if (pickingToggle == 1 && pickerOutputAlreadyOpen == true){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = true
            pickerOutputAlreadyOpen = false
        }
        
        print("input pressed")
    }
    
    @IBAction func outputButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        toggleValue = 1

        if(pickingToggle == 0 && pickerInputAlreadyOpen == false){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = false
            pickerOutputAlreadyOpen = true
        }
        else if (pickingToggle == 0 && pickerInputAlreadyOpen == true){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = false
            pickerOutputAlreadyOpen = true
        }
        else if (pickingToggle == 1 && pickerInputAlreadyOpen == false){
            pickerOutlet.isHidden = true
            pickingToggle = 0
            pickerInputAlreadyOpen = false
            pickerOutputAlreadyOpen = false
        }
        else if (pickingToggle == 1 && pickerInputAlreadyOpen == true){
            pickerOutlet.isHidden = false
            pickingToggle = 1
            pickerInputAlreadyOpen = false
            pickerOutputAlreadyOpen = true
        }
        
        print("output pressed")
    }
    @IBAction func inputActionDown(_ sender: Any) {
        self.view.endEditing(true)
        pickerOutlet.isHidden = true
        pickingToggle = 0
    }
    @IBAction func outputActionDown(_ sender: Any) {
        self.view.endEditing(true)
        
        pickerOutlet.isHidden = true
        pickingToggle = 0
    }
    @IBAction func inputTyping(_ sender: Any) {
        
        
        if(inputValueOutlet.text != ""){
            print("Value is not nil")
            updateInput()
            updateOutput()
        }
        else{
            updateInput()
            print("Value is nil")
        }
        
    }
    
    @IBAction func outputActionCopy(_ sender: Any) {
        self.view.endEditing(true)
        
         inputValueString = self.inputValueOutlet.text as String!
        
        UIPasteboard.general.string = "\(inputCurrencySymbol)\(inputValueString) converts to \(currencySumbol)\(outputString)" as String!
        
        let alertController = UIAlertController(title: "", message: "Copied to pasteboard!", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        present(alertController, animated: true, completion: nil)
        
        print("Copied")
    }
    
    
    //Initialize Array
    var conversionSelection:String = ""
    
    var pickerCurrency:[String] = ["USD", "EUR", "GBP", "CAD", "AUD", "BGN", "BRL", "CHF", "CNY" , "CZK", "DKK", "HKD", "HRK", "HUF", "IDR", "ILS", "INR", "JPY", "KRW", "MXN", "MYR", "NOK", "NZD", "PHP", "PLN", "RON", "RUB", "SEK", "SGD", "THB", "TRY", "ZAR" ]
    
    
    
    //MARK: - Delegates and data sources
    //MARK: Data Sources
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCurrency.count
    }
    
    //MARK: Delegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return pickerCurrency[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        
        conversionSelection = pickerCurrency[row]
        
        if(toggleValue == 0){
            inputButtonOutlet.setTitle(pickerCurrency[row], for: .normal)
            inputCurrencySymbolSuffix = ""
            
            
            if(inputButtonOutlet.currentTitle! == "USD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "EUR"){
                inputCurrencySymbol = "€"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "GBP"){
                inputCurrencySymbol = "£"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "CAD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "AUD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "BGN"){
                inputCurrencySymbol = "лв"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "BRL"){
                inputCurrencySymbol = "R$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "CHF"){
                inputCurrencySymbol = "Fr "
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "CNY"){
                inputCurrencySymbol = "¥"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "CZK"){
                //PUT THIS ON LATER
                inputCurrencySymbol = ""
                inputCurrencySymbolSuffix = "Kč"
            }
            else if(inputButtonOutlet.currentTitle! == "DKK"){
                inputCurrencySymbol = "kr"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "HKD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "HRK"){
                inputCurrencySymbol = "kn"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "HUF"){
                inputCurrencySymbol = "Ft"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "IDR"){
                inputCurrencySymbol = "Rp"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "ILS"){
                inputCurrencySymbol = "₪"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "INR"){
                inputCurrencySymbol = "₹"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "JPY"){
                inputCurrencySymbol = "¥"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "KRW"){
                inputCurrencySymbol = "₩"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "MXN"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "MYR"){
                inputCurrencySymbol = "RM"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "NOK"){
                //PUT THIS ON AFTER STRING
                inputCurrencySymbol = ""
                inputCurrencySymbolSuffix = "kr"
            }
            else if(inputButtonOutlet.currentTitle! == "NZD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "PHP"){
                inputCurrencySymbol = "₱"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "PLN"){
                inputCurrencySymbol = "zł"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "RON"){
                //PUT THIS ON AFTER THE STRING
                inputCurrencySymbol = ""
                inputCurrencySymbolSuffix = "lei"
            }
            else if(inputButtonOutlet.currentTitle! == "RUB"){
                inputCurrencySymbol = "₽"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "SEK"){
                //PUT THIS ON AFTER THE STRING
                inputCurrencySymbol = ""
                inputCurrencySymbolSuffix = "kr"
            }
            else if(inputButtonOutlet.currentTitle! == "SGD"){
                inputCurrencySymbol = "$"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "THB"){
                inputCurrencySymbol = "฿"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "TRY"){
                inputCurrencySymbol = "₺"
                inputCurrencySymbolSuffix = ""
            }
            else if(inputButtonOutlet.currentTitle! == "ZAR"){
                inputCurrencySymbol = "R "
                inputCurrencySymbolSuffix = ""
            }
            
            updateInput()

        }
        if(toggleValue == 1){
            outputButtonOutlet.setTitle(pickerCurrency[row], for: .normal)
            currencySymbolSuffix = ""
            
            if(outputButtonOutlet.currentTitle! == "USD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "EUR"){
                currencySumbol = "€"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "GBP"){
                currencySumbol = "£"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "CAD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "AUD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "BGN"){
                currencySumbol = "лв"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "BRL"){
                currencySumbol = "R$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "CHF"){
                currencySumbol = "Fr "
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "CNY"){
                currencySumbol = "角"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "CZK"){
                //PUT THIS ON LATER
                currencySumbol = ""
                currencySymbolSuffix = "Kč "
            }
            else if(outputButtonOutlet.currentTitle! == "DKK"){
                currencySumbol = "kr"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "HKD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "HRK"){
                currencySumbol = "kn"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "HUF"){
                currencySumbol = "Ft"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "IDR"){
                currencySumbol = "Rp"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "ILS"){
                currencySumbol = "₪"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "INR"){
                currencySumbol = "₹"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "JPY"){
                currencySumbol = "¥"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "KRW"){
                currencySumbol = "₩"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "MXN"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "MYR"){
                currencySumbol = "RM"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "NOK"){
                //PUT THIS ON AFTER STRING
                currencySumbol = ""
                currencySymbolSuffix = "kr"
            }
            else if(outputButtonOutlet.currentTitle! == "NZD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "PHP"){
                currencySumbol = "₱"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "PLN"){
                currencySumbol = "zł"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "RON"){
                //PUT THIS ON AFTER THE STRING
                currencySumbol = ""
                currencySymbolSuffix = "lei"
            }
            else if(outputButtonOutlet.currentTitle! == "RUB"){
                currencySumbol = "₽"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "SEK"){
                //PUT THIS ON AFTER THE STRING
                currencySumbol = ""
                currencySymbolSuffix = "kr"
            }
            else if(outputButtonOutlet.currentTitle! == "SGD"){
                currencySumbol = "$"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "THB"){
                currencySumbol = "฿"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "TRY"){
                currencySumbol = "₺"
                currencySymbolSuffix = ""
            }
            else if(outputButtonOutlet.currentTitle! == "ZAR"){
                currencySumbol = "R "
                currencySymbolSuffix = ""
            }
        }
        outputButtonValueOutlet.setTitle(" ", for: .normal)
        
        
        
        if(inputValueOutlet.text != ""){
            print("Value is not nil")
            updateOutput()
        }
        else{
            print("Value is nil")
        }
        
        
        
    }
    
    
    func handleRequest(){
        
        
        let inputTitle:String = inputButtonOutlet.currentTitle!
        let outputTitle:String = outputButtonOutlet.currentTitle!
        
        //GETTING DATA
        var url:URL = URL(string: "http://api.fixer.io")!
        url = URL(string: "http://api.fixer.io/latest?base=\(inputTitle)&symbols=\(outputTitle)")!
        
        print("Input = \(inputTitle)")
        print("Output = \(outputTitle)")
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil
            {
                print ("ERROR")
            }
            else
            {
                if let content = data
                {
                    do
                    {
                        let myJson = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                        
                        if let rates = myJson["rates"] as? NSDictionary
                        {
                            for (key, value) in rates
                            {
                                print(key)
                                if(self.conversionRate.count == 1){
                                    self.conversionRate.removeAll()
                                }
                                self.conversionRate.append((value as? Double)!)
                                
                                print(self.conversionRate)
                                
                                //Get input value
                                if(self.inputValueOutlet.text != nil){
                                    
                                    
                                    //Convert newString to Double for calculations
                                    let inputValue:Double = Double(self.inputValueOutlet.text!)!
                                    
                                    //Create double variable to convert a [Double]
                                    let conversionRateValue = self.conversionRate[0]
                                    
                                    //Get output value
                                    let outputValue:Double = Double(round(100 * (inputValue * conversionRateValue))/100)
                                    
                                    //Convert output from Double to String
                                    self.outputString = String(outputValue)
                                    
                                    self.parsed = true
                                    
                                    
                                }
                                else{
                                    self.outputString = String(" ")
                                    
                                    self.parsed = true
                                    
                                }
                                
                                
                                
                                
                            }
                        }
                    }
                    catch
                    {
                        print("catch called")
                    }
                }
                
            }
            
           //self.pickerView.reloadAllComponents()
        }
        
        task.resume()

        
    }
    
    func updateInput(){
        
        //print("inputString \(self.inputValueOutlet.text)")
        //inputValueOutlet.text = "\(inputCurrencySymbol)" as String!
        inputSymbolOutlet.text = inputCurrencySymbol as String!
        inputSymbolSuffixOutlet.text = inputCurrencySymbolSuffix as String!

    }
    
    func updateOutput(){
        
        handleRequest()
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            if(self.parsed == true){
                print("outputString \(self.outputString)")
                self.outputButtonValueOutlet.setTitle("\(self.outputString)", for: .normal)
                self.outputSymbolOutlet.text = self.currencySumbol as String!
                self.outputSymbolSuffixOutlet.text = self.currencySymbolSuffix as String!
            }
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        let titleData = pickerCurrency[row]
        let myTitle = NSAttributedString(string: titleData, attributes: [NSFontAttributeName:UIFont(name: "Georgia", size: 15.0)!,NSForegroundColorAttributeName:UIColor.white])
        return myTitle
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        pickerOutlet.dataSource = self
        pickerOutlet.delegate = self
        pickerOutlet.isHidden = true;
        
        //Add Borders to Buttons
        
        let swiftColor = UIColor(red: 102/255, green: 255/255, blue: 102/255, alpha: 1)
        
        inputButtonOutlet.backgroundColor = .clear
        inputButtonOutlet.layer.cornerRadius = 3
        inputButtonOutlet.layer.borderWidth = 0.5
        inputButtonOutlet.layer.borderColor = swiftColor.cgColor
        
        outputButtonOutlet.backgroundColor = .clear
        outputButtonOutlet.layer.cornerRadius = 3
        outputButtonOutlet.layer.borderWidth = 0.5
        outputButtonOutlet.layer.borderColor = swiftColor.cgColor
        
        inputValueOutlet.layer.borderColor = swiftColor.cgColor
        

        //Set Initial I/O
        inputButtonOutlet.setTitle("USD", for: .normal)
        inputCurrencySymbol = "$"
        inputCurrencySymbolSuffix = ""
        updateInput()

        outputButtonOutlet.setTitle("EUR", for: .normal)
        currencySumbol = "€"
        currencySymbolSuffix = ""
        updateOutput()
        
        
        
        outputButtonValueOutlet.titleLabel!.minimumScaleFactor = 0.1
        outputButtonValueOutlet.titleLabel!.numberOfLines = 1
        outputButtonValueOutlet.titleLabel!.adjustsFontSizeToFitWidth = true
        outputButtonValueOutlet.titleLabel!.adjustsFontForContentSizeCategory = true
        
        currencyTitleOutlet.minimumScaleFactor = 0.1
        currencyTitleOutlet.numberOfLines = 1
        currencyTitleOutlet.adjustsFontSizeToFitWidth = true
        
        
        inputButtonOutlet.titleLabel!.adjustsFontForContentSizeCategory = true
        currencyTitleOutlet.adjustsFontForContentSizeCategory = true
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        

        
        
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
        
        pickingToggle = 0
        pickerOutlet.isHidden = true
        pickerInputAlreadyOpen = false
        pickerOutputAlreadyOpen = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

