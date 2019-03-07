//
//  MoreTableViewController.swift
//  MooWho
//
//  Created by Priyanka Joshi on 8/9/18.
//  Copyright © 2018 Priyanka Joshi. All rights reserved.
//

import UIKit
import StoreKit


class MoreTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    fileprivate let AppleID = "1425138658"
    fileprivate let moreCellIdentifier = "moreCellIdentifier"
    
    var gradientLayer:CAGradientLayer = CAGradientLayer()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = tableView.frame
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView?.register(MoreTableViewCell.self, forCellReuseIdentifier: moreCellIdentifier)
        gradientLayer.colors =
            [GRADIENT_COLOR_TOP.cgColor,GRADIENT_COLOR_BOTTOM.cgColor]
       //Use different colors
        if (tableView.backgroundView == nil) {
            let backgroundView = UIView(frame: tableView.frame)
            tableView.backgroundView = backgroundView
        }
        tableView.backgroundView?.layer.insertSublayer(gradientLayer, at: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 4
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: moreCellIdentifier, for: indexPath) as! MoreTableViewCell
        cell.backgroundColor = UIColor.clear
        cell.textLabel?.font = UIFont(name:CUSTOM_FONT, size:22)
        switch (indexPath.row) {
        case 0:
            cell.textLabel?.text = "Share MooWho"
            break
        case 1:
            cell.textLabel?.text = "Rate MooWho"
            break
        case 2:
            cell.textLabel?.text = "MooWho website"
            break
        case 3:
            cell.textLabel?.text = "Contact the developer"
            break
        default:
            break
        }
        return cell
    }
    
    //MARK: UITableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch (indexPath.row) {
        case 0: //Share
            displayShareSheet()
            break
        case 1: // Rate app
            rateApp()
            break
        case 2: // Go to app website
            goToAppWebsite()
            break
        case 3: // Go to app website
            goToContactUs()
            break
        default:
            break
        }
    }
    
    func displayShareSheet () {
        let shareMessage = "Check out MooWho, the iOS app to hear and guess animal sounds"
        var objectsToShare: [Any]
        if let url = URL.init(string: "http://itunes.apple.com/us/app/moowho/id1425138658?mt=8") {
             objectsToShare = [shareMessage, url] as [Any]
        } else {
             objectsToShare = [shareMessage]
        }
        let activityViewController = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)

        activityViewController.popoverPresentationController?.sourceView = self.view
        present(activityViewController, animated: true, completion: nil)

    }
    
    func rateApp() {
        if #available( iOS 10.3,*){
            SKStoreReviewController.requestReview()
        } else {
            openUrl("itms-apps://itunes.apple.com/us/app/moowho/" + AppleID)
        }
    }
    
    fileprivate func openUrl(_ urlString: String) {
        let url = URL(string: urlString)!
        UIApplication.shared.open(url, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
    }
    
    func goToAppWebsite() {
        self.performSegue(withIdentifier: "parentalGateSegue", sender: "http://moowhotheapp.wordpress.com/")
    }
    
    func goToContactUs() {
        self.performSegue(withIdentifier: "parentalGateSegue", sender: "http://moowhotheapp.wordpress.com/contact/")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ParentalGateViewController {
            controller.urlString = sender as? String
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
