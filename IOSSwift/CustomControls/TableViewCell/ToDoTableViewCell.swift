//
//  ToDoTableViewCell.swift
//  IOSSwift
//
//  Created by CrestAdmin on 30/07/24.
//

import UIKit

class ToDoTableViewCell: UITableViewCell {
    var todo : ToDoModel?{
        didSet{
            self.filldata()
        }
    }
    @IBOutlet weak var todoTitleLabel: UILabel!
    @IBOutlet weak var todoImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.applyShadow(withColor: .lightGray)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func filldata(){
        self.categoryLabel.text = todo?.categoryName
        self.descriptionLabel.text = todo?.description
        self.todoTitleLabel.text = todo?.title
        switch todo?.categoryId{
        case 1:
            self.todoImageView.image = AppConstant.Image.common.img_personal
        default:
            self.todoImageView.image = AppConstant.Image.common.img_work
        }
    }

}
