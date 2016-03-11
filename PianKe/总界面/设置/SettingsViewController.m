//
//  SettingsViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/26.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SettingsViewController.h"
#import "UIBarButtonItem+Helper.h"
#import "MMDrawerBarButtonItem.h"
#import "UIViewController+MMDrawerController.h"
@interface SettingsViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  工具条
 */
@property (nonatomic,strong) UITableView *MessagetableView;
/**
 *  cell的数据源
 */
@property (nonatomic,strong) NSArray *messageArray;
/**
 *  footerView
 */
@property (nonatomic,strong) UILabel *footerLabel;

@end

@implementation SettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavItem];
    
    NSArray *first = [NSArray arrayWithObjects:@"通用设置",@"推荐片刻",@"给个好评", nil];
    NSArray *second = [NSArray arrayWithObjects:@"关于与片刻",@"意见反馈",@"常见问题",@"使用指南", nil];
    NSArray *third = [NSArray arrayWithObjects:@"退出当前账号", nil];
    self.messageArray = [NSArray arrayWithObjects:first,second,third, nil];
    
    [self.view addSubview:self.MessagetableView];
    UIView *footer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 100)];
    [footer addSubview:self.footerLabel];
    self.footerLabel.frame = CGRectMake(SCREENWIDTH / 3,30, SCREENWIDTH / 3, 40);
    self.MessagetableView.tableFooterView = footer;
}


#pragma mark - 数据源方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *temp = self.messageArray[section];
    return temp.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *title = [[self.messageArray objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 15;
}

#pragma mark - 设置导航栏
- (void)setupNavItem
{
    //设置导航栏唤醒抽屉按钮
    MMDrawerBarButtonItem *leftItem = [MMDrawerBarButtonItem itemWithNormalIcon:@"menu" highlightedIcon:nil target:self action:@selector(leftDrawerButtonPress:)];
    
    //设置紧挨着左侧按钮的标题按钮
    MMDrawerBarButtonItem *titleItem = [MMDrawerBarButtonItem itemWithTitle:@"设置" target:nil action:nil];
    
    self.navigationItem.leftBarButtonItems = @[leftItem,titleItem];
}

- (void)leftDrawerButtonPress:(MMDrawerBarButtonItem *)item
{
    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}


#pragma mark -
#pragma mark - 懒加载
-(UITableView *)MessagetableView
{
    if (!_MessagetableView) {
        _MessagetableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStyleGrouped];
        _MessagetableView.delegate = self;
        _MessagetableView.dataSource = self;
        _MessagetableView.backgroundColor = [UIColor whiteColor];
        _MessagetableView.separatorColor = [UIColor groupTableViewBackgroundColor];
        _MessagetableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _MessagetableView;
}

- (NSArray *)messageArray
{
    if (!_messageArray) {
        _messageArray = [NSArray array];
    }
    return _messageArray;
}


- (UILabel *)footerLabel
{
    if (!_footerLabel) {

        _footerLabel = [[UILabel alloc] init];
        _footerLabel.font = [UIFont systemFontOfSize:12];
        _footerLabel.textColor = [UIColor darkGrayColor];
        _footerLabel.text = @"当前版本号： V3.0.6";
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.backgroundColor = [UIColor whiteColor];
    }
    return _footerLabel;
}

@end
