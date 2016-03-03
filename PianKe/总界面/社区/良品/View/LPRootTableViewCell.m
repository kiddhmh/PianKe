//
//  LPRootTableViewCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPRootTableViewCell.h"
#import "LPListModel.h"
#import "UIImageView+SDWedImage.h"
@interface LPRootTableViewCell ()
/**
 *  配图
 */
@property (nonatomic,strong) UIImageView *coverImageView;
/**
 *  内容
 */
@property (nonatomic,strong) UILabel *contentLabel;
/**
 *  购买按钮
 */
@property (nonatomic,strong) UIButton *buyButton;
/**
 *  底部的线条
 */
@property (nonatomic,strong) UIView *lineView;

@end

@implementation LPRootTableViewCell

#pragma mark - 
#pragma mark - 初始化方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.coverImageView];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.buyButton];
        [self.contentView addSubview:self.lineView];
        self.highlighted = NO;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)loadDataWith:(LPListModel *)model
{
    [_coverImageView downloadImage:model.coverimg place:[UIImage imageNamed:@"timeline_image_placeholder"]];
    _contentLabel.text = model.title;
}


#pragma mark - 
#pragma mark - 懒加载
- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.frame = CGRectMake(10, 10, [UIScreen mainScreen].bounds.size.width - 20, 160);
        _coverImageView.backgroundColor = [UIColor clearColor];
    }
    return _coverImageView;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = [UIFont systemFontOfSize:14];
        _contentLabel.frame = CGRectMake(15, 180, 300, 30);
        _contentLabel.textColor = [UIColor darkGrayColor];
    }
    return _contentLabel;
}


- (UIButton *)buyButton
{
    if (!_buyButton) {
        _buyButton = [[UIButton alloc] init];
        _buyButton.backgroundColor = RGB(55, 207, 16);
        [_buyButton setTitle:@"立即购买" forState:UIControlStateNormal];
        _buyButton.layer.cornerRadius = 8;
        _buyButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _buyButton.frame = CGRectMake(290,180,60, 25);
        _buyButton.layer.masksToBounds = YES;
        [_buyButton addTarget:self action:@selector(buy) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

- (void)buy
{
    NSLog(@"立即购买");
}

- (UIView *)lineView
{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.frame = CGRectMake(0, 219,[UIScreen mainScreen].bounds.size.width, 1);
        _lineView.backgroundColor = RGB(238, 238, 238);
    }
    return _lineView;
}

//重写这个方法取消高亮状态
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
