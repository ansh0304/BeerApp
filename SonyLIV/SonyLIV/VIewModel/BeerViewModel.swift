//
//  BeerViewModel.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 17/09/21.
//

import UIKit

class BeerViewModel: NSObject {
    var pageFinished = false
    private var dataHandler : APIClient!
    var bindDataViewContollers : (()->Void)?
    var networkNotReachable:(()->Void)?
    var pageNumber = 1
    private (set) var beerMDO:[BeerMDO]! {
        didSet {
            bindDataViewContollers?()
        }
    }
    override init() {
        super.init()
        self.dataHandler = BeersData()
    }
    func fetchNewsData()  {
        if SLNetworkHelper.shared().connectivityAvailable() {
        self.dataHandler.pageNumber = self.pageNumber
        self.dataHandler.fetchDataModel { [weak self](res:(Result<[BeerMDO], APIError>)) in
            switch res {
            case .success(let result):
                guard let strongSelf = self else { return }
                if result.count == 0 {
                    strongSelf.pageFinished = true
                }
                if strongSelf.beerMDO == nil {
                    strongSelf.beerMDO = [BeerMDO]()
                }
                strongSelf.beerMDO += result
            case .failure(let error):
                print("the error \(error)")
            }
        }
         } else {
            print("the error Network")
            self.networkNotReachable?()
        }
    }
}
class BeersData:APIClient {
    var pageNumber: Int
    init() {
        self.pageNumber = 0
    }
    private var parametrs:[String:Any] {
        get {
            return ["pageNumber":pageNumber]
        }
    }
    func getParameters() -> [String : Any] {
        return parametrs
    }
    func getBaseUrlPath() -> String {
        let endPoint = "/beers?page=\(pageNumber)"
        return "\(Network.ENDPOINT.BASE_DATA_URL)\(Network.AVAIL_VER.V2)\(endPoint)"
    }
}
