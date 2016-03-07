//
//  SPXQViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SPXQViewController.h"
#import "ListModel.h"
#import "SPXQHeaderView.h"
@interface SPXQViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  数据模型
 */
@property (nonatomic,strong) ListModel *listModel;

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) SPXQHeaderView *headerView;

@end

@implementation SPXQViewController

#pragma mark -
#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    self.headerView = [[SPXQHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
    self.headerView.listModel = self.listModel;
    self.tableView.tableHeaderView = self.headerView;
}



#pragma mark - 
#pragma mark - 传递模型方法
- (void)passListModel:(ListModel *)listModel
{
    self.listModel = listModel;
}


#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

#pragma mark - 代理方法

@end
