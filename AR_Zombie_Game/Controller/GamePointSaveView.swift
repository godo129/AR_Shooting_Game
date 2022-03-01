//
//  GamePointSaveView.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/03/01.
//

import UIKit

class GamePointSaveView: UIView {
    
    private var today: DateToString!
    
    
    private let nickNameField = NickNameTextField()
    let gamePointLabel = GamePointLabel()
    private let saveButton = GamePointSaveButton(backColor: UIColor.red, text: "Save", textColor: UIColor.white)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        getDateData()
        
        self.addSubview(nickNameField)
        self.addSubview(gamePointLabel)
        self.addSubview(saveButton)

    }
    
    private func getDateData() {
        
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd"
        let formattedDate = format.string(from: date)
        
        let dateList = formattedDate.components(separatedBy: "-")
        let Year = dateList[0]
        let Month = dateList[1]
        let Date = dateList[2]
        today = DateToString(Year: Year, Month: Month, Date: Date)

    }
    
    @objc private func saveButtonTapped() {
        
        guard let nickName = nickNameField.text else {return}
        
        let infomation = GamePointDetail(nickName: nickName, Date: today, Point: Int(gamePointLabel.text!)!)
        
        storedPointList.append(infomation)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        nickNameField.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        nickNameField.center = self.center
        gamePointLabel.frame = CGRect(x: nickNameField.frame.origin.x, y: nickNameField.frame.origin.y+60, width: 100, height: 50)
        saveButton.frame = CGRect(x: gamePointLabel.frame.origin.x+100, y: gamePointLabel.frame.origin.y, width: 50, height: 50)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
