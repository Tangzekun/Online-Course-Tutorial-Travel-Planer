//
//  ViewController.swift
//  TravelPlaner
//
//  Created by TangZekun on 12/25/15.
//  Copyright © 2015 TangZekun. All rights reserved.
//

import UIKit
import Social
import Accounts

class ViewController: UIViewController,UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    let vacationOptions : [String] = ["Beaches", "Mountains"]
    var selectedOption : String?
    var destination : Destination = Destination()


    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var mySwitch: UISwitch!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var destinationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedOption = "Beach"
        self.destinationLabel.text = ""
        self.pickerView.dataSource = self
        self.pickerView.delegate = self
    }

    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.vacationOptions.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.vacationOptions[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedOption = self.vacationOptions[row]
    }

    @IBAction func whereTapped(sender: AnyObject)
    {
        if mySwitch.on
        {
            if self.selectedOption == "Mountains"
            {
                self.destination.name = "Huangshan"
                self.destination.image = UIImage(named: "huangshan.jpeg")
            }
            else
            {   self.destination.name = "Sanya"
                self.destination.image = UIImage(named: "sanya.jpeg")
            }
        }
        else
        {
            if self.selectedOption == "Mountains"
            {
                self.destination.name = "Oregon Mountain"
                self.destination.image = UIImage(named: "Oregonmountain.jpg")
            }
            else
            {
                self.destination.name = "Oregon Beach"
                self.destination.image = UIImage(named: "OregonBeach.jpg")
            }
        }
        
        self.imageView.image = self.destination.image
        self.destinationLabel.text = "Pack your bags to  \(self.destination.name!)!"
    }
    @IBAction func shareToFb(sender: AnyObject)
    {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook)
        {
            let facebookSheet : SLComposeViewController = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            facebookSheet.setInitialText("My next vacation destionation \(self.destination.name!)!")
            facebookSheet.addImage(self.imageView.image)
            
            
            self.presentViewController(facebookSheet, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Account Unavaible", message: "Please add an avaible Facebook account to share", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }


}

