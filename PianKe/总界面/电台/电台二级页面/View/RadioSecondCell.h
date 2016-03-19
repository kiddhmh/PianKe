//
//  RadioSecondCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioSecondListModel;
@interface RadioSecondCell : UITableViewCell

@property (nonatomic,strong) RadioSecondListModel *radioListModel;

+ (instancetype)cellWithtableView:(UITableView *)tableView;

@end
