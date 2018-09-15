//
//  UIImageView+WTClipping.m
//  WTImageClipping
//
//  Created by 吕成翘 on 2018/9/14.
//  Copyright © 2018年 Weitac. All rights reserved.
//

#import "UIImageView+WTClipping.h"
#import "UIImage+WTClipping.h"
#import "UIImageView+WebCache.h"


@implementation UIImageView (WTClipping)

- (void)wt_setRectangleImageWithURLString:(NSString *)urlString targetSize:(CGSize)targetSize placeholderImageName:(NSString *)placeholderImageName {
    
    // 设置占位图
    if (placeholderImageName.length > 0) {
        self.image = [UIImage imageNamed:placeholderImageName];
    }
    
    // 生成压缩图的URL
    NSString *compressImageString = [self urlString:urlString appendString:[NSString stringWithFormat:@"_%ld_%ld", (NSInteger)targetSize.width, (NSInteger)targetSize.height]];
    NSURL *compressImageURL = [NSURL URLWithString:compressImageString];
    
    // 从缓存加载缩略图
    __weak __typeof(self)weakSelf = self;
    [self sd_setImageWithURL:compressImageURL placeholderImage:[UIImage imageNamed:placeholderImageName] options:SDWebImageFromCacheOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        // 如果没有缓存或加载出错
        if (!image || error) {
            
            // 设置占位图
            if (placeholderImageName.length > 0) {
                strongSelf.image = [UIImage imageNamed:placeholderImageName];
            }
            
            // 生成原图的URL
            NSURL *originalImageURL = [NSURL URLWithString:urlString];
            
            // 加载原图
            __weak __typeof(strongSelf)weakWSelf = strongSelf;
            [strongSelf sd_setImageWithURL:originalImageURL placeholderImage:[UIImage imageNamed:placeholderImageName] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                __strong __typeof(weakWSelf)strongSSelf = weakWSelf;
                if (!strongSSelf) {
                    return;
                }
                
                // 加载原图成功
                if (image && !error) {
                    
                    // 全局并发队列异步执行
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        // 原图压缩处理
                        UIImage *scaleImage = [image wt_scaleImageWithScaleSize:targetSize];
                        
                        // 主队列异步执行
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 设置图片
                            strongSSelf.image = scaleImage;
                        });
                        
                        // 生成URL对应的cacheKey
                        NSString *compressImageCacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:compressImageURL];
                        
                        // 将处理好的压缩图存入缓存
                        [[SDImageCache sharedImageCache] storeImage:scaleImage forKey:compressImageCacheKey completion:nil];
                        scaleImage = nil;
                    });
                }
            }];
        }
    }];
}

- (void)wt_roundedImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName radius:(CGFloat)radius {
    
    [self wt_roundedImageWithURLString:urlString placeholderImageName:placeholderImageName radius:radius corners:UIRectCornerAllCorners size:CGSizeMake(radius * 2, radius * 2)];
}

- (void)wt_roundedImageWithURLString:(NSString *)urlString placeholderImageName:(NSString *)placeholderImageName radius:(CGFloat)radius corners:(UIRectCorner)corners size:(CGSize)size {
    
    // 设置占位图
    if (placeholderImageName.length > 0) {
        self.image = [UIImage imageNamed:placeholderImageName];
    }
    
    // 生成压缩图的URL
    NSString *compressImageString = [self urlString:urlString appendString:[NSString stringWithFormat:@"_%ld_%ld_%ld", (NSInteger)size.width, (NSInteger)size.height, corners]];
    NSURL *compressImageURL = [NSURL URLWithString:compressImageString];
    
    // 从缓存加载缩略图
    __weak __typeof(self)weakSelf = self;
    [self sd_setImageWithURL:compressImageURL placeholderImage:[UIImage imageNamed:placeholderImageName] options:SDWebImageFromCacheOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        if (!strongSelf) {
            return;
        }
        
        // 如果没有缓存或加载出错
        if (!image || error) {
            
            // 设置占位图
            if (placeholderImageName.length > 0) {
                strongSelf.image = [UIImage imageNamed:placeholderImageName];
            }
            
            // 生成原图的URL
            NSURL *originalImageURL = [NSURL URLWithString:urlString];
            
            // 加载原图
            __weak __typeof(strongSelf)weakWSelf = strongSelf;
            [strongSelf sd_setImageWithURL:originalImageURL placeholderImage:[UIImage imageNamed:placeholderImageName] options:SDWebImageAvoidAutoSetImage completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                __strong __typeof(weakWSelf)strongSSelf = weakWSelf;
                if (!strongSSelf) {
                    return;
                }
                
                // 加载原图成功
                if (image && !error) {
                    
                    UIColor *bgColor = strongSSelf.backgroundColor;
                    
                    // 全局并发队列异步执行
                    dispatch_async(dispatch_get_global_queue(0, 0), ^{
                        
                        // 原图剪裁处理
                        UIImage *roundedImage = [image wt_addCornerWithRadius:radius corners:corners size:size backgroundColor:bgColor];
                        
                        // 主队列异步执行
                        dispatch_async(dispatch_get_main_queue(), ^{
                            // 设置图片
                            strongSSelf.image = roundedImage;
                        });
                        
                        // 生成URL对应的cacheKey
                        NSString *compressImageCacheKey = [[SDWebImageManager sharedManager] cacheKeyForURL:compressImageURL];
                        
                        // 将处理好的压缩图存入缓存
                        [[SDImageCache sharedImageCache] storeImage:roundedImage forKey:compressImageCacheKey completion:nil];
                        roundedImage = nil;
                    });
                }
            }];
        }
    }];
}

/**
 为图像链接拼接字符串
 
 @param urlString 图片地址
 @param appendString 要拼接的字符串
 @return 拼接好的字符串
 */
- (NSString *)urlString:(NSString *)urlString appendString:(NSString *)appendString {
    
    NSString *pathString = [urlString stringByDeletingPathExtension];
    NSString *pathExtensionString = urlString.pathExtension;
    
    return [[pathString stringByAppendingString:appendString] stringByAppendingPathExtension:pathExtensionString];
}

@end
