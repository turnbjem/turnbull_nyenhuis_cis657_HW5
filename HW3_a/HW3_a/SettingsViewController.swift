//
//  SettingsViewController.swift
//  HW3_a
//
//  Created by Reuben B. Nyenhuis on 5/16/19.
//  Copyright © 2019 Jemima Turnbull. All rights reserved.
//

import UIKit


protocol DistanceSelectionViewControllerDelegate {
    func indicateSelection(distanceUnits: String, bearingUnits: String)
    func Calculate()
}



class SettingsViewController: UIViewController {
    
    @IBOutlet weak var DistanceLabel: UILabel!
    @IBOutlet weak var BearingLabel: UILabel!
    
    @IBOutlet weak var DistanceTextFieldII: UITextField!
    @IBOutlet weak var BearingTextFieldII: UITextField!
    
    
    
    @IBOutlet weak var DistanceUnitsPicker: UIPickerView!
    var pickerData: [String] = [String]()
    var selection : [String] = ["Kilometers", "Degrees"]
    var delegate : DistanceSelectionViewControllerDelegate?
    
    let defaults = UserDefaults.standard
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return.lightContent
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setNeedsStatusBarAppearanceUpdate()
        
        selection[0] = defaults.string(forKey: "name1")!
        selection[1] = defaults.string(forKey: "name2")!
        
        
        //self.pickerData = ["Kilometers", "Miles"]
        self.DistanceUnitsPicker.delegate = self
        self.DistanceUnitsPicker.dataSource = self
        self.DistanceTextFieldII.text = selection[0]
        self.BearingTextFieldII.text = selection[1]
        
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissPickerView))
        self.view.addGestureRecognizer(detectTouch)
        
        
        DistanceTextFieldII.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(userDidTapDistanceTextField(tapGestureRecognizer:)))
        DistanceTextFieldII.addGestureRecognizer(tapGesture)
        
        BearingTextFieldII.isUserInteractionEnabled = true
        let tapGesture2 = UITapGestureRecognizer(target: self, action: #selector(userDidTapBearingTextField(tapGestureRecognizer:)))
        BearingTextFieldII.addGestureRecognizer(tapGesture2)
        
    }
    
    @objc func dismissPickerView(){
        self.DistanceUnitsPicker.isHidden = true

        
    }

    
    @objc func userDidTapDistanceTextField(tapGestureRecognizer: UITapGestureRecognizer) {
        self.DistanceUnitsPicker.isHidden = false
        self.pickerData = ["Kilometers", "Miles"]
        self.DistanceUnitsPicker.delegate = self
        self.DistanceUnitsPicker.dataSource = self
        self.DistanceUnitsPicker.reloadAllComponents()
        
    }
    
    
    @objc func userDidTapBearingTextField(tapGestureRecognizer: UITapGestureRecognizer) {
        self.DistanceUnitsPicker.isHidden = false
        self.pickerData = ["Degrees", "Mils"]
        self.DistanceUnitsPicker.delegate = self
        self.DistanceUnitsPicker.dataSource = self
        self.DistanceUnitsPicker .reloadAllComponents()
        
        
    }
    
    @objc func isDistancePickerView(pickerData: [String]) -> Bool{
        if pickerData[0] == "Kilometers" {
            return true
        }
        else {
            return false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func SavePressed(_ sender: UIBarButtonItem) {
        if let d = self.delegate {
            d.indicateSelection(distanceUnits: selection[0], bearingUnits:  selection[1])
            d.Calculate()
                defaults.setValue(selection[0], forKey: "name1")
                defaults.setValue(selection[1], forKey: "name2")
            
        }
        self.dismiss(animated: true, completion: nil)
       
        
    }
    

    
    @IBAction func CancelPressed(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
   
}

extension SettingsViewController : UIPickerViewDataSource, UIPickerViewDelegate {
    // The number of columns of data
    func numberOfComponents(in: UIPickerView) -> Int
    {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        
        if isDistancePickerView(pickerData: pickerData) == true {
            self.DistanceTextFieldII.text = self.pickerData[row]
            self.selection[0] = self.pickerData[row]
        }
        else {
            self.BearingTextFieldII.text = self.pickerData[row]
            self.selection[1] = self.pickerData[row]
        }
        
    }
}
