//
//  SPXQHeaderView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SPXQHeaderView.h"
#import "ListModel.h"
#import "Masonry.h"
#import "ListModelFrame.h"
#import "UIImageView+WebCache.h"
#import "userinfo.h"
#import "UIView+Frame.h"
#import "NSString+Helper.h"
#import "CoverimgTool.h"

@interface SPXQHeaderView ()
/**
 *  头像ImageView
 */
@property (nonatomic,strong) UIImageView *iconimageView;
/**
 *  昵称Label
 */
@property (nonatomic,strong) UILabel *unameLabel;
/**
 *  发布时间Label
 */
@property (nonatomic,strong) UILabel *addtimeLabel;
/**
 *  内容Label
 */
@property (nonatomic,strong) UILabel *contentLabel;
/**
 *  底部的线
 */
@property (nonatomic,strong) UIView *lineView;
/**
 *  配图
 */
@property (nonatomic,strong) UIImageView *photoView;
@end
@implementation SPXQHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubViews];
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark -
#pragma mark - 初始化子控件
- (void)setupSubViews
{
    //头像
    self.iconimageView = [[UIImageView alloc] init];
    self.iconimageView.layer.cornerRadius = 25;
    self.iconimageView.layer.masksToBounds = YES;
    [self addSubview:self.iconimageView];
    
    //昵称
    self.unameLabel = [[UILabel alloc] init];
    self.unameLabel.textAlignment = NSTextAlignmentLeft;
    self.unameLabel.textColor = RGB(148, 161, 255);
    self.unameLabel.font = LISTUNAMEFONT;
    [self addSubview:self.unameLabel];
    
    //发布时间
    self.addtimeLabel = [[UILabel alloc] init];
    self.addtimeLabel.textAlignment = NSTextAlignmentRight;
    self.addtimeLabel.textColor = [UIColor lightGrayColor];
    self.addtimeLabel.font = LISTTIMEFONT;
    [self addSubview:self.addtimeLabel];
    
    //内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = [UIColor darkGrayColor];
    self.contentLabel.font = LISTCONTENTFONT;
    self.contentLabel.numberOfLines = 0;
    [self addSubview:self.contentLabel];
    
    //底部的线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = self.lineView.backgroundColor = RGB(238, 238, 238);
    [self addSubview:self.lineView];
    
    self.photoView = [[UIImageView alloc] init];
    self.photoView.contentMode = UIViewContentModeScaleAspectFill;
    self.photoView.hidden = YES;
    [self addSubview:self.photoView];
}



#pragma mark - 
#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)view = self;
    [view.iconimageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(CellBorderW);
        make.top.equalTo(view.mas_top).offset(CellBorderW);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    
    [view.unameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.iconimageView.mas_centerY);
        make.left.equalTo(view.iconimageView.mas_right).offset(CellBorderW);
        make.size.mas_equalTo(CGSizeMake(120, 20));
    }];
    
    [view.addtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.iconimageView.mas_centerY);
        make.right.equalTo(view.mas_right).offset(-CellBorderW);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    [view.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(CellBorderW);
        make.centerX.equalTo(view.mas_centerX);
        make.top.equalTo(view.iconimageView.mas_bottom).offset(2*CellBorderW);
        make.size.mas_equalTo(CGSizeMake(SCREENWIDTH - 2 * CellBorderW, 60));
    }];
    
    [view.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
        make.height.mas_equalTo(1);
        make.top.equalTo(view.contentLabel.mas_bottom).offset(2*CellBorderW);
    }];
}


- (void)setListModel:(ListModel *)listModel
{
    _listModel = listModel;
    [self.iconimageView sd_setImageWithURL:[NSURL URLWithString:listModel.userinfo.icon] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.unameLabel.text = listModel.userinfo.uname;
    
    self.addtimeLabel.text = listModel.addtime_f;
    
    self.contentLabel.text = listModel.content;
    
    if ([listModel.coverimg isEqualToString:@""]) {
        self.photoView.hidden = YES;
    }else{
        self.photoView.hidden = NO;
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:Placholder];
        __weak typeof(self)vc = self;
        CGFloat coverW = SCREENWIDTH - 2 * Padding;
        CGFloat coverScale = [CoverimgTool sizeWithSizeString:listModel.coverimg_wh];
        [vc.photoView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(vc.lineView.mas_bottom).offset(Padding);
            make.centerX.equalTo(vc.mas_centerX);
            make.size.mas_equalTo(CGSizeMake(coverW, coverScale * coverW));
        }];
    }
}


@end
