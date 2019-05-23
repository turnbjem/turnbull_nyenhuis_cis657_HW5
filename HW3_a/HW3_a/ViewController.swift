//
//  ViewController.swift
//  HW3_a
//
//  Created by Jemima Turnbull on 5/15/19.
//  Copyright © 2019 Jemima Turnbull. All rights reserved.
//

import UIKit
import CoreLocation


class ViewController: UIViewController, DistanceSelectionViewControllerDelegate{

    @IBOutlet weak var LatP1: UITextField!
    
    @IBOutlet weak var LatP2: UITextField!
    
    @IBOutlet weak var LongP1: UITextField!
    
    @IBOutlet weak var BearingTextField: UILabel!
    @IBOutlet weak var DistanceTextField: UILabel!
    @IBOutlet weak var LongP2: UITextField!
    
    
    var distance: CLLocationDistance = 0.0
    var bearing: Double = 0.0
    var DistanceUnits: String = ""
    var BearingUnits: String = ""
    var latitude1 : CLLocationDegrees = 0.0
    var longitude1 : CLLocationDegrees = 0.0
    var latitude2 : CLLocationDegrees = 0.0
    var longitude2 : CLLocationDegrees = 0.0
    
    var loc1 : CLLocation = CLLocation()
    var loc2 : CLLocation = CLLocation()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = BACKGROUND_COLOR
        
        self.BearingTextField.text = "Bearing: "
        self.DistanceTextField.text = "Distance: "
        let detectTouch = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
        self.view.addGestureRecognizer(detectTouch)
        
        self.LatP1.delegate = self
        self.LatP2.delegate = self
        self.LongP1.delegate = self
        self.LongP2.delegate = self
        
        UserDefaults.standard.setValue("Kilometers", forKey: "name1")
        UserDefaults.standard.setValue("Degrees", forKey: "name2")

        self.DistanceUnits = UserDefaults.standard.string(forKey: "name1") ?? "Kilometers"
        self.BearingUnits = UserDefaults.standard.string(forKey: "name2") ?? "Degrees"
        
    }
    
    @objc func dismissKeyboard(){
        self.view.endEditing(true)
    }
    

    
    func checkInput() -> Bool {
        var OK = false
        if LatP1.text != "" && LatP2.text != "" && LongP1.text != "" && LongP2.text != ""{
            OK = true
        }
        return OK
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ViewSettingsSegue" {
            if let nc = segue.destination as? UINavigationController {
                if let dest = nc.children[0] as? SettingsViewController {
                    dest.delegate = self
                }
                
            }
            
            }
        }
    
    func indicateSelection(distanceUnits: String, bearingUnits: String) {
        
        self.DistanceUnits = distanceUnits
        self.BearingUnits = bearingUnits
    }
    
    func Calculate(){
        if self.checkInput(){
            latitude1 = Double(LatP1.text!)!
            latitude2 = Double(LatP2.text!)!
            longitude1 = Double(LongP1.text!)!
            longitude2 = Double(LongP2.text!)!
            
            
            loc1 = CLLocation(latitude: latitude1, longitude: longitude1)
            loc2 = CLLocation(latitude: latitude2, longitude: longitude2)
            //distance in meters
            distance = loc1.distance(from: loc2)
            //bearing in degrees
            bearing = loc1.bearingToPoint(point: loc2)
            
            if self.DistanceUnits == "Kilometers"{
                //convert distance to kilometers and then round to 100th
                distance = round(100 * (distance*0.001)) / 100
            }
            else {
                //convert Kilometers to Miles
                distance = round(100 * (distance * 0.0006213712)) / 100
            }
            if self.BearingUnits == "Degrees" {
                //round bearing to 100th
                bearing = round(100 * bearing) / 100
            }
            else {
                bearing = Double(Float(bearing) * 17.77777777777778)
                bearing = round(100 * bearing) / 100
            }
            
            DistanceTextField.text = "Distance: \(distance)" + " " + self.DistanceUnits
            BearingTextField.text = "Bearing: \(bearing)" +  " " + self.BearingUnits
        }
        else {
            print("You have not entered a value!")
        }
        
        self.dismissKeyboard()
    }
    
    
    @IBAction func CalcTapped(_ sender: UIButton) {
        self.Calculate()
    }
    
    
    
    

    @IBAction func ClearTapped(_ sender: UIButton) {
        LatP1.text = ""
        LatP2.text = ""
        LongP1.text = ""
        LongP2.text = ""
        DistanceTextField.text = "Distance: "
        BearingTextField.text = "Bearing: "
    }
    
    
}

extension ViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        if textField == self.LatP1 {
            self.LongP1.becomeFirstResponder()
        }
        else if textField == self.LongP1{
            self.LatP2.becomeFirstResponder()
        }
        else if textField == self.LatP2 {
            self.LongP2.becomeFirstResponder()
        }
        else {
            self.Calculate()
        }
        

        
        
        return true
    }
    
    
}

