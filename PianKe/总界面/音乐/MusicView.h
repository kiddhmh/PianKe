//
//  MusicView.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/16.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MusicView : UIView
/**
 *  歌曲序号
 */
@property (nonatomic,assign) NSUInteger songid;
@property (nonatomic,assign,getter=isPlaying) BOOL playing;

- (void)pause;

@end
