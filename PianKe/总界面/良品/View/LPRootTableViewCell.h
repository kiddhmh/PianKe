//
//  LPRootTableViewCell.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LPListModel;
@interface LPRootTableViewCell : UITableViewCell

- (void)loadDataWith:(LPListModel *)model;

@end
