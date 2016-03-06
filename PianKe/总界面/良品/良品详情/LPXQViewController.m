//
//  LPXQViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/4.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPXQViewController.h"
#import "HttpTool.h"
#import "SVProgressHUD.h"
#import "LoadingView.h"
#import "NSString+ChangeHtmlString.h"
#import "LPXQheadView.h"
#import "LPXQheadModel.h"

@interface LPXQViewController ()<UIWebViewDelegate>
/**
 *  loadingView
 */
@property (nonatomic,strong) LoadingView *waitView;
/**
 *  商品信息
 */
@property (nonatomic,copy) NSString *conntentid;
/**
 *  HTML 字符串(XML)
 */
@property (nonatomic,copy) NSString *htmlUrlString;
/**
 *  主体滑动视图
 */
@property (nonatomic,strong) UIScrollView *mainScrollView;
/**
 *  头部视图
 */
@property (nonatomic,strong) LPXQheadView *headView;
/**
 *  头部视图的数据模型
 */
@property (nonatomic,strong)  LPXQheadModel *headModel;
/**
 *  良品网页视图
 */
@property (nonatomic,strong) UIWebView *webView;



@end

@implementation LPXQViewController

#pragma mark -
#pragma mark - 从上个界面获取商品id
- (void)initWithId:(NSString *)contentid
{
    self.conntentid = contentid;
}


#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //添加loading
    self.waitView = [[LoadingView alloc] initWithFrame:self.view.frame];
    [self.waitView showLoadingTo:[UIApplication sharedApplication].keyWindow];
    
    [self sendHttpRequest];
}


- (void)sendHttpRequest
{
    //进入详情界面，发起网络请求，并准备加载数据
    NSDictionary *param = @{
                            @"contentid" : self.conntentid,
                            @"client" : @"2"
                            };
    [HttpTool postWithPath:@"group/posts_info" params:param success:^(id JSON) {
        //整体返回数据
        NSDictionary *allDictionary = JSON;
        
        //拿到data对应的字典
        allDictionary = JSON[@"data"];
        NSDictionary *postsinfoDic = allDictionary[@"postsinfo"];
        
        //从postsinfo字典当中获取html字符串
        NSString *oldString = postsinfoDic[@"html"];
        self.htmlUrlString = [NSString  getHtmlString:oldString];
        
        //获取头部视图的数据
        self.headModel = [[LPXQheadModel alloc] initWithDictionary:postsinfoDic];
        
        //移除loadingView
        [self.waitView dismiss];
        
        //添加子控件
        [self.view addSubview:self.mainScrollView];
        [self.mainScrollView addSubview:self.headView];
        [self.mainScrollView addSubview:self.webView];

    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络超时"];
        [self.waitView dismiss];
    }];
}


#pragma mark - 
#pragma mark - WebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //webView的高度适配
    //(1),将webView高度变成可见
    CGRect rect = webView.frame;
    rect.size.height = 1;
    webView.frame = rect;
    
    //(2),适配webView的内容高度
    rect.size.height = webView.scrollView.contentSize.height;
    webView.frame = rect;
    
    [self.mainScrollView setContentSize:CGSizeMake(0, webView.frame.size.height + self.headView.frame.size.height + 64)];
}


#pragma mark -
#pragma mark - 懒加载
- (UIScrollView *)mainScrollView
{
    if (!_mainScrollView) {
        _mainScrollView = [[UIScrollView alloc] init];
        _mainScrollView.frame = CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT);
        _mainScrollView.contentSize = CGSizeMake(0, 9999);
    }
    return _mainScrollView;
}


- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        _webView.frame = CGRectMake(10, 180, SCREENWIDTH - 20, 0);
        _webView.delegate = self;
        
        //加载网页内容
        [_webView loadHTMLString:self.htmlUrlString baseURL:nil];
    }
    return _webView;
}


- (UIView *)headView
{
    if (!_headView) {
        _headView = [[LPXQheadView alloc] init];
        _headView.frame = CGRectMake(0, 0,SCREENWIDTH, 180);
        
        //注意，model所需要的数据在JSON的哪一层
        [_headView loadData:self.headModel];
        
    }
    return _headView;
}

@end

