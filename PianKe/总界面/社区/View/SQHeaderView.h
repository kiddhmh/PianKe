//
//  SQHeaderView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SQHeaderDelegate <NSObject>

@optional
- (void)sqHeaderDidSelectedSegmentIndex:(NSInteger)index SegmentControl:(UISegmentedControl *)segmentControl;

@end

@interface SQHeaderView : UIView

@property (nonatomic,weak) id<SQHeaderDelegate> delegate;

@end
