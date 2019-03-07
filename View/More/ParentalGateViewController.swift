//
//  ParentalGateViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 9/17/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit

class ParentalGateViewController: MooWhoViewController {

    var urlString:String? = nil
    var rightOption: Int? = nil
    var options:[String]? = nil
    var question: String? = nil
    static var counter: Int = 0
    
    @IBOutlet weak var questionLabel: UILabel!
    
    @IBOutlet weak var option1Button: UIButton!
    
    @IBOutlet weak var option2Button: UIButton!
    
    @IBOutlet weak var option3Button: UIButton!
    
    
    @IBOutlet weak var option4Button: UIButton!
    

    @IBAction func option1Selected(_ sender: Any) {
       optionSelected(option: 0)
    }
    
    @IBAction func option2Selected(_ sender: Any) {
        optionSelected(option: 1)
    }
    
    
    @IBAction func option3Selected(_ sender: Any) {
        optionSelected(option: 2)
    }
    
    @IBAction func option4Selected(_ sender: Any) {
        optionSelected(option: 3)
    }
    
    func optionSelected(option: Int) {
        if (rightOption == option) {
            openUrl()
            self.navigationController?.popViewController(animated: false)
        } else {
            // Go Back
            let alert = UIAlertController(title: "Uh oh!", message: "We need your parents approval before going ahead. Let's play in the meanwhile :)", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                self.navigationController?.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getGateInput()
        setUIWithGateInput()
    }
    
    func getGateInput() {
        switch(ParentalGateViewController.counter) {
        case 0:
            question = "Which of these is not a fruit?"
            options = ["Apple", "Pear", "Rose", "Banana"]
            rightOption = 2
            break
        case 1:
            question = "Which of these is not a vegetable?"
            options = ["Cauliflower", "Apple", "Spinach", "Carrot"]
            rightOption = 1
            break
        case 2:
            question = "Which of these is not a flower?"
            options = ["Banana", "Lotus", "Rose", "Camelia"]
            rightOption = 0
            break
        default:
            print("Counter exceeds 2")
            break
        }
        ParentalGateViewController.counter = ParentalGateViewController.counter + 1
        if (ParentalGateViewController.counter > 2) {
            ParentalGateViewController.counter = 0
        }
    }

    func setUIWithGateInput() {
        questionLabel.text = question!
        option1Button.setTitle(options![0], for: .normal)
        option2Button.setTitle(options![1], for: .normal)
        option3Button.setTitle(options![2], for: .normal)
        option4Button.setTitle(options![3], for: .normal)
        
        option1Button.layer.cornerRadius = 10
        option2Button.layer.cornerRadius = 10
        option3Button.layer.cornerRadius = 10
        option4Button.layer.cornerRadius = 10
  }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func openUrl() {
        if (urlString != nil) {
            let url = URL(string: urlString!)!
            UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
        }
    }
    
    
    /*
    override func performSegue(withIdentifier identifier: String, sender: Any?) {
        if (identifier == "animalDetailSegue") {
            super.performSegue(withIdentifier: identifier, sender: sender)
            self.navigationController?.viewControllers.remove(at: (self.navigationController?.viewControllers.index(of: self))!)
        }
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
}
