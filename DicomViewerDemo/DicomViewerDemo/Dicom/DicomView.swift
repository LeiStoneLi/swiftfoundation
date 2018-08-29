//
//  DicomView.swift
//  DicomViewerDemo
//
//  Created by SrearAlex on 2018/8/20.
//  Copyright © 2018年 SrearAlex. All rights reserved.
//

import UIKit
import SnapKit
class DicomView: UIView {
    // MARK:- 属性
    var currentScale = 1.0
    // MARK: 模型
    
    // MARK: 懒加载
    lazy var dicomPlayView: DicomPlayView = DicomPlayView()
    fileprivate lazy var scrollView : UIScrollView = UIScrollView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 初始化
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
        super.init(coder: aDecoder)
        // 初始化
        setup()
    }
}

// MARK:- 初始化
extension DicomView {
    // MARK:- 初始
    fileprivate func setup() {
        // 添加控件
        self.addSubview(scrollView)
        scrollView.addSubview(dicomPlayView)
        scrollView.delegate = self
        
        // 设置scrollView
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(self)
        }
//        scrollView.frame = self.bounds
        scrollView.zoomScale = 1.0
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 3
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        
        // 设置imageView
        dicomPlayView.snp.makeConstraints { (make) in
            make.top.bottom.leading.trailing.centerX.centerY.equalTo(scrollView)
        }
//        dicomPlayView.frame = scrollView.bounds
//        dicomPlayView.contentMode = .scaleAspectFit
        dicomPlayView.isUserInteractionEnabled = true
        dicomPlayView.isMultipleTouchEnabled = true
        
        // 添加手势
        addGestrue()
    }
    
    // MARK: 添加手势
    fileprivate func addGestrue() {
        // 点击
//        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_ :)))
        // 双击
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap(_ :)))
        // 二指
        let twoFingerTap = UITapGestureRecognizer(target: self, action: #selector(handleTwoFingerTap(_ :)))
        
//        singleTap.numberOfTapsRequired = 1
//        singleTap.numberOfTouchesRequired = 1
        doubleTap.numberOfTapsRequired = 2  // 需要点两下
        twoFingerTap.numberOfTouchesRequired = 2 // 需要两个手指touch
        
        // 添加手势
//        dicomPlayView.addGestureRecognizer(singleTap)
        dicomPlayView.addGestureRecognizer(doubleTap)
        dicomPlayView.addGestureRecognizer(twoFingerTap)
//        singleTap.require(toFail: doubleTap) // 如果双击了，则不响应单击事件
        
        scrollView.setZoomScale(1, animated: false)
    }
}

// MARK:- 手势事件
extension DicomView {
    // MARK: 单击
    /*
    @objc fileprivate func handleSingleTap(_ gesture: UITapGestureRecognizer) {
        print("单击")
        if gesture.numberOfTapsRequired == 1 {
            delegate?.imageViewClick()
        }
    }
    */
    // MARK: 双击
    @objc fileprivate func handleDoubleTap(_ gesture: UITapGestureRecognizer) {
        print("双击")
        if gesture.numberOfTapsRequired == 2 {
            var newScale: CGFloat = 1.0
            if scrollView.zoomScale <= 1.0 {
                newScale = scrollView.zoomScale * 2.0
            } else {
                newScale = scrollView.zoomScale / 2.0
            }
            let zoomRect = self.zoomRectForScale(newScale, center: gesture.location(in: gesture.view))
            scrollView.zoom(to: zoomRect, animated: true)
        }
    }
    // MARK: 两指
    @objc fileprivate func handleTwoFingerTap(_ gesture: UITapGestureRecognizer) {
        print("两指操作")
        let newScale = scrollView.zoomScale * 0.5
        let zoomRect = self.zoomRectForScale(newScale, center: gesture.location(in: gesture.view))
        scrollView.zoom(to: zoomRect, animated: true)
    }
}

// MARK:- UIScrollViewDelegate
extension DicomView : UIScrollViewDelegate {
    // 返回要缩放的图片
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.dicomPlayView
    }
    
    // 重新确定缩放完后的缩放倍数
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        scrollView.setZoomScale(scale + 0.01, animated: false)
        scrollView.setZoomScale(scale, animated: false)
    }
}
// MARK:- 缩放大小获取方法
extension DicomView {
    func zoomRectForScale(_ scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect: CGRect = CGRect.zero
        // 大小
        zoomRect.size.height = scrollView.frame.size.height / scale
        zoomRect.size.width = scrollView.frame.size.width / scale
        // 原点
        zoomRect.origin.x = center.x - zoomRect.size.width / 2
        zoomRect.origin.y = center.y - zoomRect.size.height / 2
        return zoomRect
    }
}
