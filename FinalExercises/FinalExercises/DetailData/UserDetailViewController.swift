//
//  UserDetailViewController.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import UIKit
import CoreData

class UserDetailViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var UserDetail_TableView: UITableView!
    
    var detailURL: String!
    
    var userDetails: [String: Any]?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDetail_TableView.dataSource = self
        UserDetail_TableView.delegate = self
        
        UserDetail_TableView.rowHeight = UITableView.automaticDimension
        UserDetail_TableView.estimatedRowHeight = 100
        
        fetchDetailFromAPI()
        
    }
    
    func fetchDetailFromAPI() {
        DispatchQueue.global().async {
            NetworkDetail.fetchingDetail(URL: self.detailURL) { json in
                DispatchQueue.main.async {
                    self.userDetails = json
                    self.UserDetail_TableView.reloadData()
                }
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UserDetail_TableView.dequeueReusableCell(withIdentifier:"DetailCELL") as! UserDetail_TableViewCell
        
        cell.img_Logo.image = UIImage(named: "logo")

        
        if let userDetails = self.userDetails {
            if let name = userDetails["name"] as? String {
                cell.lbl_DetailName.text = name
            } else {
                cell.lbl_DetailName.text = "Name not Available"
            }
            
            if let followers = userDetails["followers"] as? Int {
                cell.lbl_Followers.text = "\(followers) followers"
            } else {
                cell.lbl_Followers.text = "No One"
            }
            
            if let email = userDetails["email"] as? String {
                cell.lbl_Email.text = email
            } else {
                cell.lbl_Email.text = "Email not available"
            }

            
            if let created_at = userDetails["created_at"] as? String {
                let formattedDate = convertDateString(created_at)
                cell.lbl_Created_At.text = "Since \(formattedDate)"
            } else {
                cell.lbl_Created_At.text = "Date not available"
            }

            if let imageUrlDetail = userDetails["avatar_url"] as? String,
                let imageUrl = URL(string: imageUrlDetail) {
                DispatchQueue.global().async {
                    if let imageData = try? Data(contentsOf: imageUrl),
                       let image = UIImage(data: imageData) {
                        DispatchQueue.main.async {
                            cell.img_DetailUser.image = image
                            
                        }
                    }
                }
            }

    }
    return cell
    }
    
    
    func convertDateString(_ dateString: String) -> String {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatterInput.date(from: dateString) {
            return dateFormatterOutput.string(from: date)
        }
        
        return "Date not available"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height/1

    }
    
}
