//
//  SQHotTableViewCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQHotListFrameModel;
@interface SQHotTableViewCell : UITableViewCell

@property (nonatomic,strong) SQHotListFrameModel *HotFrameModel;

+ (SQHotTableViewCell *)cellWith:(UITableView *)tableView;

@end
