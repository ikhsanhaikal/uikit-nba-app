//
//  PlayerDetailViewController.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 23/08/2022.
//

import UIKit

class PlayerDetailViewController: UIViewController {

    @IBOutlet weak var bannerBackground: UIView! {
        didSet {
            guard let bgColor = bgColor else { return  }
            bannerBackground.backgroundColor = bgColor
        }
    }
    
    @IBOutlet weak var playerPicture: UIImageView!
    @IBOutlet weak var playerName: UILabel! {
        didSet {
            playerName.textColor = .white
            playerName.text = fullName!
        }
    }
    
    @IBOutlet weak var teamWaterMark: UIImageView! {
        didSet {
            guard let teamLogo = teamLogo else { return  }
            teamWaterMark.image = teamLogo
        }
    }
    
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView! {
        didSet {
            loadingIndicator.style = .large
            loadingIndicator.color = .white
            loadingIndicator.startAnimating()
        }
    }
    
    var photoUrl: URL?
    var teamLogo: UIImage?
    var bgColor: UIColor?
    var fullName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.largeTitleDisplayMode = .never

        guard let photoUrl = photoUrl else {
            print("bad url")
            return
        }

        URLSession.shared.dataTask(with: photoUrl) { data, response, error in
            guard let data = data else {
                print("bad data")
                return
            }
            guard let image = UIImage(data: data) else {
                print("bad image")
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.playerPicture.image = image
                self?.loadingIndicator.stopAnimating()
                self?.loadingIndicator.isHidden = true
            }
            
        }.resume()
    }
}
