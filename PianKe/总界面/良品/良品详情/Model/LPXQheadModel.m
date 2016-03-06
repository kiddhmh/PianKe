//
//  LPXQheadModel.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/4.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPXQheadModel.h"

@implementation LPXQheadModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (![[dictionary valueForKeyPath:@"title"] isKindOfClass:[NSNull class]]) {
            self.title = [dictionary valueForKeyPath:@"title"];
        }
        if (![dictionary[@"addtime_f"] isKindOfClass:[NSNull class]]) {
            self.addtime = dictionary[@"addtime_f"];
        }
        if (![[[dictionary valueForKeyPath:@"userinfo"] valueForKey:@"icon"] isKindOfClass:[NSNull class]]) {
            self.icon = [[dictionary valueForKeyPath:@"userinfo"] valueForKey:@"icon"];
        }
        if (![[[dictionary valueForKeyPath:@"groupInfo"] valueForKey:@"title"] isKindOfClass:[NSNull class]]) {
            self.uname = [[dictionary valueForKeyPath:@"groupInfo"] valueForKey:@"title"];
        }
    }
    return self;
}

@end
