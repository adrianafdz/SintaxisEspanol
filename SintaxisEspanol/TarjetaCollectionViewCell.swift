//
//  TarjetaCollectionViewCell.swift
//  SintaxisEspanol
//
//  Created by user188711 on 5/4/21.
//

import UIKit

class TarjetaCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var lbParte: UILabel!
    
    
    var maxWidth: CGFloat? = nil {
        didSet {
            guard let maxWidth = maxWidth else {
                return
            }
            maxWidthConstraint.isActive = true
            maxWidthConstraint.constant = maxWidth
        }
    }
 
    
    override func awakeFromNib() {
         super.awakeFromNib()
         
         contentView.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             contentView.leftAnchor.constraint(equalTo: leftAnchor),
             contentView.rightAnchor.constraint(equalTo: rightAnchor),
             contentView.topAnchor.constraint(equalTo: topAnchor),
             contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
         ])
     }
    
    
    @IBOutlet private var maxWidthConstraint: NSLayoutConstraint! {
         didSet {
             maxWidthConstraint.isActive = false
         }
     }
 
    
    func configure(with title: String) {
        lbParte.text = title
    }
    
}
