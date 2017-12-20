//
//  MagnifyingView.swift
//  MagnifyingView
//
//  Created by 胡金友 on 2017/12/20.
//

import UIKit

fileprivate extension UIView {
    
    /// 私有方法，获取view的宽度
    fileprivate var _width_:CGFloat {
        get { return self.frame.size.width }
    }
    
    /// 私有方法，获取view的高度
    fileprivate var _height_:CGFloat {
        get { return self.frame.size.height }
    }
}


///
/// 放大镜视图，可以根据设置放大选择区域的视图
/// 如果想要自己刷新，可以调用`setNeedsDisplay`方法来主动刷新放大镜视图
///




/// 放大视图的形状的枚举类型
///
/// - Round: 圆形
/// - Square: 方形，默认
/// - Custom: 用户自定义
public enum MagnifyingViewShap {
    case Round
    case Square
    case Custom
}

public class MagnifyingView: UIView {
    
    /// 需要放大的视图，必须设置的
    public var magnifyView:UIView!
    
    /// 缩放因子，默认2.0
    /// 注意不要太小，如果过小，会出现放大视图重叠的问题，需要关闭`exceptOutSide`属性
    public var scaleFactor:CGFloat = 2.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 放大视图的形状，默认是方形
    public var magnifyShap:MagnifyingViewShap = .Square {
        willSet {
            UIView.animate(withDuration: 0.25, animations: {
                if newValue == .Round {
                    self.layer.masksToBounds = true
                    self.layer.cornerRadius = min(self._width_, self._height_) / 2.0
                } else {
                    self.layer.cornerRadius = 0
                }
            }) { _ in
                if newValue == .Square {
                    self.layer.masksToBounds = false
                }
            }
        }
    }
    
    ///  滑动到边界的时候是否需要自动的矫正，默认为YES
    ///
    /// @discuss
    ///     YES - 当滑动到边界的时候，会自动的矫正，在放大视图上只会显示`magnifyView`所在区域的视图
    ///     NO  - 放大视图以用户手指选中的区域为中心去放大，当滑动边界的时候，会显示`magnifyView`以外的部分视图
    public var exceptOutSide:Bool = true {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 用户点击在放大视图上的位置
    public var touchLocation:CGPoint? {
        didSet {
            self.setNeedsDisplay()
        }
    }
    
    /// 放大视图绘制的方法，系统调用
    override public func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let location = self.touchLocation {
            var trsx = -1 * (location.x + self._width_ / self.scaleFactor / 2.0)
            var trsy = -1 * (location.y + self._height_ / self.scaleFactor / 2.0)
            
            // 对于超过边界的情况做处理，只展示放大视图内的内容
            if self.exceptOutSide {
                if location.x <= self._width_ / self.scaleFactor / 2.0 {
                    // 出了左边界
                    trsx = -1 * self._width_ / self.scaleFactor
                } else if location.x >= self.magnifyView._width_ - self._width_ / self.scaleFactor / 2.0 {
                    // 出了右边界
                    trsx = -1 * self.magnifyView._width_
                }
                
                if location.y <= self._height_ / self.scaleFactor / 2.0 {
                    // 出了上边界
                    trsy = -1 * self._height_ / self.scaleFactor
                } else if location.y >= self.magnifyView._height_ - self._height_ / self.scaleFactor / 2.0 {
                    // 出了下边界
                    trsy = -1 * self.magnifyView._height_
                }
            }
            
            /// 在获取到放大视图的上下文之前，先隐藏一下当前的视图，
            /// 避免出现重叠，可以看在网上看到不少的demo都会出现这样的问题
            self.isHidden = true
            
            if let context = UIGraphicsGetCurrentContext() {
                context.translateBy(x: self._width_, y: self._height_)
                context.scaleBy(x: self.scaleFactor, y: self.scaleFactor)
                context.translateBy(x: trsx, y: trsy)
                self.magnifyView.layer.render(in: context)
            }
            
            self.isHidden = false
        }
    }
}



