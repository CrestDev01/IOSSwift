//
//  FormTableViewCell.swift
//  IOSSwift
//
//  Created by CrestAdmin on 25/07/24.
//

import UIKit

class FormTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textfield: TextFieldRegular!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileButton: UIButton!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
