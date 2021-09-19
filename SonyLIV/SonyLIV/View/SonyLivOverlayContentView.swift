//
//  SonyLivOverlayContentView.swift
//  SonyLIV
//
//  Created by Aravind Kumar on 19/09/21.
//

import UIKit

class SonyLivOverlayContentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var retryButton: UIButton!
    
    public var shown: Bool = false
    var onCloseBlock: (() -> Void)?
    var onRetryBlock: (() -> Void)?
    
    internal var message:String? {
        get { return messageLabel?.text }
        set { messageLabel.text = newValue }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
   fileprivate func initSubviews() {
    let nib = UINib(nibName: "SonyLivOverlayContentView", bundle: .main)
        nib.instantiate(withOwner: self, options: nil)
        contentView.frame = bounds
        addSubview(contentView)
        retryButton.layer.cornerRadius = 2
        retryButton.layer.borderWidth = 1
        retryButton.layer.borderColor = UIColor.lightGray.cgColor
        retryButton.isHidden = true
    }
    
    public func show(with status:String) {
        if shown { return } else { shown = true }
        self.message = status
    }
    
    /// Show the overlay view
    /// - Parameters:
    ///   - parent: Superview
    ///   - status: Message text
    public func show(parent:UIView, with status: String = "") {
        if shown { return } else { shown = true }
        if(!status.isEmpty) {
           self.message = status
        }
        parent.addSubview(self)
        self.stretchToEdges()
        bringSubviewToFront(self)
    }
    
    /// Hide overlay view
    public func hide() {
        shown = false
        self.removeFromSuperview()
    }
    
    @IBAction func retryButtonDidClicked(_ sender: UIButton) {
        onRetryBlock?()
    }
    
    @IBAction func closeButtonDidClicked(_ sender: UIButton) {
        onCloseBlock?()
    }
}
