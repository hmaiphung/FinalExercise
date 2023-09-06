//
//  UserData_TableViewCell.swift
//  FinalExercises
//
//  Created by Phung Huy on 30/08/2023.
//

import UIKit

class UserData_TableViewCell: UITableViewCell {
    
        
    @IBOutlet weak var img_Avatar: UIImageView!
    @IBOutlet weak var btn_HtmlUrl: UIButton!
    @IBOutlet weak var lbl_Login: UILabel!
  
    
    var openUrlAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func OpenUrl(_ sender: Any) {
        openUrlAction!()
    }
}
