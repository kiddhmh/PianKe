//
//  RadioListCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioListCell.h"
#import "UIImageView+WebCache.h"
#import "RadioAllList.h"
#import "RadioUserInfo.h"

@interface RadioListCell ()
/**
 *  配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *CoverImageView;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  电台作者名
 */
@property (weak, nonatomic) IBOutlet UILabel *unameLabel;
/**
 *  电台简介
 */
@property (weak, nonatomic) IBOutlet UILabel *desLabel;
/**
 *  电台收听量
 */
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;


@end

@implementation RadioListCell

+ (instancetype)cellWith:(UITableView *)tabeView
{
    static NSString *ID = @"Radiocell";
    RadioListCell *listCell = [tabeView dequeueReusableCellWithIdentifier:ID];
    if (!listCell) {
        listCell = [[[NSBundle mainBundle] loadNibNamed:@"RadioListCell" owner:nil options:nil] lastObject];
    }
    return listCell;
}


- (void)setAllList:(RadioAllList *)allList
{
    _allList = allList;
    RadioUserInfo *user = allList.userinfo;
    
    //给子控件设置数据
    self.CoverImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.CoverImageView sd_setImageWithURL:[NSURL URLWithString:allList.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    self.titleLabel.text = allList.title;
    
    self.unameLabel.text = [NSString stringWithFormat:@"by: %@",user.uname];
    
    self.desLabel.text = allList.desc;
    
    self.countLabel.text = [NSString stringWithFormat:@"🔊 %ld",allList.count];
    
    self.lineView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

@end
