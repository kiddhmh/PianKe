//
//  MusicManager.h
//  PianKe
//
//  Created by 胡明昊 on 16/3/16.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface MusicManager : NSObject

+ (instancetype)defaultManager;

/**
 *  播放音乐
 */
- (AVAudioPlayer *)playingMusic:(NSString *)filename;

/**
 *  暂停音乐
 */
- (void)pauseMusic:(NSString *)filename;


/**
 *  停止音乐
 */
- (void)stopMusic:(NSString *)filename;

//播放音效
- (void)playSound:(NSString *)filename;
- (void)disposeSound:(NSString *)filename;

@end
