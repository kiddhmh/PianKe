//
//  ReadSecondCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ReadSecondListModel;
@interface ReadSecondCell : UITableViewCell
@property (nonatomic,strong) ReadSecondListModel *listModel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
