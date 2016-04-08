//
//  BezierPathsView.swift
//  Dropit
//
//  Created by 董林森 on 16/4/6.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class BezierPathsView: UIView {

    private var beizerPaths = [String:UIBezierPath]()
    
    func setPath(path: UIBezierPath?, named name: String) {
        beizerPaths[name] = path
        setNeedsDisplay()
    }
    
    override func drawRect(rect: CGRect) {
        for(_, path) in beizerPaths {
            path.stroke()
        }
    }
    

}
