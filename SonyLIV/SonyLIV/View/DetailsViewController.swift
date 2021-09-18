//
//  DetailsViewController.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 18/09/21.
//

import UIKit

class DetailsViewController: UIViewController {
    var item:BeerMDO!
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Details"
        self.tbView.dataSource = self
        self.tbView.delegate = self
        // Do any additional setup after loading the view.
    }

}
extension DetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 240
        }
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
        let cell = tableView.dequeueReusableCell(withIdentifier:"ImageHeaderCell", for: indexPath) as! ImageHeaderCell
        if let imageUrl = item.image_url, !imageUrl.isEmpty {
            cell.imgView.loadImageUsingCacheWithURLString(imageUrl, placeHolder: nil)
        }
        cell.lblName.text = item.name
        return cell
        }else {
            let cell = tableView.dequeueReusableCell(withIdentifier:"InformationCell", for: indexPath) as! InformationCell
            if indexPath.row ==  1 {
            cell.fillData(typeName: "Description \n", text: item.description ?? "")
            }else  if indexPath.row ==  2 {
                cell.fillData(typeName: "Tagline \n", text: item.tagline ?? "")
            }
            else {
                cell.fillData(typeName: "First Brewed \n", text: item.first_brewed ?? "")
            }
            return cell
        }
    }

}
