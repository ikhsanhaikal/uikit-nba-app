//
//  TeamDetailViewController.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 21/08/2022.
//

import UIKit

class TeamDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var bannerView: UIView! {
        didSet {
            bannerView.backgroundColor = bgColorForBanner
        }
    }
    
    @IBOutlet weak var bannerLogo: UIImageView! {
        didSet {
            bannerLogo.image = teamLogo!
        }
    }
    
    @IBOutlet weak var bannerTitle: UILabel! {
        didSet {
            bannerTitle.text = titleForBanner ?? ""
            bannerTitle.textColor = fgColorForBanner ?? .white
        }
    }
    
    var bgColorForBanner: UIColor?
    var fgColorForBanner: UIColor?
    var titleForBanner: String?
    var teamLogo: UIImage?
    var teamCode: String?
    
//    var players = MockModel.mockPlayersByTeam()
    
    var players = [Player]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.rowHeight  = 100
        let nib = UINib(nibName: "PlayerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "playerCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationItem.largeTitleDisplayMode = .never

        guard var components = URLComponents(string: "https://api.sportsdata.io/") else { return }
        components.path = "/v3/nba/scores/json/Players/\(teamCode!)"
        components.queryItems = [URLQueryItem(name: "key", value: "3e269fe7f98a4667b4be281130325a9b")]
        
        guard let url = components.url else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data else {
                return
            }

            guard let roster = try? JSONDecoder().decode([Player].self, from: data) else {
                print("failed on decode")
                return
                
            }
            
            self.players = roster.filter( { $0.nbaDotComPlayerId != nil })
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
            
        }.resume()
    }
    
    func downloadPlayerImage(_ cell: PlayerTableViewCell, _ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                return
            }
            guard let image = UIImage(data: data) else {return}
            
            DispatchQueue.main.async {
                cell.loadingIndicator.stopAnimating()
                cell.loadingIndicator.isHidden = true
                cell.headShotImage.image = image
            }
            
        }.resume()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "playerDetail" {
            guard let vc = segue.destination as? PlayerDetailViewController else { return }
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            guard let nbaPhotoHeadshot = players[indexPath.row].nbaPhotoHeadshot else { return }
            guard let url = URL(string: nbaPhotoHeadshot) else {
                return
            }
            let player = players[indexPath.row]
            vc.photoUrl = url
            vc.bgColor  = bgColorForBanner
            vc.fullName = player.firstName + " " + player.lastName
            vc.teamLogo = bannerLogo.image
        }
        
    }
    
}

extension TeamDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell") as? PlayerTableViewCell else { return UITableViewCell() }
        let player = players[indexPath.row]
        cell.headShotImage.image = nil
        cell.loadingIndicator.startAnimating()
        cell.loadingIndicator.isHidden = false
        cell.loadingIndicator.style = .large
        cell.loadingIndicator.color = .white
        
        cell.playerName.text = "\(player.firstName) \(player.lastName)"
        cell.playerPos.text  = player.position
        
        if let jersey = player.jersey {
            cell.jerseyNo.text = "#\(jersey)"
        }
        
        cell.primaryColor = bgColorForBanner
        
        downloadPlayerImage(cell, player.photoUrl)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Roster"
    }
}

extension TeamDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("called at \(indexPath)")
        performSegue(withIdentifier: "playerDetail", sender: nil)
    }
    
}
