//
//  SQHotTableViewCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQHotTableViewCell.h"
#import "SQHotListFrameModel.h"
#import "SQHotListModel.h"
#import "counterList.h"
#import "UIImageView+WebCache.h"
@interface SQHotTableViewCell ()
/**
 *  标题
 */
@property (nonatomic,strong) UILabel *titleLabel;
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
 *  底部的线
 */
@property (nonatomic,strong) UIView *lineView;

@end

@implementation SQHotTableViewCell

+ (SQHotTableViewCell *)cellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SQHotTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[SQHotTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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


#pragma mark - 初始化子控件
- (void)setupSubViews
{
    //标题
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = HotTitleFont;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = [UIColor blackColor];
    [self.contentView addSubview:self.titleLabel];
    
    //发布时间
    self.addtimeLabel = [[UILabel alloc] init];
    self.addtimeLabel.textAlignment = NSTextAlignmentRight;
    self.addtimeLabel.textColor = [UIColor lightGrayColor];
    self.addtimeLabel.font = HotTimeFont;
    [self.contentView addSubview:self.addtimeLabel];
    
    //内容
    self.contentLabel = [[UILabel alloc] init];
    self.contentLabel.textAlignment = NSTextAlignmentLeft;
    self.contentLabel.textColor = [UIColor darkGrayColor];
    self.contentLabel.font = HotcontentidFont;
    self.contentLabel.numberOfLines = 0;
    [self.contentView addSubview:self.contentLabel];
    
    //配图(如果有的话)
    self.coverimgView = [[UIImageView alloc] init];
    self.coverimgView.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.coverimgView];
    
    //点赞数
    self.commentButton = [[UIButton alloc] init];
    self.commentButton.titleLabel.font = HotTimeFont;
    [self.commentButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.contentView addSubview:self.commentButton];
    
    //底部的线
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = self.lineView.backgroundColor = RGB(238, 238, 238);
    [self.contentView addSubview:self.lineView];

}


#pragma mark -
#pragma makr - 重写Frame模型的setter方法，给子控件设置frame
- (void)setHotFrameModel:(SQHotListFrameModel *)HotFrameModel
{
    _HotFrameModel = HotFrameModel;
    
    SQHotListModel *listM = HotFrameModel.hotListModel;
    counterList *counterM = listM.counterList;
    
    //设置各个子控件的frame
    self.titleLabel.text = listM.title;
    self.titleLabel.frame = HotFrameModel.titleLabelF;
    
    //发布时间
    self.addtimeLabel.frame = HotFrameModel.addtimelabelF;
    self.addtimeLabel.text = listM.addtime_f;
    
    //配图
    if (listM.coverimg) {
        [self.coverimgView sd_setImageWithURL:[NSURL URLWithString:listM.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.coverimgView.frame = HotFrameModel.coverImageViewF;
        
        self.coverimgView.hidden  = NO;
    }else
    {
        self.coverimgView.hidden = YES;
    }
    
    //内容
    self.contentLabel.frame = HotFrameModel.contentidLabelF;
    self.contentLabel.text = listM.content;
    
    //点赞数
    self.commentButton.frame = HotFrameModel.commentLabelF;
    [self.commentButton setTitle:[NSString stringWithFormat:@"💬 %ld",counterM.comment] forState:UIControlStateNormal];
    
    //底部的线
    self.lineView.frame = HotFrameModel.lineF;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
