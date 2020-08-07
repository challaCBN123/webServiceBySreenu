//
//  ViewController.swift
//  WebServiceWithJson
//
//  Created by SRINIVASULU on 29/09/19.
//  Copyright © 2019 SRINIVASULU. All rights reserved.
//

import UIKit

class ViewController: UIViewController,DetailsViewControllerDelegate {
    var total_Dict = NSDictionary()
    @IBOutlet weak var tbl: UITableView!
   // @IBOutlet var table_table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tbl.delegate = self
        // Do any additional setup after loading the view.
        callingWebServices(url_Str: "http://139.59.92.46/iOSBlogJSON/days.json")
        nibfile()
    }
    func nibfile(){
        let nib1 = UINib(nibName: "MovieCell", bundle: nil)
        tbl.register(nib1, forCellReuseIdentifier: "MovieCell")
    }
    // Mark :- receiving data from json
    func callingWebServices(url_Str: String){
        let session = URLSession.shared
        let url = URL(string: url_Str)!

        let task = session.dataTask(with: url) { data, response, error in
         
            if error != nil || data == nil {
                print("Client error!")
                return
            }

            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }

            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }

            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
                self.getDict(dict: json as! NSDictionary)
            } catch {
                print("JSON error: \(error.localizedDescription)")
            }
        }

        task.resume()
    }

    func getDict(dict: NSDictionary)
    {
        self.total_Dict = dict
       // tbl.reloadData()
        DispatchQueue.main.async {
            self.tbl.reloadData()
        }
    }
    func ReloadData(){
         DispatchQueue.main.async {
           self.tbl.reloadData()
        }
       }
}

//MARK: table View
extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countData = NSInteger()
        if section == 0{
        if let dc_arr = self.total_Dict.value(forKey: "DC"){
            let arr = dc_arr as! NSArray
            countData = arr.count
        }
        }else if section == 1{
            if let Marvel_arr = self.total_Dict.value(forKey: "Marvel"){
                let arr = Marvel_arr as! NSArray
                countData = arr.count
            }
        }
        return countData
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieCell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)as! MovieCell
         print("\(#function) --- section = \(indexPath.section), row = \(indexPath.row)")
        if indexPath.section == 0{
            if let dc_arr = self.total_Dict.value(forKey: "DC"){
                let arr = dc_arr as! NSArray
                let dict_Data = arr.object(at: indexPath.row) as! NSDictionary
                cell.lbl_Actor.text = dict_Data.value(forKey: "Actor") as? String
                cell.lbl_Name.text = dict_Data.value(forKey: "TITLE") as? String
                cell.lbl_Details.text = dict_Data.value(forKey: "DETAILS") as? String
            }
        }else if indexPath.section == 1{
            if let dc_arr = self.total_Dict.value(forKey: "Marvel"){
                let arr = dc_arr as! NSArray
                let dict_Data = arr.object(at: indexPath.row) as! NSDictionary
                cell.lbl_Actor.text = dict_Data.value(forKey: "Actor") as? String
                cell.lbl_Name.text = dict_Data.value(forKey: "TITLE") as? String
                cell.lbl_Details.text = dict_Data.value(forKey: "DETAILS") as? String
            }
        }


        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var str_name = String()
        if section == 0{
            str_name = "DC"
        }else if section == 1{
            str_name = "Marvel"
        }
        return str_name
    }
    //Mark :- Goto another screen when we pressed on cell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        var dict_data = NSMutableDictionary()
        if indexPath.section == 0{
            if let dc_arr = self.total_Dict.value(forKey: "DC"){
                let arr = dc_arr as! NSArray
                let dict_Data = arr.object(at: indexPath.row) as! NSDictionary
                dict_data = dict_Data.mutableCopy() as! NSMutableDictionary
            }
        }else if indexPath.section == 1{
            if let dc_arr = self.total_Dict.value(forKey: "Marvel"){
                let arr = dc_arr as! NSArray
                let dict_Data = arr.object(at: indexPath.row) as! NSDictionary
                     dict_data = dict_Data.mutableCopy() as! NSMutableDictionary
            }
        }
        if dict_data.count != 0{
        let detail = self.storyboard?.instantiateViewController(withIdentifier: "detailViewController") as! detailViewController
            detail.mut_Dict = dict_data
        self.navigationController?.pushViewController(detail, animated: true)
        }
          
    }
}
