//
//  PlayMusicView.h
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class RadioSecondListModel;
typedef  void(^Block)(RadioSecondListModel *);
@interface PlayMusicView : UIView
@property (nonatomic,copy) Block block;
@end
