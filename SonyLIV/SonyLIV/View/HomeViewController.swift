//
//  ViewController.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 17/09/21.
//
//MMVM
import UIKit
class InfoCell:UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var infoLbl: UILabel!
    
}
class HomeViewController: UIViewController {
    var isLoading = false
    var beerViewModel :BeerViewModel?
    private var dataSource:BeerTbDataSource<InfoCell,BeerMDO>!
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.beerViewModel = BeerViewModel()
        self.getData()
    }
    func getData() {
        self.beerViewModel?.bindDataViewContollers = {
            self.updateUI()
        }
    }
    func updateUI() {
        if let items : [BeerMDO] = self.beerViewModel?.beerMDO {
            self.dataSource = BeerTbDataSource(identifier: "InfoCell", items: items, bindCell: { (cell, item ) in
                cell.infoLbl.text = item.name
                if let imageUrl = item.image_url, !imageUrl.isEmpty {
                    cell.imgView.loadImageUsingCacheWithURLString(imageUrl, placeHolder: nil)
                }
            })
            DispatchQueue.main.async {
                self.tbView.dataSource = self.dataSource
                self.tbView.delegate = self
                self.tbView.reloadData()
            }
        }
    }
}

extension HomeViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
      func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let viewModel = self.beerViewModel {
            if indexPath.row == viewModel.beerMDO.count - 5 && !isLoading && !viewModel.pageFinished {
                //you might decide to load sooner than -1 I guess...
              //load more into data here
                viewModel.pageNumber = viewModel.pageNumber +  1
                self.beerViewModel?.fetchNewsData()
                }
            
        }
    }

}
//Pagination--
//extension HomeViewController {
//
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//            let offsetY = scrollView.contentOffset.y
//            let contentHeight = scrollView.contentSize.height
//        if let viewModel = self.beerViewModel {
//        if (offsetY > contentHeight - scrollView.frame.size.height) && !isLoading && !viewModel.pageFinished {
//            viewModel.pageNumber = viewModel.pageNumber +  1
//            self.beerViewModel?.fetchNewsData()
//            }
//        }
//        }
//}
