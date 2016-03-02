//
//  LoadingView.m
//  有妖气漫画
//
//  Created by ma c on 16/1/24.
//  Copyright © 2016年 cmcc. All rights reserved.
//

#import "LoadingView.h"
@interface LoadingView ()

///缓冲动画图片数组
@property (nonatomic,strong) NSMutableArray *loadImage;
///播放动画的ImageView
@property (nonatomic,strong) UIImageView *loadImageView;

@end
@implementation LoadingView

#pragma mark -
#pragma mark - 懒加载
- (NSMutableArray *)loadImage
{
    if (_loadImage == nil) {
        _loadImage = [[NSMutableArray alloc]init];
    }
    return _loadImage;
}



#pragma makr - 
#pragma mark -初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}




- (void)showLoadingTo:(UIView *)view
{
    self.backgroundColor = [UIColor whiteColor];
    //播放加载动画
    [self creatLoadImage];
    
    [view addSubview:self];
}

- (void)showLoadViewTo:(UIWindow *)window
{
    self.backgroundColor = [UIColor whiteColor];
    //播放加载动画
    [self creatLoadImage];
    
    [window addSubview:self];
}


#pragma mark - 
#pragma makr - 接口方法
- (void)creatLoadImage
{
    
    //创建显示文字
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(135, 460,100,30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:15];
    label.text = @"";
    [self addSubview:label];
    
    //创建图片动画
    self.loadImageView = [[UIImageView alloc] init];
    CGRect rect = CGRectMake(self.center.x - 30,self.center.y - 30,60,60);
    self.loadImageView.frame = rect;
    
    [self addSubview:self.loadImageView];
    
    //加载图片
    if (self.loadImage.count == 0) {
        for (int i = 0; i < 28; i++ ) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"refresh%d",i]];
            [self.loadImage addObject:image];
        }
    }
    
    //设置动画
    self.loadImageView.animationImages = self.loadImage;
    self.loadImageView.animationRepeatCount = 0;
    self.loadImageView.animationDuration = 2.5;
    
    [self.loadImageView startAnimating];
}

///停止动画
- (void)dismiss
{
    self.loadImage = nil;
    self.loadImageView.animationImages = nil;
    [self.loadImageView removeFromSuperview];
    [self removeFromSuperview];
}

@end
