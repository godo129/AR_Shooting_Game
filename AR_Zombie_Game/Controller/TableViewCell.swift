//
//  TableViewCell.swift
//  AR_Zombie_Game
//
//  Created by hong on 2022/02/21.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    lazy var descripString: UILabel = {
        let descripString = UILabel()
        descripString.textColor = .black
        descripString.font = .systemFont(ofSize: 20, weight: .bold)
        return descripString
    }()

    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func layoutSubviews() {
        descripString.frame = contentView.bounds
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(descripString)

    }
 

    required init?(coder aDecoder: NSCoder) {

        fatalError("init(coder:) has not been implemented")

    }

}
