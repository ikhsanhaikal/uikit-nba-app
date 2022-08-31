//
//  PlayerTableViewCell.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 21/08/2022.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var headShotImage: UIImageView! {
        didSet {
            headShotImage.layer.cornerRadius = headShotImage.frame.width * 0.5
        }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.style = .large
            loadingIndicator.color = .white
            loadingIndicator.startAnimating()
        }
    }
    
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerPos: UILabel! {
        didSet {
            playerPos.numberOfLines = 0
            playerPos.clipsToBounds = true
            playerPos.textAlignment = .center
            playerPos.layer.cornerRadius = playerPos.frame.width * 0.2
            playerPos.layer.borderColor = UIColor.lightGray.cgColor
            playerPos.layer.borderWidth = 0.5
        }
    }
    
    
    
    @IBOutlet weak var jerseyNo: UILabel! {
        didSet {
            jerseyNo.textAlignment = .center
        }
    }
    
    var primaryColor: UIColor? {
        didSet {
            headShotImage.backgroundColor = primaryColor ?? UIColor(red: 0/255, green: 107/255, blue: 182/255, alpha: 1)
            jerseyNo.textColor = primaryColor ?? UIColor(red: 0/255, green: 107/255, blue: 182/255, alpha: 1)
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
