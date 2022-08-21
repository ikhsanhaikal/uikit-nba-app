//
//  ViewController.swift
//  uikit-nba-app
//
//  Created by Ikhsan on 20/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var teamTableView: UITableView!
    
    private let teams   = MockModel.mockData
    private let onFetch = [URL:URLSessionDataTask]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        teamTableView.dataSource = self
        teamTableView.prefetchDataSource = self
        let nib = UINib(nibName: "TeamTableViewCell", bundle: nil)
        teamTableView.register(nib, forCellReuseIdentifier: "teamCell")
        teamTableView.rowHeight = 80
        
    }
    
    func fixUrl(_ badUrl: String) -> URL? {
        guard var components = URLComponents(string: badUrl) else {
            return nil
        }
        var paths = components.path.split(separator: "/")
        paths.insert("thumb", at: 2)
        paths.append("480px-\(paths.last!.replacingOccurrences(of: "svg", with: "png"))")
        let result = paths.joined(separator: "/")
        components.path = "/\(result)"
        return components.url
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

        if let fixedUrl = fixUrl(teams[indexPath.row].wikipediaLogoUrl) {
            URLSession.shared.dataTask(with: fixedUrl) { data, response, error in
                guard let data = data else {
                    return
                }

                guard let response = response as? HTTPURLResponse else {
                    return
                }

                print(response.statusCode)

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
        cell.divisionTag.text = teams[indexPath.row].division
        
        return cell
    }
}

extension ViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
//        for indexPath in indexPaths {
//            if let url = URL(string: teams[indexPath.row].wikipediaLogoUrl) {
//                URLSession.shared.dataTask(with: url) { data, response, error in
//                    guard let data = data else {
//                        return
//                    }
//
//                    guard let response = response as? HTTPURLResponse else {
//                        return
//                    }
//
//                    print(response.statusCode)
//
//                    DispatchQueue.main.async { [weak self] in
//                        let image = UIImage(data: data)
//                        let cell  = self?.teamTableView.cellForRow(at: indexPath) as? TeamTableViewCell
//                        cell?.teamLogo.image = image
//                    }
//                }.resume()
//            }
//        }
    }
}
