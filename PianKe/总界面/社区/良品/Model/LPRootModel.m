//
//  LPRootModel.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPRootModel.h"
#import "LPDataModel.h"
@implementation LPRootModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        if (![dictionary[@"data"] isKindOfClass:[NSNull class]]) {//当data对应的数据不为空时，获取数据
            //把Json当中的data所对应的数据，转换成LPDataModel类型
            self.data = [[LPDataModel alloc] initWithDictionary:dictionary[@"data"]];
        }
        
        if (dictionary[@"result"]!=0) {
            self.result = [dictionary[@"result"] integerValue];
        }
    }
    return self;
}


- (void)toDictionary
{
    
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    
}

- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
    }
    return self;
}


@end
