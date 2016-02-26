//
//  PKLaunchingViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "PKLaunchingViewController.h"
#import "Masonry.h"
#import "HttpTool.h"
#import "HttpRequestMacro.h"
#import "SVProgressHUD.h"
#import "AllControllersTool.h"

#define LAUNCHING_IMAGEVIEW_NAME @"launchingName"

@interface PKLaunchingViewController ()
/**
 *  背景图片
 */
@property (nonatomic,strong) UIImageView *launchingBackgroundImageView;
/**
 *  logo图片
 */
@property (nonatomic,strong) UIImageView *markImageView;
/**
 * 动画关键定时器
 */
@property (nonatomic,strong) NSTimer *launchingTimer;

@end

@implementation PKLaunchingViewController

#pragma mark -
#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    //加载背景（默认系统的图片）
    [self.view addSubview:self.launchingBackgroundImageView];
    [self.view addSubview:self.markImageView];
    
    //添加约束，自动布局(Masonry)
    //为了避免使用block的时候出现循环引用，使用__weak
    __weak typeof(self)vc = self;
    [self.markImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //约束相对宽高固定
        CGFloat width = vc.view.bounds.size.width * 0.5;
        CGFloat height = width * 0.4;
        make.size.mas_equalTo(CGSizeMake(width, height));
        
        //约束相对坐标固定
        CGFloat viewHeight = vc.view.bounds.size.height /4;
        make.centerX.equalTo(vc.view.mas_centerX);
        make.centerY.mas_equalTo(vc.view.mas_centerY).offset(-viewHeight);
    }];
    
    //先加载本地保存的启动图
    [self loadLaunchingImageView];
    
    //向服务器发起请求，获取最新的Launching启动图，并保存到本地，方便下次启动时使用
    [self GetNewImageView];
    
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //让背景动起来，先加载完毕，将要出现的时候再执行动画
    
    //设置动画效果
    [UIView animateWithDuration:3.0 animations:^{
        
        CGRect rect = self.launchingBackgroundImageView.frame;
        rect.origin = CGPointMake(-100, -100);
        rect.size = CGSizeMake(rect.size.width + 200, rect.size.height + 200);
        _launchingBackgroundImageView.frame = rect;
        
    } completion:^(BOOL finished) {
       
        //动画结束之后直接进入良品界面
        [AllControllersTool createViewControllerWithIndex:0];
    }];

    
}

#pragma mark -
#pragma mark - 加载方法
/**
 *  加载上次保存的启动图片
 */
- (void)loadLaunchingImageView
{
    NSData *imageData = [[NSUserDefaults standardUserDefaults] objectForKey:LAUNCHING_IMAGEVIEW_NAME];
    
    if (imageData) { // 判断，有值，设置启动图片
    self.launchingBackgroundImageView.image = [UIImage imageWithData:imageData];
    }
}


/**
 *  发起网络请求，获取最新的启动图片
 */
- (void)GetNewImageView
{
    [HttpTool postWithPath:HTTP_LAUNCH_SCREEN
                    params:@{
                             @"client" : @2
                             }
                   success:^(id JSON) {
                       //网络请求成功后的block回调
                       //获取图片的url
                       NSString *imageUrl = [[JSON objectForKey:@"data"] objectForKey:@"picurl"];
                       
                       //获取图片的data
                       NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
                       
                       //将获取的data本地保存到plist文件当中
                       [[NSUserDefaults standardUserDefaults] setObject:imageData forKey:LAUNCHING_IMAGEVIEW_NAME];
                       
                   } failure:^(NSError *error) {
                       //网络请求失败后的block回调
                       [SVProgressHUD showErrorWithStatus:@"网络不给力，请检查网络设置"];
                   }];
}


#pragma mark -
#pragma mark - 懒加载
/**
 *  背景图
 */
- (UIImageView *)launchingBackgroundImageView
{
    if (!_launchingBackgroundImageView) {
        _launchingBackgroundImageView = [[UIImageView alloc] init];
        [_launchingBackgroundImageView setFrame:self.view.frame];
        [_launchingBackgroundImageView setBackgroundColor:[UIColor cyanColor]];
        [_launchingBackgroundImageView setImage:[UIImage imageNamed:@"defaultCover"]];
    }
    return _launchingBackgroundImageView;
}


/**
 *  logo
 */
- (UIImageView *)markImageView
{
    if (!_markImageView) {
        _markImageView = [[UIImageView alloc] init];
        [_markImageView setImage:[UIImage imageNamed:@"ic_splash_logo"]];
        [_markImageView setBackgroundColor:[UIColor clearColor]];
    }
    return _markImageView;
}



@end
