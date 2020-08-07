//
//  detailViewController.swift
//  WebServiceWithJson
//
//  Created by SRINIVASULU on 29/09/19.
//  Copyright © 2019 SRINIVASULU. All rights reserved.
//

import UIKit
protocol DetailsViewControllerDelegate: AnyObject {
   func ReloadData()
}
class detailViewController: UIViewController {
  
    
    weak var Datadelegate: DetailsViewControllerDelegate?
 @IBOutlet weak var lbl_name: UILabel!
 @IBOutlet weak var lbl_actor: UILabel!
    @IBOutlet weak var lbl_release: UILabel!
    @IBOutlet weak var lbl_details: UILabel!
    var mut_Dict = NSMutableDictionary()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(mut_Dict)
        lbl_details.text = mut_Dict.value(forKey: "DETAILS") as? String
        lbl_release.text = mut_Dict.value(forKey: "Release") as? String
        lbl_name.text = mut_Dict.value(forKey: "TITLE") as? String
        lbl_actor.text = mut_Dict.value(forKey: "Actor") as? String
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
