//
//  PullToRefreshConst.swift
//  PullToRefreshSwift
//
//  Created by Yuji Hato on 12/11/14.
//  Qiulang rewrites it to support pull down & push up
//
import UIKit

public class PullToRefreshView: UIView {
    enum PullToRefreshState {
        case pulling
        case triggerd
        case refreshing
        case stop
        case finish
    }
    
    // MARK: Variables
    let contentOffsetKeyPath = "contentOffset"
    let contentSizeKeyPath = "contentSize"
    var kvoContext = "PullToRefreshKVOContext"
    
    private var options: PullToRefreshOption
    private var backgroundView: UIView
    private var arrow: UIImageView
    private var indicator: UIActivityIndicatorView
    private var scrollViewBounces: Bool = false
    private var scrollViewInsets: UIEdgeInsets = UIEdgeInsets.zero
    private var refreshCompletion: (() -> Void)?
    private var pull: Bool = true
    
    private var positionY:CGFloat = 0 {
        didSet {
            if self.positionY == oldValue {
                return
            }
            var frame = self.frame
            frame.origin.y = positionY
            self.frame = frame
        }
    }
    
    var state: PullToRefreshState = PullToRefreshState.pulling {
        didSet {
            if self.state == oldValue {
                return
            }
            switch self.state {
            case .stop:
                stopAnimating()
            case .finish:
                var duration = PullToRefreshConst.animationDuration
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.stopAnimating()
                }
                duration = duration * 2
                DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                    self.removeFromSuperview()
                }
            case .refreshing:
                startAnimating()
            case .pulling: //starting point
                arrowRotationBack()
            case .triggerd:
                arrowRotation()
            }
        }
    }
    
    // MARK: UIView
    public override convenience init(frame: CGRect) {
        self.init(options: PullToRefreshOption(),frame:frame, refreshCompletion:nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public init(options: PullToRefreshOption, frame: CGRect, refreshCompletion :(() -> Void)?, down:Bool=true) {
        self.options = options
        self.refreshCompletion = refreshCompletion

        self.backgroundView = UIView(frame: CGRect(origin: CGPoint.zero, size: frame.size))
        self.backgroundView.backgroundColor = self.options.backgroundColor
        self.backgroundView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        
        self.arrow = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        self.arrow.autoresizingMask = [.flexibleLeftMargin, .flexibleRightMargin]
        
        self.arrow.image = UIImage(named: PullToRefreshConst.imageName, in: Bundle(for: type(of: self)), compatibleWith: nil)
        
        
        self.indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.indicator.bounds = self.arrow.bounds
        self.indicator.autoresizingMask = self.arrow.autoresizingMask
        self.indicator.hidesWhenStopped = true
        self.indicator.color = options.indicatorColor
        self.pull = down
        
        super.init(frame: frame)
        self.addSubview(indicator)
        self.addSubview(backgroundView)
        self.addSubview(arrow)
        self.autoresizingMask = .flexibleWidth
    }
   
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.arrow.center = CGPoint(x: self.frame.size.width / 2, y: self.frame.size.height / 2)
        self.arrow.frame = arrow.frame.offsetBy(dx: 0, dy: 0)
        self.indicator.center = self.arrow.center
    }
    
    public override func willMove(toSuperview superView: UIView!) {
        //superview NOT superView, DO NEED to call the following method
        //superview dealloc will call into this when my own dealloc run later!!
        self.removeRegister()
        guard let scrollView = superView as? UIScrollView else {
            return
        }
        scrollView.addObserver(self, forKeyPath: contentOffsetKeyPath, options: .initial, context: &kvoContext)
        if !pull {
            scrollView.addObserver(self, forKeyPath: contentSizeKeyPath, options: .initial, context: &kvoContext)
        }
    }
    
    private func removeRegister() {
        if let scrollView = superview as? UIScrollView {
            scrollView.removeObserver(self, forKeyPath: contentOffsetKeyPath, context: &kvoContext)
            if !pull {
                scrollView.removeObserver(self, forKeyPath: contentSizeKeyPath, context: &kvoContext)
            }
        }
    }
    
    deinit {
        self.removeRegister()
    }
    
    // MARK: KVO
    public override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let scrollView = object as? UIScrollView else {
            return
        }
        if keyPath == contentSizeKeyPath {
            self.positionY = scrollView.contentSize.height
            return
        }
        
        if !(context == &kvoContext && keyPath == contentOffsetKeyPath) {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
            return
        }
        
        // Pulling State Check
        let offsetY = scrollView.contentOffset.y
        
        // Alpha set
        if PullToRefreshConst.alpha {
            var alpha = fabs(offsetY) / (self.frame.size.height + 40)
            if alpha > 0.8 {
                alpha = 0.8
            }
            self.arrow.alpha = alpha
        }
        
        if offsetY <= 0 {
            if !self.pull {
                return
            }
            if offsetY < -self.frame.size.height {
                // pulling or refreshing
                if scrollView.isDragging == false && self.state != .refreshing { //release the finger
                    self.state = .refreshing //startAnimating
                } else if self.state != .refreshing { //reach the threshold
                    self.state = .triggerd
                }
            } else if self.state == .triggerd {
                //starting point, start from pulling
                self.state = .pulling
            }
            return //return for pull down
        }
        
        //push up
        let upHeight = offsetY + scrollView.frame.size.height - scrollView.contentSize.height
        if upHeight > 0 {
            // pulling or refreshing
            if self.pull {
                return
            }
            if upHeight > self.frame.size.height {
                // pulling or refreshing
                if scrollView.isDragging == false && self.state != .refreshing { //release the finger
                    self.state = .refreshing //startAnimating
                } else if self.state != .refreshing { //reach the threshold
                    self.state = .triggerd
                }
            } else if self.state == .triggerd  {
                //starting point, start from pulling
                self.state = .pulling
            }
        }
    }
    
    // MARK: private
    
    private func startAnimating() {
        self.indicator.startAnimating()
        self.arrow.isHidden = true
        guard let scrollView = superview as? UIScrollView else {
            return
        }
        scrollViewBounces = scrollView.bounces
        scrollViewInsets = scrollView.contentInset
        
        var insets = scrollView.contentInset
        if pull {
            insets.top += self.frame.size.height
        } else {
            insets.bottom += self.frame.size.height
        }
        scrollView.bounces = false
        UIView.animate(withDuration: PullToRefreshConst.animationDuration,
                                   delay: 0,
                                   options:[],
                                   animations: {
            scrollView.contentInset = insets
            },
                                   completion: { _ in
                if self.options.autoStopTime != 0 {
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.options.autoStopTime) {
                        self.state = .stop
                    }
                }
                                    self.refreshCompletion?()
        })
    }
    
    private func stopAnimating() {
        self.indicator.stopAnimating()
        self.arrow.isHidden = false
        guard let scrollView = superview as? UIScrollView else {
            return
        }
        scrollView.bounces = self.scrollViewBounces
        let duration = PullToRefreshConst.animationDuration
        UIView.animate(withDuration: duration,
                                   animations: {
                                    scrollView.contentInset = self.scrollViewInsets
                                    self.arrow.transform = CGAffineTransform.identity
                                    }
        ) { _ in
            self.state = .pulling
        }
    }
    
    private func arrowRotation() {
        UIView.animate(withDuration: 0.2, delay: 0, options:[], animations: {
            // -0.0000001 for the rotation direction control
            self.arrow.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI-0.0000001))
        }, completion:nil)
    }
    
    private func arrowRotationBack() {
        UIView.animate(withDuration: 0.2) {
            self.arrow.transform = CGAffineTransform.identity
        }
    }
}
