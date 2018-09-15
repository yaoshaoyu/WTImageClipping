//
//  UIImageView+WTClipping.h
//  WTImageClipping
//
//  Created by 吕成翘 on 2018/9/14.
//  Copyright © 2018年 Weitac. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIImageView (WTClipping)

/**
 为图像视图设置裁切矩形的图片
 
 @param urlString 图片地址
 @param targetSize 目标尺寸
 @param placeholderImageName 占位图
 */
- (void)wt_setRectangleImageWithURLString:(NSString *)urlString
                               targetSize:(CGSize)targetSize
                     placeholderImageName:(NSString *)placeholderImageName;

/**
 为图像视图设置裁切圆形图片
 
 @param urlString 图片地址
 @param placeholderImageName 占位图名称
 @param radius 圆角半径
 */
- (void)wt_roundedImageWithURLString:(NSString *)urlString
                placeholderImageName:(NSString *)placeholderImageName
                              radius:(CGFloat)radius;

/**
 为图像视图设置裁切圆角的图片
 
 @param urlString 图片地址
 @param placeholderImageName 占位图名称
 @param radius 圆角半径
 @param corners 裁切圆角
 @param size 图像大小
 */
- (void)wt_roundedImageWithURLString:(NSString *)urlString
                placeholderImageName:(NSString *)placeholderImageName
                              radius:(CGFloat)radius
                             corners:(UIRectCorner)corners
                                size:(CGSize)size;

@end
