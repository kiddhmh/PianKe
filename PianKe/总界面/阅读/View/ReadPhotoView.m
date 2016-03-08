//
//  ReadPhotoView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/8.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ReadPhotoView.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
@interface ReadPhotoView ()
/**
 *  图片ImageView
 */
@property (nonatomic,strong) UIImageView *coverImageView;
/**
 *  书名Label
 */
@property (nonatomic,strong) UILabel *nameLabel;
/**
 *  作者名Label
 */
@property (nonatomic,strong) UILabel *ennameLabel;


@end

@implementation ReadPhotoView


#pragma mark -
#pragma mark - 懒加载


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupAutolayout];
    }
    return self;
}


#pragma mark - 初始化子控件
- (void)setupSubViews
{
    [self addSubview:self.coverImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:self.ennameLabel];
}


#pragma mark -
#pragma makr - 自动适配
- (void)setupAutolayout
{
    CGFloat margin = 3;
    __weak typeof(self)view = self;
    [view.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(view);
    }];
    
    [view.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(margin);
        make.bottom.equalTo(view.mas_bottom).offset(-margin);
        make.right.equalTo(view.ennameLabel.mas_left).offset(-margin);
        make.height.mas_equalTo(20);
    }];
    
    [view.ennameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.nameLabel.mas_right).offset(margin);
        make.right.equalTo(view.mas_right).offset(-margin);
        make.centerY.equalTo(view.nameLabel.mas_centerY);
        make.height.mas_equalTo(20);
    }];
}


#pragma mark -
#pragma mark - 懒加载
- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _coverImageView;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.userInteractionEnabled = YES;
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:14];
    }
    return _nameLabel;
}


- (UILabel *)ennameLabel
{
    if (!_ennameLabel) {
        _ennameLabel = [[UILabel alloc] init];
        _ennameLabel.backgroundColor = [UIColor clearColor];
        _ennameLabel.userInteractionEnabled = YES;
        _ennameLabel.textAlignment = NSTextAlignmentLeft;
        _ennameLabel.textColor = [UIColor whiteColor];
        _ennameLabel.font = [UIFont systemFontOfSize:11];
    }
    return _ennameLabel;
}

- (void)setCoverimg:(NSString *)coverimg
{
    _coverimg = coverimg;
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
}

- (void)setName:(NSString *)name
{
    _name = name;
    self.nameLabel.text = name;
}

- (void)setEnname:(NSString *)enname
{
    _enname = enname;
    self.ennameLabel.text = enname;
}

@end
