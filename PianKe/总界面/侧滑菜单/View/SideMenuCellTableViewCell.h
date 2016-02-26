//
//  SideMenuCellTableViewCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuCellTableViewCell : UITableViewCell
/**
 *  菜单标题
 */
@property (nonatomic,copy) NSString *title;
/**
 *  菜单图标
 */
@property (nonatomic,copy) NSString *iconImage;
/**
 *  选中cell时文字的颜色
 */
@property (nonatomic,strong) UIColor *TextColor;

+ (instancetype)cellWith:(UITableView *)tableView;

@end
