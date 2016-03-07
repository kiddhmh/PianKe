//
//  SPTableViewCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModelFrame;
@interface SPTableViewCell : UITableViewCell

@property (nonatomic,strong) ListModelFrame *listFrame;

+ (SPTableViewCell *)cellWith:(UITableView *)tableView;

@end
