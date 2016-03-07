//
//  SPTableView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModelFrame;
typedef void (^Block)(ListModelFrame *);
@interface SPTableView : UITableView

@property (nonatomic,strong) NSArray *FrameArray;

@property (nonatomic,copy) Block enterBlock;

@end
