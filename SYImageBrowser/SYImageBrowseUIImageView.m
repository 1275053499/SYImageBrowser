//
//  SYImageBrowseUIImageView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/11/8.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYImageBrowseUIImageView.h"
#import "SYImageBrowseHelper.h"
/// 使用SDWebImage
#import "UIImageView+WebCache.h"

@interface SYImageBrowseUIImageView ()

@end

@implementation SYImageBrowseUIImageView

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addTapGesture];
    }
    
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addTapGesture];
    }
    return self;
}

#pragma mark - 手势

- (void)addTapGesture
{
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    
    self.userInteractionEnabled = self;
    [self addGestureRecognizer:tapRecognizer];
}

#pragma mark - 交互

- (void)tapClick
{
    if (self.imageClick)
    {
        self.imageClick();
    }
}

#pragma mark - 图片设置

/// 设置图片（网络图片/本地图片+默认图片）
- (void)setImage:(id)object defaultImage:(UIImage *)image
{
    SYImageType type = [SYImageBrowseHelper getImageType:object];
    switch (type)
    {
        case SYImageTypeData:
        {
            self.image = object;
        }
            break;
        case SYImageTypeName:
        {
            UIImage *img = [UIImage imageNamed:object];
            self.image = img;
        }
            break;
        case SYImageTypeUrl:
        {
            NSURL *imageUrl = [NSURL URLWithString:object];
            if (image)
            {
                if ([self respondsToSelector:@selector(sd_setImageWithURL:placeholderImage:)])
                {
                    [self sd_setImageWithURL:imageUrl placeholderImage:image];
                }
            }
            else
            {
                [self sd_setImageWithURL:imageUrl];
            }
        }
            break;
        
        default:
            break;
    }
}

@end
