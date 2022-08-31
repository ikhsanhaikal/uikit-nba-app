//
//  TeamTableViewCell.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 21/08/2022.
//

import UIKit

class TeamTableViewCell: UITableViewCell {

    @IBOutlet weak var teamLogo: UIImageView!
    @IBOutlet weak var teamTitle: UILabel!
    
    @IBOutlet weak var conferenceTag: UILabel! {
        didSet {
            conferenceTag.textAlignment = .center
            conferenceTag.clipsToBounds = true
            conferenceTag.layer.cornerRadius = conferenceTag.frame.width * 0.1
            conferenceTag.layer.borderColor = UIColor.lightGray.cgColor
            conferenceTag.layer.borderWidth = 0.5
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
