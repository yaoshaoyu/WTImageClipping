//
//  UIImage+WTClipping.h
//  WTImageClipping
//
//  Created by 吕成翘 on 2018/9/14.
//  Copyright © 2018年 Weitac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImage (WTClipping)

/**
 将图片裁切到指定尺寸
 
 @param scaleSize 尺寸
 @return 图像
 */
- (instancetype)wt_scaleImageWithScaleSize:(CGSize)scaleSize;

/**
 裁切圆角（带透明通道）
 
 @param radius 圆角半径
 @param corners 要裁切的角
 @param size 图像大小
 @return 裁切好的图片
 */
- (instancetype)wt_addCornerWithRadius:(CGFloat)radius
                               corners:(UIRectCorner)corners
                                  size:(CGSize)size;

/**
 裁切圆角（带背景色）
 
 @param radius 圆角半径
 @param corners 要裁切的角
 @param size 图像大小
 @param backgroundColor 背景色
 @return 裁切好的图片
 */
- (instancetype)wt_addCornerWithRadius:(CGFloat)radius
                               corners:(UIRectCorner)corners
                                  size:(CGSize)size
                       backgroundColor:(UIColor *)backgroundColor;

@end
