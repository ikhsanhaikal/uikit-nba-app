//
//  ViewController.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 20/08/2022.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    @IBOutlet weak var teamTableView: UITableView!
    
//    private let teams   = MockModel.mockTeams
//    private let onFetch = [URL:URLSessionDataTask]()
    private var teams = [Team]()
    let aboutMeViewController = UIHostingController(rootView: AboutMeView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamTableView.dataSource = self
        teamTableView.delegate = self
        let nib = UINib(nibName: "TeamTableViewCell", bundle: nil)
        teamTableView.register(nib, forCellReuseIdentifier: "teamCell")
        teamTableView.rowHeight = 80
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "All Teams"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "person.circle.fill"), style: .plain, target: self, action: #selector(segueToSwiftUIProfileView))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if teams.count > 0 {
            teamTableView.reloadData()
        } else {
            getAllTeamsFromApi()
        }
    }
    
    @objc func segueToSwiftUIProfileView() {
        aboutMeViewController.navigationItem.largeTitleDisplayMode = .never
        self.navigationController?.pushViewController(aboutMeViewController, animated: true)
    }
    
    func getAllTeamsFromApi() {
        guard var components = URLComponents(string: "https://api.sportsdata.io") else { return }
        components.path = "/v3/nba/scores/json/AllTeams"
        print(components.url!)
        
        guard let url = components.url else {
            print("bad url")
            return  }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.setValue("3e269fe7f98a4667b4be281130325a9b", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("error")
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else {
                print("bad data")
                return
            }
            guard var teams = try? JSONDecoder().decode([Team].self, from: data) else {
                print("failed on decode")
                return}
            teams.removeSubrange(teams.count - 2 ..< teams.count)
            self.teams = teams

            DispatchQueue.main.async { [weak self] in
                self?.teamTableView.reloadData()
            }
            
        }.resume()
    }
    
    
    func fixUrl(_ wrongUrl: String) -> URL? {
        guard var components = URLComponents(string: wrongUrl) else {
            return nil
        }
        var paths = components.path.split(separator: "/")
        paths.insert("thumb", at: 2)
        paths.append("480px-\(paths.last!.replacingOccurrences(of: "svg", with: "png"))")
        let result = paths.joined(separator: "/")
        components.path = "/\(result)"
        return components.url
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "teamDetail" {
            guard let vc = segue.destination as? TeamDetailViewController else { return  }
            guard let indexPath = teamTableView.indexPathForSelectedRow else  { return }
            let selectedTeam = teams[indexPath.row]
            guard let cell = teamTableView.cellForRow(at: indexPath) as? TeamTableViewCell else { return }
            vc.teamLogo = cell.teamLogo.image
            vc.teamCode = selectedTeam.key
            vc.titleForBanner = "\(selectedTeam.city) \(selectedTeam.name)"
            vc.bgColorForBanner = UIColor.hexStringToUIColor(hex: selectedTeam.primaryColor!)

        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "teamCell") as? TeamTableViewCell else {
            print("failed on reuse cell")
            return UITableViewCell()
        }

        if let logoUrl = teams[indexPath.row].wikipediaLogoUrl, let fixedUrl = fixUrl(logoUrl) {
            URLSession.shared.dataTask(with: fixedUrl) { data, response, error in
                guard let data = data else {
                    return
                }

                DispatchQueue.main.async { [weak self] in
                    guard let image = UIImage(data: data) else {
                        return
                    }
                    let cell  = self?.teamTableView.cellForRow(at: indexPath) as? TeamTableViewCell
                    cell?.teamLogo.image = image
                }
            }.resume()
        }
        
        cell.teamTitle.text = "\(teams[indexPath.row].city) \(teams[indexPath.row].name)"
        cell.conferenceTag.text = teams[indexPath.row].conference
        
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = self.tableView(tableView, cellForRowAt: indexPath) as? TeamTableViewCell else {
            return
        }
        performSegue(withIdentifier: "teamDetail", sender: cell)
    }
}

// untuk hex to rgb uicolor source dari (https://stackoverflow.com/questions/24263007/how-to-use-hex-color-values)
extension UIColor {
   static func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
