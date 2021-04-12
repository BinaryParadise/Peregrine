//
//  WrapperFlowLayout.swift
//  BeSwifter_Example
//
//  Created by Rake Yang on 2021/3/5.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// 自动换行布局
class WrapperFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 获取系统计算好的Attributes
        let attributesToReturn = super.layoutAttributesForElements(in: rect)
        
        attributesToReturn?.forEach({ (attributes) in
            if attributes.representedElementKind == nil {
                attributes.frame = layoutAttributesForItem(at: attributes.indexPath)!.frame
            }
        })
        return attributesToReturn
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let currentItemAttributes = super.layoutAttributesForItem(at: indexPath) else { return nil }
        
        //设置内边距
        let sectionInset = self.sectionInset
        
        //如果是第一个item。则其frame.origin.x直接在内边距的左边。重置currentItemAttributes的frame 返回currentItemAttributes
        
        if (indexPath.item == 0) { // first item of section
            var frame = currentItemAttributes.frame;
            frame.origin.x = sectionInset.left; // first item of the section should always be left aligned
            currentItemAttributes.frame = frame;
            //返回currentItemAttributes
            return currentItemAttributes;
        }
        
        //如果不是第一个item。则需要获取前一个item的Attributes的frame属性
        
        let previousIndexPath = IndexPath(item: indexPath.item-1, section: indexPath.section)
        let previousFrame = layoutAttributesForItem(at: previousIndexPath)!.frame
        
        //前一个item与当前的item的相邻点
        let previousFrameRightPoint = previousFrame.origin.x + previousFrame.size.width + minimumInteritemSpacing;
        //当前的frame
        let currentFrame = currentItemAttributes.frame;
        //
        let strecthedCurrentFrame = CGRect(x:0, y:currentFrame.origin.y, width:collectionView?.width ?? 0, height:currentFrame.size.height);
        //判断两个结构体是否有交错.可以用CGRectIntersectsRect
        //如果两个结构体没有交错，则表明这个item与前一个item不在同一行上。则其frame.origin.x直接在内边距的左边。重置currentItemAttributes的frame 返回currentItemAttributes
        if (!previousFrame.intersects(strecthedCurrentFrame)) {
            // if current item is the first item on the line
            // the approach here is to take the current frame, left align it to the edge of the view
            // then stretch it the width of the collection view, if it intersects with the previous frame then that means it
            // is on the same line, otherwise it is on it's own new line
            var frame = currentItemAttributes.frame;
            frame.origin.x = sectionInset.left; // first item on the line should always be left aligned
            currentItemAttributes.frame = frame;
            //返回currentItemAttributes
            return currentItemAttributes;
        }
        //如果如果两个结构体有交错。将前一个item与当前的item的相邻点previousFrameRightPoint赋值给当前的item的frame.origin.x
        var frame = currentItemAttributes.frame;
        frame.origin.x = previousFrameRightPoint;
        currentItemAttributes.frame = frame;
        //返回currentItemAttributes
        return currentItemAttributes;
    }
}
