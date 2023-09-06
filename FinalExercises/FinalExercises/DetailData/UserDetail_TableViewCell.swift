//
//  UserDetail_TableViewCell.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import UIKit

class UserDetail_TableViewCell: UITableViewCell {

    
    @IBOutlet weak var lbl_DetailName: UILabel!
    @IBOutlet weak var img_DetailUser: UIImageView!
    @IBOutlet weak var img_Logo: UIImageView!
    @IBOutlet weak var lbl_Followers: UILabel!
    @IBOutlet weak var lbl_Created_At: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

        
}
