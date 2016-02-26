//
//  PlayMusicView.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "PlayMusicView.h"
#import "Masonry.h"
@interface PlayMusicView ()
/**
 *  音乐图标
 */
@property (nonatomic,strong) UIImageView *MusicIconImageView;

/**
 *  播放/暂停按钮
 */
@property (nonatomic,strong) UIButton *playBtn;


@end
@implementation PlayMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}


#pragma mark - 
#pragma mark - 初始化方法
- (void)setupSubViews
{
    //创建左边的音乐图标
    UIImageView *MusicImageView = [[UIImageView alloc] init];
    MusicImageView.image = [UIImage imageNamed:@"音乐"];
    [self addSubview:MusicImageView];
    self.MusicIconImageView = MusicImageView;
    
    //创建右边的播放/暂停按钮
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateSelected];
    btn.selected = NO;
//    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn addTarget:self action:@selector(PlayOrPause) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    self.playBtn = btn;
}


- (void)layoutSubviews
{
    //给音乐图标设置约束
    CGFloat padding = 10;
    __weak typeof(self)vc = self;
    [vc.MusicIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.and.height.mas_equalTo(@40);
        make.centerY.mas_equalTo(vc.mas_centerY);
        make.left.equalTo(vc.mas_left).offset(padding);
    }];
    //给按钮设置约束
    [vc.playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.mas_equalTo(vc.mas_centerY);
        make.right.equalTo(vc.mas_right).offset(- vc.frame.size.width / 2);
    }];
}

#pragma mrak -
#pragma mark - 其他方法
- (void)PlayOrPause
{
    self.playBtn.selected = ![self.playBtn isSelected];
}

@end
