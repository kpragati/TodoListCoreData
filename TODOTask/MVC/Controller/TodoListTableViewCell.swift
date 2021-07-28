//
//  TodoListTableViewCell.swift
//  TodoList
//
//  Created by Pragati NICB on 27/07/21.
//

import UIKit

class TodoListTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var LBL_TaskName: UILabel!
    @IBOutlet weak var BTN_Edit: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
