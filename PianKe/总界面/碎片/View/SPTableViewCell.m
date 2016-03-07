//
//  SPTableViewCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SPTableViewCell.h"
#import "ListModelFrame.h"
#import "userinfo.h"
#import "counterList.h"
#import "ListModel.h"
#import "UIImageView+WebCache.h"
@interface SPTableViewCell ()
/**
 *  头像ImageView
 */
@property (nonatomic,strong) UIImageView *iconImageView;
/**
 *  昵称Lbale
 */
@property (nonatomic,strong) UILabel *unameLabel;
/**
 *  发布时间Label
 */
@property (nonatomic,strong) UILabel *addtimeLabel;
/**
 *  配图ImageView
 */
@property (nonatomic,strong) UIImageView *coverimgView;
/**
 *  内容Label
 */
@property (nonatomic,strong) UILabel *contentLabel;
/**
 *  点赞Button
 */
@property (nonatomic,strong) UIButton *commentButton;
/**
 *  喜欢Button
 */
@property (nonatomic,strong) UIButton *likeButton;
/**
 *  底部的线
 */
@property (nonatomic,strong) UIView *lineView;

@end

@implementation SPTableViewCell

+ (SPTableViewCell *)cellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SPTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SPTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //初始化所有的子控件
        [self setupSubViews];
        self.highlighted = NO;
    }
    return self;
}


#pragma mark -
#pragma makr - 初始化子控件
- (void)setupSubViews
{
    //头像
    self.iconImageView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconImageView];
    
    //昵称
    self.unameLabel = [[UILabel alloc] init];
    self.unameLabel.textAlignment = NSTextAlignmentLeft;
    self.unameLabel.textColor = RGB(148, 161, 255);
    self.unameLabel.font = LISTUNAMEFONT;
    [self.contentView addSubview:self.unameLabel];
    
    //发布时间
    self.addtimeLabel = [[UILabel alloc] init];
    self.addtimeLabel.textAlignment = NSTextAlignmentRight;
    self.addtimeLabel.textColor = [UIColor lightGrayColor];
    self.addtimeLabel.font = LISTTIMEFONT;
    [self.contentView addSubview:self.addtimeLabel];
    
    //内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = [UIColor darkGrayColor];
    self.contentLabel.font = LISTCONTENTFONT;
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    //配图(如果有的话)
    self.coverimgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.coverimgView];
    
    //点赞数
    self.commentButton = [[UIButton alloc] init];
    self.commentButton.titleLabel.font = LISTTIMEFONT;
    [self.commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.commentButton];
    
    //喜欢数
    self.likeButton= [[UIButton alloc] init];
    self.likeButton.titleLabel.font = LISTTIMEFONT;
    [self.likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.likeButton];
    
    //底部的线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = self.lineView.backgroundColor = RGB(238, 238, 238);
    [self.contentView addSubview:self.lineView];
}


#pragma mark - 
#pragma makr - 重写Frame模型的setter方法，给子控件设置frame
- (void)setListFrame:(ListModelFrame *)listFrame
{
    _listFrame = listFrame;
    
    ListModel *listM = listFrame.listM;
    userinfo *userinfoM = listM.userinfo;
    counterList *counterM = listM.counterList;
    
    //设置各个子控件的frame
    //头像
    self.iconImageView.frame = listFrame.iconF;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:userinfoM.icon] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.iconImageView.layer.cornerRadius = 25;
    self.iconImageView.layer.masksToBounds = YES;
    
    //昵称
    self.unameLabel.frame = listFrame.unameF;
    self.unameLabel.text = userinfoM.uname;
    
    //发布时间
    self.addtimeLabel.frame = listFrame.addTimeF;
    self.addtimeLabel.text = listM.addtime_f;
    
    //配图
    if (listM.coverimg) {
        [self.coverimgView sd_setImageWithURL:[NSURL URLWithString:listM.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.coverimgView.frame = listFrame.coverimgF;
        
        self.coverimgView.hidden  = NO;
    }else
    {
        self.coverimgView.hidden = YES;
    }
    
    //内容
    self.contentLabel.frame = listFrame.contentF;
    self.contentLabel.text = listM.content;
    
    //点赞数
    self.commentButton.frame = listFrame.commentF;
    [self.commentButton setTitle:[NSString stringWithFormat:@"💬 %ld",counterM.comment] forState:UIControlStateNormal];
    
    //喜欢数
    self.likeButton.frame = listFrame.likeFrame;
    [self.likeButton setTitle:[NSString stringWithFormat:@"❤️ %ld",counterM.like] forState:UIControlStateNormal];
    
    //底部的线
    self.lineView.frame = listFrame.lineF;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
