//
//  LPListModel.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPListModel.h"

@implementation LPListModel

- (instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init]) {
        
        //判空
        if (![dic[@"buyurl"] isKindOfClass:[NSNull class]]) {
            self.buyurl = dic[@"buyurl"];
        }
        if (![dic[@"coverimg"] isKindOfClass:[NSNull class]]) {
            self.coverimg = dic[@"coverimg"];
        }
        if (![dic[@"contentid"] isKindOfClass:[NSNull class]]) {
            self.contentid = dic[@"contentid"];
        }
        if (![dic[@"title"] isKindOfClass:[NSNull class]]) {
            self.title = dic[@"title"];
        }
    }
    return self;
}

@end
