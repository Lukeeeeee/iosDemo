//
//  DropitViewController.swift
//  Dropit
//
//  Created by 董林森 on 16/4/1.
//  Copyright © 2016年 Luke. All rights reserved.
//

import UIKit

class DropitViewController: UIViewController, UIDynamicAnimatorDelegate{
    
    @IBOutlet weak var gameView: BezierPathsView!
    
    @IBAction func grabDrop(sender: UIPanGestureRecognizer) {
        
        let gesturePoint = sender.locationInView(gameView)
        
        switch sender.state {
        case .Began:
            if let viewToAttachTo = lastDroppedView {
                attachment = UIAttachmentBehavior(item: viewToAttachTo, attachedToAnchor: gesturePoint)
                lastDroppedView = nil
            }
        case .Changed:
            attachment?.anchorPoint = gesturePoint
        case .Ended:
            attachment = nil
        default:
            break
        }
    }
    var dropsPerRow = 10
    
    var dropSize: CGSize {
        let size = gameView.bounds.size.width /  CGFloat(dropsPerRow)
        return CGSize(width: size, height: size)
    }
    
    lazy var animator: UIDynamicAnimator = {
        let lazilyCreatedDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        lazilyCreatedDynamicAnimator.delegate = self
        return lazilyCreatedDynamicAnimator
    }()
    
    func dynamicAnimatorDidPause(animator: UIDynamicAnimator) {
        removeCompletedRow()
    }
    
    var dropitBehavior = DropitBehavior()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(dropitBehavior)
    }
    
    @IBAction func drop(sender: UITapGestureRecognizer) {
        drop()
    }
    
    func drop() {
        var frame = CGRect(origin: CGPointZero, size: dropSize)
        frame.origin.x = CGFloat.random(dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.random
        
        lastDroppedView = dropView
        
        gameView.addSubview(dropView)
        dropitBehavior.addDrop(dropView)
        
    }
    
    func removeCompletedRow() {
        var dropsToRemove = [UIView]()
        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
        
        repeat {
            dropFrame.origin.y -= dropSize.height
            dropFrame.origin.x = 0
            var dropsFound = [UIView]()
            var rowIsComplete = true
            for _ in 0 ..< dropsPerRow {
                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), withEvent: nil) {
                    if hitView.superview == gameView {
                        dropsFound.append(hitView)
                    } else {
                        rowIsComplete = false
                    }
                }
                dropFrame.origin.x += dropSize.width
            }
            if rowIsComplete {
                dropsToRemove += dropsFound
            }
        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
        
        for drop in dropsToRemove {
            dropitBehavior.removeDrop(drop)
        }
    }
    
    struct  PathNames {
        static let MiddleBarrier = "Middle Barrier"
        static let Attachment = "Attachment"
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let barrierSize = dropSize
        let barrierOrigin = CGPoint(x: gameView.bounds.midX-barrierSize.width/2, y: gameView.bounds.midY-barrierSize.height/2)
        let path = UIBezierPath(ovalInRect: CGRect(origin: barrierOrigin, size: barrierSize))
        dropitBehavior.addBarrier(path, named: PathNames.MiddleBarrier)
        gameView.setPath(path, named: PathNames.MiddleBarrier)
    }
    
    var lastDroppedView: UIView?
    
    var attachment: UIAttachmentBehavior? {
        willSet {
            if attachment != nil {
                animator.removeBehavior(attachment!)
                gameView.setPath(nil, named: PathNames.Attachment)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
                attachment?.action = { [unowned self] in
                    if let attachmentView = self.attachment?.items.first as? UIView {
                        let path = UIBezierPath()
                        path.moveToPoint(self.attachment!.anchorPoint)
                        path.addLineToPoint(attachmentView.center)
                        self.gameView.setPath(path, named: PathNames.Attachment)
                    }
                }
            }
        }
    }

}

private extension CGFloat {
    static func random(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

private extension UIColor {
    class var random: UIColor {
        switch arc4random()%5 {
        case 0: return UIColor.blackColor()
        case 1: return UIColor.redColor()
        case 2: return UIColor.greenColor()
        case 4: return UIColor.yellowColor()
        case 5: return UIColor.blueColor()
        default: return UIColor.brownColor()
        }
    }
}


