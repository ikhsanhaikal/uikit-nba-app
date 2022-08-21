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
            conferenceTag.sizeToFit()
            conferenceTag.numberOfLines = 0
            conferenceTag.textAlignment = .center
            conferenceTag.backgroundColor = .black
            conferenceTag.textColor = .white
            conferenceTag.clipsToBounds = true
            conferenceTag.layer.cornerRadius = conferenceTag.frame.width * 0.2
        }
    }
    @IBOutlet weak var divisionTag: UILabel!  {
        didSet {
            divisionTag.sizeToFit()
            divisionTag.textAlignment = .center
            divisionTag.numberOfLines = 0
            divisionTag.backgroundColor = .red
            divisionTag.textColor = .white
            divisionTag.clipsToBounds = true
            divisionTag.layer.cornerRadius = divisionTag.frame.width * 0.2
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
