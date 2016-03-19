//
//  RadioMusicView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/19.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class RadioSecondListModel;
@interface RadioMusicView : UIView

/**
 *  进度条
 */
@property (nonatomic,strong) UIProgressView *progressView;
/**
 *  显示时间
 */
@property (nonatomic,strong) UILabel *currentLabel;
@property (nonatomic,strong) AVPlayer *player;
@property (nonatomic,strong) AVPlayerItem *itemPlayer;
@property (nonatomic,assign,getter=isPlaying) BOOL playing;


- (void)passRadioMessage:(RadioSecondListModel *)listModel andName:(NSString *)name;

@end
