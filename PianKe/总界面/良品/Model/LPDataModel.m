//
//  LPDataModel.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/3.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPDataModel.h"
#import "LPListModel.h"
@implementation LPDataModel

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [super init]) {
        if (![dictionary[@"list"] isKindOfClass:[NSNull class]]) {
            //假如list所对应的数组不为空，那么给模型的list属性赋值
            //存放LPListModel的数组
            NSMutableArray *listArray = [NSMutableArray array];
            //快速遍历
            for (NSDictionary *itemDic in dictionary[@"list"]) {
                //拿到list数组当中的每一个元素(字典)
                //然后把这个字典转换成List模型
                LPListModel *model = [[LPListModel alloc] initWithDic:itemDic];
                //把listModel模型存放到一个数组当中
                [listArray addObject:model];
            }
            //给list属性赋值
            self.list = [NSArray arrayWithArray:listArray];
        }
        if (dictionary[@"total"] != 0) {
            self.total = [dictionary[@"total"] integerValue];
        }
        
    }
    return self;
}

@end
