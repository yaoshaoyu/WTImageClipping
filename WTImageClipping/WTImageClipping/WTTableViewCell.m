//
//  WTTableViewCell.m
//  WTImageClipping
//
//  Created by 吕成翘 on 2018/9/15.
//  Copyright © 2018年 Weitac. All rights reserved.
//

#import "WTTableViewCell.h"
#import "UIImageView+WTClipping.h"


@implementation WTTableViewCell

#pragma mark - LifeCycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupUI];
    }
    
    return self;
}

#pragma mark - Pirvate
/**
 设置界面
 */
- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    iconImageView.backgroundColor = self.backgroundColor;
    [self.contentView addSubview:iconImageView];
    [iconImageView wt_roundedImageWithURLString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1536943144881&di=2625ff2323c342a6306e4d9ba2fa9b10&imgtype=0&src=http%3A%2F%2Fi4.download.fd.pchome.net%2Ft_960x600%2Fg1%2FM00%2F09%2F04%2FoYYBAFOtFdCIZU6uABAHRBdgU70AABp-AEwuE0AEAdc290.jpg" placeholderImageName:nil radius:40];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, [UIScreen mainScreen].bounds.size.width - 85, 40)];
    titleLabel.textColor = [UIColor lightGrayColor];
    titleLabel.font = [UIFont systemFontOfSize:15];
    titleLabel.numberOfLines = 2;
    titleLabel.backgroundColor = self.backgroundColor;
    titleLabel.text = @"本地缓存原图和处理后的图片";
    [self.contentView addSubview:titleLabel];
    
    UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 70 - 1.0 / [UIScreen mainScreen].scale, [UIScreen mainScreen].bounds.size.width, 1.0 / [UIScreen mainScreen].scale)];
    separatorView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:separatorView];
}

@end
