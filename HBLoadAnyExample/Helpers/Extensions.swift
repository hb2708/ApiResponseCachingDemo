//
//  Extensions.swift
//  HBLoadAnyExample
//
//  Created by Harshal Bhavsar on 18/03/18.
//  Copyright © 2018 Harshal Bhavsar. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    public func setImageFrom(_ url: URL?, animated: Bool = false, completion:((_ image: UIImage?) -> Void)?) {
        self.image = UIImage(named: "placeHolder")
        
        HBRequestManager.performRequestOn(url, completion: { (data,error) in
            if let data = data,let image = UIImage(data: data) {
                UIView.transition(with: self,
                                  duration: 0.8,
                                  options: .transitionCrossDissolve,
                                  animations: { self.image = image },
                                  completion: nil)
                completion?(image)
            }else{
                completion?(nil)
            }
        })
    }
}

