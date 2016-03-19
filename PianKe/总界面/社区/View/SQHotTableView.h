//
//  SQHotTableView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SQHotListModel;
typedef void(^Block)(SQHotListModel *);
@interface SQHotTableView : UITableView
@property (nonatomic,strong) NSArray *FrameArray;
@property (nonatomic,copy) Block block;

@end
