//
//  TableViewCells.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 18/09/21.
//

import Foundation
import UIKit

class InfoCell:UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    
}

class ImageHeaderCell:UITableViewCell {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
}
class InformationCell:UITableViewCell {
    @IBOutlet weak var infoLbl: UILabel!
    
    func fillData(typeName:String, text:String) {
        let attrString = NSMutableAttributedString(string: typeName,
                                                   attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)])
        attrString.append(NSMutableAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14)]))
        attrString.append(NSMutableAttributedString(string: text,
                                                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.black.withAlphaComponent(0.75)]))
        
        self.infoLbl.attributedText = attrString
    }
}
