//
//  RadioHeaderView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/14.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^Block)(NSString *URL);
#define HotImageW (SCREENWIDTH - 4 * 5) / 3
#define Margin 5
@interface RadioHeaderView : UIView
@property (nonatomic,strong) NSMutableArray *listArray;
@property (nonatomic,copy) Block block;

@end
