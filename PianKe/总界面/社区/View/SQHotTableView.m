//
//  SQHotTableView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQHotTableView.h"
#import "SQHotTableViewCell.h"
#import "SQHotListFrameModel.h"
@interface SQHotTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation SQHotTableView

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
    SQHotTableViewCell *cell = [SQHotTableViewCell cellWith:tableView];
    SQHotListFrameModel *frame = self.FrameArray[indexPath.row];
    cell.HotFrameModel = frame;
    
    return cell;
}


#pragma mark -
#pragma mark - 表格代理方法
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.FrameArray.count == 0) return 44;
    SQHotListFrameModel *frame = self.FrameArray[indexPath.row];
    return frame.cellHeight;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //点击对应额cell跳转到二级页面
    SQHotListFrameModel *FrameModel = self.FrameArray[indexPath.row];
    self.block(FrameModel.hotListModel);
}


@end
