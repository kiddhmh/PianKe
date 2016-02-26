//
//  PlayMusicView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "PlayMusicView.h"
@interface PlayMusicView ()
@property (nonatomic,strong) UIButton *btn;

@end
@implementation PlayMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}



- (void)setupSubViews
{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"播放音乐" forState:UIControlStateNormal];
    [btn setBackgroundColor:[UIColor blackColor]];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self addSubview:btn];
}

- (void)layoutSubviews
{
    for (UIView *sub in self.subviews) {
        sub.frame = CGRectMake(80,10,100,30);
    }
}


@end
