//
//  ViewController.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import UIKit

class UserDataViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
 

    @IBOutlet weak var UserData_TableView: UITableView!
    
    
    var arrayLogin: [String]? = []
    var arrayAvatar: [String]? = []
    var arrayHtml_url: [String]? = []
    var arrayurl: [String]? = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Swifters"
        
        UserData_TableView.dataSource = self
        UserData_TableView.delegate = self
        
        
        
        if let savedData = UserDefaults.standard.value(forKey: "userData") as? Data,
           let userDataArray = try? JSONDecoder().decode([UserData].self, from: savedData) {
            self.arrayLogin = userDataArray.map { $0.login }
            self.arrayAvatar = userDataArray.map { $0.avatar_url }
            self.arrayHtml_url = userDataArray.map { $0.html_url }
            self.arrayurl = userDataArray.map { $0.url }
            self.UserData_TableView.reloadData()
        } else {
            fetchDataFromAPI()
        }
    }
    
    func fetchDataFromAPI() {
        let apiURL = "https://api.github.com/users"
        fetchingData(URL: apiURL) { userDataArray in
            self.arrayLogin = userDataArray.map { $0.login }
            self.arrayAvatar = userDataArray.map { $0.avatar_url }
            self.arrayHtml_url = userDataArray.map { $0.html_url }
            self.arrayurl = userDataArray.map { $0.url }
            
            if let encodedData = try? JSONEncoder().encode(userDataArray) {
                UserDefaults.standard.set(encodedData, forKey: "userData")
            }
            
            DispatchQueue.main.async {
                self.UserData_TableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayLogin!.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserData_TableView.dequeueReusableCell(withIdentifier:"DataCELL") as! UserData_TableViewCell
        cell.lbl_Login.text = arrayLogin![indexPath.row]
        cell.btn_HtmlUrl!.setTitle(arrayHtml_url![indexPath.row], for: .normal)
        
        cell.openUrlAction = {
            if let html_url = URL(string: self.arrayHtml_url![indexPath.row]) {
                UIApplication.shared.open(html_url, options: [:], completionHandler: nil)
            }
        }
            
        if let imageUrl = URL(string: self.arrayAvatar![indexPath.row]) {
            let fetchingDownloading = DispatchQueue(label: "Downloading")
            fetchingDownloading.async {
                if let image = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.img_Avatar.image = UIImage(data: image)
                    }
                } else {
                    if let defaultImage = UIImage(named: "LoadFail") {
                        DispatchQueue.main.async {
                            cell.img_Avatar.image = defaultImage
                        }
                    }
                }
            }
        } else {
           
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/2.3

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailUserVC = storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        
        detailUserVC.detailURL = self.arrayurl![indexPath.row]
        
        navigationController?.pushViewController(detailUserVC, animated: true)
    }
    
}

