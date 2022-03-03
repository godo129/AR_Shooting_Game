//
//  LeaderBoardViewController.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/21.
//

import UIKit

class LeaderBoardViewController: UIViewController {
    
    private let tableView =  UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        pointListSort()
        
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidLayoutSubviews() {
        
        tableView.frame = self.view.bounds
    }
}

extension LeaderBoardViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedPointList.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Ranking"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let dateInfo = storedPointList[indexPath.row].Date
        
        cell.descripString.text = "\(indexPath.row+1)위 \(storedPointList[indexPath.row].nickName), 점수 : \(storedPointList[indexPath.row].Point)점, 날짜 : \(dateInfo.Year)-\(dateInfo.Month)-\(dateInfo.Date)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.bounds.height/12
    }
    
    
    
}
