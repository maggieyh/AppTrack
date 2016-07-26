
//
//  SearchViewController.swift
//  ChoreSolver
//
//  Created by yao  on 7/11/16.
//  Copyright © 2016 yao . All rights reserved.
//

import UIKit
import Parse
import FBSDKCoreKit
import ParseUI
import ParseFacebookUtilsV4

class SearchViewController: UIViewController {

    var selectedCounty: String?
    var notificationNum: Int?
    @IBOutlet weak var countyPickerView: UIPickerView!
    
    @IBAction func unwindBackToSearchView(segue:UIStoryboardSegue) {
        
    }
    let pickerData = Data.counties
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.countyPickerView.delegate = self
        self.countyPickerView.dataSource = self
//        self.tabBarController?.tabBar.items![1].badgeValue = String(notificationNum!)
        
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResult" {
            let viewController = segue.destinationViewController as! SearchResultViewController
            viewController.selectedCounty = self.selectedCounty!
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SearchViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    //MARK
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedCounty = pickerData[row]
        self.performSegueWithIdentifier("showResult", sender: pickerView)
        
    }
}