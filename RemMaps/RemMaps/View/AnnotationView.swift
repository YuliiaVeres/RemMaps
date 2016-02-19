//
//  AnnotationView.swift
//  RemMaps
//
//  Created by Yuliia Veresklia on 2/19/16.
//  Copyright © 2016 Yuliia Veresklia. All rights reserved.
//

import UIKit
import MapKit

final class AnnotationView: UIView {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subtitleLabel: UILabel!
    
    var place: Place? {
        
        didSet {
            setup()
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        transform = CGAffineTransformConcat(CGAffineTransformMakeScale(0.0, 0.0), CGAffineTransformMakeTranslation(0.0, 50.0))
    }
}

private extension AnnotationView {
    
    func setup() {
        titleLabel.text = place?.title
        subtitleLabel.text = place?.subtitle
        
        animate()
    }
    
    func animate() {
        
        let duration = Configs.sharedInstance.CalloutAnimationDuration
        
        UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1.0, options: .CurveEaseInOut, animations: { _ in
            
            self.transform = CGAffineTransformIdentity
            }, completion: nil)
    }
}
