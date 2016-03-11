//
//  SQHeaderView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQHeaderView.h"
#import "Masonry.h"

@interface SQHeaderView ()
/**
 *  分段控制器
 */
@property (nonatomic,strong) UISegmentedControl *segment;
@end

@implementation SQHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupSubView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)setupSubView
{
    NSArray *items = @[@"Hot",@"New"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:items];
    segment.tintColor = RGB(55, 207, 16);
    segment.selectedSegmentIndex = 0;
    [segment addTarget:self action:@selector(changeData:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segment];
    self.segment = segment;
    
    //自动适配
    __weak typeof(self)view = self;
    [view.segment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(view);
        make.left.equalTo(view.mas_left).offset(SCREENWIDTH / 3);
        make.right.equalTo(view.mas_right).offset(-SCREENWIDTH / 3);
        make.height.mas_equalTo(25);
    }];
}


- (void)changeData:(UISegmentedControl *)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    if ([self.delegate respondsToSelector:@selector(sqHeaderDidSelectedSegmentIndex:SegmentControl:)]) {
        [self.delegate sqHeaderDidSelectedSegmentIndex:index SegmentControl:segment];
    }
}

@end
