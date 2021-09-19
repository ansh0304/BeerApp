//
//  ViewController.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 17/09/21.
//
//MMVM
import UIKit

class HomeViewController: UIViewController {
    var isLoading = false
    var beerViewModel :BeerViewModel?
    private var dataSource:BeerTbDataSource<InfoCell,BeerMDO>!
   
    lazy var errorView: SonyLivOverlayContentView = {
        let view = SonyLivOverlayContentView(frame: CGRect.zero)
        return view
    }()
    
    @IBOutlet weak var tbView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.beerViewModel = BeerViewModel()
        self.getData()
    }
    func getData() {
        self.beerViewModel?.networkNotReachable = {
            self.updateNetworkPopUP()
        }
        self.beerViewModel?.fetchNewsData()
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
                self.errorView.hide()
                self.tbView.dataSource = self.dataSource
                self.tbView.delegate = self
                self.tbView.reloadData()
            }
        }
    }
    func updateNetworkPopUP() {
        if self.errorView.shown {
            return
        }
        self.errorView.show(parent: self.view, with: "Network issue, please try again")
        self.errorView.retryButton.setTitle("Relaod", for: .normal)
        self.errorView.retryButton.isHidden = false
        self.errorView.onRetryBlock = {
            self.beerViewModel?.fetchNewsData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let viewModel = self.beerViewModel, viewModel.beerMDO.count > indexPath.row {
            let detailsViewController : DetailsViewController  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            detailsViewController.item = viewModel.beerMDO[indexPath.row]
            self.show(detailsViewController, sender: self)
        }
    }
}

