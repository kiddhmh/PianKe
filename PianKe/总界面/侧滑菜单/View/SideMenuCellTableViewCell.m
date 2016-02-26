//
//  SideMenuCellTableViewCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SideMenuCellTableViewCell.h"
#import "UIColor+Extension.h"
@interface SideMenuCellTableViewCell ()
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;


@end
@implementation SideMenuCellTableViewCell

- (void)awakeFromNib
{
    //设置选中状态背景图片
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor darkGrayColor];
    
    //设置cell的背景
    self.titleLabel.textColor = [UIColor lightGrayColor];
    self.backgroundColor = [UIColor colorWithHexString:@"#303030"];
    
    self.iconImageView.contentMode = UIViewContentModeCenter;
}


+ (instancetype)cellWith:(UITableView *)tableView
{
    static NSString *ID = @"cell";
    SideMenuCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SideMenuCellTableViewCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setTitle:(NSString *)title
{
    self.titleLabel.text = title;
}

- (void)setIconImage:(NSString *)iconImage
{
    self.iconImageView.image =  [UIImage imageNamed:iconImage];
}


- (void)setTextColor:(UIColor *)TextColor
{
    self.titleLabel.textColor = TextColor;
}


//重写这个方法，取消高亮效果
- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


@end
