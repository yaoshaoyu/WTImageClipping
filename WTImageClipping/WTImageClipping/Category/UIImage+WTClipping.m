//
//  UIImage+WTClipping.m
//  WTImageClipping
//
//  Created by 吕成翘 on 2018/9/14.
//  Copyright © 2018年 Weitac. All rights reserved.
//

#import "UIImage+WTClipping.h"


@implementation UIImage (WTClipping)

- (instancetype)wt_scaleImageWithScaleSize:(CGSize)scaleSize {
    
    // 图片大小
    CGSize imageSize = self.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;

    // 目标大小
    CGFloat targetWidth = scaleSize.width;
    CGFloat targetHeight = scaleSize.height;
    CGRect targetRect = CGRectMake(0, 0, targetWidth, targetWidth);

    // 按长宽比缩放后的图片的位置和大小
    CGFloat resultX = 0;
    CGFloat resultY = 0;
    CGFloat resultWidth;
    CGFloat resultHeight;

    if (imageWidth > imageHeight) {
        resultWidth = ceilf(targetHeight / imageHeight * imageWidth);
        resultHeight = ceilf(targetHeight);
        resultX = -(resultWidth - targetWidth) * 0.5;
    } else {
        resultWidth = ceilf(targetWidth);
        resultHeight = ceilf(targetWidth / imageWidth * imageHeight);
        resultY = -(resultHeight - targetHeight) * 0.5;
    }

    CGRect resultRect = CGRectMake(resultX, resultY, resultWidth, resultHeight);
    
    // 开始绘制
    UIGraphicsBeginImageContextWithOptions(scaleSize, YES, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:targetRect];
    CGContextAddPath(contextRef, path.CGPath);
    CGContextClip(contextRef);
    
    [self drawInRect:resultRect];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

- (instancetype)wt_addCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners size:(CGSize)size {
    
    // 图片大小
    CGSize imageSize = self.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 目标大小
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGRect targetRect = CGRectMake(0, 0, targetWidth, targetWidth);
    
    // 按长宽比缩放后的图片的位置和大小
    CGFloat resultX = 0;
    CGFloat resultY = 0;
    CGFloat resultWidth;
    CGFloat resultHeight;
    
    if (imageWidth > imageHeight) {
        resultWidth = ceilf(targetHeight / imageHeight * imageWidth);
        resultHeight = ceilf(targetHeight);
        resultX = -(resultWidth - targetWidth) * 0.5;
    } else {
        resultWidth = ceilf(targetWidth);
        resultHeight = ceilf(targetWidth / imageWidth * imageHeight);
        resultY = -(resultHeight - targetHeight) * 0.5;
    }
    
    CGRect resultRect = CGRectMake(resultX, resultY, resultWidth, resultHeight);
    
    // 开始绘制
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:targetRect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(contextRef, path.CGPath);
    CGContextClip(contextRef);
    
    [self drawInRect:resultRect];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;}

- (instancetype)wt_addCornerWithRadius:(CGFloat)radius corners:(UIRectCorner)corners size:(CGSize)size backgroundColor:(UIColor *)backgroundColor {
    
    // 如果没有设置背景色
    if (!backgroundColor || CGColorEqualToColor(backgroundColor.CGColor, [UIColor clearColor].CGColor)) {
        return [self wt_addCornerWithRadius:radius corners:corners size:size];
    }
    
    // 图片大小
    CGSize imageSize = self.size;
    CGFloat imageWidth = imageSize.width;
    CGFloat imageHeight = imageSize.height;
    
    // 目标大小
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGRect targetRect = CGRectMake(0, 0, targetWidth, targetWidth);
    
    // 按长宽比缩放后的图片的位置和大小
    CGFloat resultX = 0;
    CGFloat resultY = 0;
    CGFloat resultWidth;
    CGFloat resultHeight;
    
    if (imageWidth > imageHeight) {
        resultWidth = ceilf(targetHeight / imageHeight * imageWidth);
        resultHeight = ceilf(targetHeight);
        resultX = -(resultWidth - targetWidth) * 0.5;
    } else {
        resultWidth = ceilf(targetWidth);
        resultHeight = ceilf(targetWidth / imageWidth * imageHeight);
        resultY = -(resultHeight - targetHeight) * 0.5;
    }
    
    CGRect resultRect = CGRectMake(resultX, resultY, resultWidth, resultHeight);
    
    // 开始绘制
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(contextRef, [backgroundColor CGColor]);
    CGContextFillRect(contextRef, targetRect);
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:targetRect byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(contextRef, path.CGPath);
    CGContextClip(contextRef);
    
    [self drawInRect:resultRect];
    
    CGContextDrawPath(contextRef, kCGPathFillStroke);
    
    UIImage * newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
