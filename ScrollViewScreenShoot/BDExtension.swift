//
//  BDExtensionn.swift
//  beauty_day
//
//  Created by 骚姜的HHBoy on 2018/6/1.
//  Copyright © 2018年 Xuyu Jiang. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    //scrollView   长截图
    class func bd_scrollViewScreenshots(scrollView:UIScrollView) {
        var scrollviewFrame:CGRect
        var index:Int
        var page:Int
        
        page = Int(scrollView.contentSize.height / scrollView.frame.size.height)
        if (scrollView.frame.size.height * CGFloat(page)) < scrollView.contentSize.height {
            page = page + 1
        }
        index = 0
        scrollviewFrame = scrollView.frame
        UIGraphicsBeginImageContextWithOptions(scrollView.contentSize, true, UIScreen.main.scale)
        //由于每次wkwebView内存优化的原因，每次加载的web页面，只会预先加载一屏多一点的html，所以无法像UIWebView那样直接通过获取全文大小使用renderInContext方法直接保存为长途，所以使用滚动+延时+绘制的方式将web页面保存为长图
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            bd_getScreenshots(scrollView: scrollView, page: page, index: index, scrollFrame: scrollviewFrame)
        }
    }
}

func bd_getScreenshots(scrollView:UIScrollView, page:Int, index:Int, scrollFrame:CGRect) {
    print("index ---- %d",index)
    if index + 1 == page {
        //最后一页执行，解决最后一屏内容可能会出现压缩及内容重合的情况
        let lastPageHeight = scrollView.contentSize.height - CGFloat(index) * scrollFrame.size.height
        let hierarchyInRect:CGRect = CGRect(x: 0, y: CGFloat(index) * scrollFrame.size.height, width: scrollView.frame.size.width, height: lastPageHeight)
        if scrollView.drawHierarchy(in: hierarchyInRect, afterScreenUpdates: true) {
            if index + 1 == page {
                let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
                UIGraphicsEndImageContext()
                scrollView.superview?.frame = scrollFrame
                scrollView.frame = scrollFrame
                scrollView.scrollRectToVisible(CGRect(x: 0, y: 0, width: scrollView.frame.size.width, height: scrollFrame.size.height), animated: true)
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            }
        }
    } else {
        if scrollView.drawHierarchy(in: CGRect(x: 0, y: CGFloat(index) * scrollView.frame.size.height, width: scrollView.frame.size.width, height: scrollView.frame.size.height), afterScreenUpdates: true) {
            if (index + 2) == page {
                let lastPageHeight = scrollView.contentSize.height - CGFloat(index + 1) * scrollView.frame.size.height
                let changeFrame:CGRect = CGRect(x: scrollView.frame.origin.x, y: scrollView.frame.origin.y, width: scrollView.frame.size.width, height: lastPageHeight)
                scrollView.superview?.frame = changeFrame
                scrollView.frame = changeFrame
                scrollView.scrollRectToVisible(CGRect(x: 0, y: CGFloat(index + 1) * scrollFrame.size.height, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: false)
            } else {
                scrollView.scrollRectToVisible(CGRect(x: 0, y: CGFloat(index + 1) * scrollView.frame.size.height, width: scrollView.frame.size.width, height: scrollView.frame.size.height), animated: false)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1)  {
            print("asyncAfter index ---- %d",index)
            bd_getScreenshots(scrollView: scrollView, page: page, index: index + 1, scrollFrame: scrollFrame)
        }
    }
}

