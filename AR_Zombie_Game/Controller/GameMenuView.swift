//
//  test.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/28.
//

import UIKit

class GameMenuView: UIView {

    private let restartButton = GameMenuButton(color: UIColor.systemBlue, text: "Restart")
    private let savePointButton = GameMenuButton(color: UIColor.systemRed, text: "Save Point")
    
    let saveView = GamePointSaveView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(restartButton)
        self.addSubview(savePointButton)
        
        
        savePointButton.addTarget(self, action: #selector(savePointButtonTapped), for: .touchUpInside)
        restartButton.addTarget(self, action: #selector(restartButtonTapped), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(removeView), name: gamePointSaveViewExit, object: nil)
        
    }
    
    private func exit() {
        self.removeFromSuperview()
    }
    
    @objc private func removeView() {
        exit()
    }
    
    private func 서브뷰초기화() {
        restartButton.removeFromSuperview()
        savePointButton.removeFromSuperview()
    }
    
    private func addSaveView() {
        서브뷰초기화()
        self.addSubview(saveView)
    }
    
    @objc private func savePointButtonTapped() {
        addSaveView()
    }
    
    @objc private func restartButtonTapped() {
        exit()
        NotificationCenter.default.post(name: gameMenuViewExit, object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        restartButton.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        restartButton.center = self.center
        
        savePointButton.frame = CGRect(x: self.restartButton.frame.origin.x , y: self.restartButton.frame.origin.y+200, width: 200, height: 100)
        
        saveView.frame = self.bounds
    }
}
