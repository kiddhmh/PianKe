//
//  SearchBar_textField.m
//  真丶微博
//
//  Created by ma c on 16/1/13.
//  Copyright (c) 2016年 cmcc. All rights reserved.
//

#import "SearchBar_textField.h"
#import "UIView+Frame.h"

@implementation SearchBar_textField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"搜索";
        
        self.layer.cornerRadius = 10;
        
        //通过init来创建初始化绝大部分控件。控件都是没有尺寸
        UIImageView *searchIcon = [[UIImageView alloc] init];
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //设置拉伸模式
        searchIcon.width = 30;
        searchIcon.height = 30;
        searchIcon.contentMode = UIViewContentModeCenter;
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)searchBar
{
    return [[self alloc] init];
}


@end
