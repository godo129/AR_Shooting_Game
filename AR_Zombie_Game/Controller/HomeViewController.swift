//
//  HomeViewController.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/18.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func PlayGameButtonTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ARView")
        present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func LeaderBoardButtonTapped(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaderBoardView")
        present(vc!, animated: true, completion: nil)
    }
    
}
