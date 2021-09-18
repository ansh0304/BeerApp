//
//  BeerTbDataSource.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 18/09/21.
//

import UIKit

class BeerTbDataSource<CELL:UITableViewCell,T>: NSObject,UITableViewDataSource {
    
    private var identifier : String!
    private var items : [T]!
    var bindCell:((CELL,T)->()) = {_,_ in
        
    }
    init(identifier:String,items:[T],bindCell:@escaping ((CELL,T)->())) {
        self.identifier = identifier
        self.items = items
        self.bindCell = bindCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.identifier, for: indexPath) as! CELL
        self.bindCell(cell,self.items[indexPath.row])
        return cell
    }
    
}
