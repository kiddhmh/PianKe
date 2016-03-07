//
//  SPTableView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SPTableView.h"
#import "SPTableViewCell.h"
#import "ListModelFrame.h"

@interface SPTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SPTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [[UIView alloc] init];
    }
    return self;
}

#pragma mark -
#pragma makr - 表格数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.FrameArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SPTableViewCell *cell = [SPTableViewCell cellWith:tableView];
    ListModelFrame *frame = self.FrameArray[indexPath.row];
    cell.listFrame = frame;
    
    return cell;
}


#pragma mark - 
#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.FrameArray.count == 0) return 44;
    ListModelFrame *frame = self.FrameArray[indexPath.row];
    return frame.cellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击对应额cell跳转到二级页面
    ListModelFrame *frame = self.FrameArray[indexPath.row];
    self.enterBlock(frame);
}


@end
