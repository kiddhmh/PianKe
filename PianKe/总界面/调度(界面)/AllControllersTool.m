//
//  AllControllersTool.m
//  PianKe
//
//  Created by 胡明昊 on 16/2/25.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "AllControllersTool.h"
#import "GoodPorductsViewController.h"
#import "MMDrawerController.h"
#import "LeftMenuViewController.h"
#import "MMDrawerVisualState.h"
#import "HMHNavigationController.h"
#import "ReadingViewController.h"
#import "SettingsViewController.h"
#import "LPViewController.h"
#import "SPViewController.h"
#import "SQViewController.h"
#import "RadioViewController.h"

@interface AllControllersTool ()
@property (nonatomic,strong) MMDrawerController *drawerController;
@property (nonatomic,strong) LeftMenuViewController *menuController;

@end

@implementation AllControllersTool

- (LeftMenuViewController *)menuController
{
    if (!_menuController) {
        _menuController = [[LeftMenuViewController alloc] init];
    }
    return _menuController;
}

- (MMDrawerController *)drawerController
{
    if (!_drawerController) {
        _drawerController = [[MMDrawerController alloc] init];
        _drawerController.showsShadow = YES;
        [_drawerController setMaximumLeftDrawerWidth:[UIScreen mainScreen].bounds.size.width * 0.75];
        [_drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
        [_drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
        
        [_drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
            
            MMDrawerControllerDrawerVisualStateBlock block = [MMDrawerVisualState slideVisualStateBlock];
            if (block) {
                block(drawerController,drawerSide,percentVisible);
            }
        }];
        
        [_drawerController setLeftDrawerViewController:self.menuController];
    }

    return _drawerController;
}

#pragma mark -
#pragma mark - 调度方法
+ (void)createViewControllerWithIndex:(NSUInteger)index
{
    //获取当前类的(唯一)对象
    AllControllersTool *dispatchTool = [AllControllersTool shareOpenController];
    
    //用当前类的对象 执行实际选择执行的方法
    [dispatchTool openViewControllerWithIndex:index];
}


+ (instancetype)shareOpenController
{
    //获取到调度的唯一对象
    static AllControllersTool *tempTool = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tempTool = [[AllControllersTool alloc] init];
    });
    
    return tempTool;
}


#pragma mark -
#pragma mark - 实际选择执行的方法
- (void)openViewControllerWithIndex:(NSUInteger)index
{
    
    switch (index) {
        case 0:
        {//第一次加载，加载[首页]界面
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                GoodPorductsViewController *goodVC = [[GoodPorductsViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:goodVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 1:
        {//第一次加载，加载[首页]界面
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                RadioViewController *radioVC = [[RadioViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:radioVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 2:
            //第一次加载，加载[阅读]界面
        {
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                ReadingViewController *readVC = [[ReadingViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:readVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 3:
            //第一次加载，加载[设置]界面
        {
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                SQViewController *sqVC = [[SQViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:sqVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
            case 4:
            //第一次加载，加载[碎片]页面 SPViewController
        {
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                SPViewController *spVC = [[SPViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:spVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 5:
            //第一次加载，加载[良品]页面 LPViewController
        {
            static HMHNavigationController *navVC = nil;
            static dispatch_once_t onceToken;
            dispatch_once(&onceToken, ^{
                LPViewController *lpVC = [[LPViewController alloc] init];
                navVC = [[HMHNavigationController alloc] initWithRootViewController:lpVC];
            });
            
            [self.drawerController setCenterViewController:navVC];
            //切换根控制器
            [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
            [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
            
            //关闭抽屉控制器
            [self.drawerController closeDrawerAnimated:YES completion:nil];
        }
            break;
        case 6:
            //第一次加载，加载[设置]界面
            {
                static HMHNavigationController *navVC = nil;
                static dispatch_once_t onceToken;
                dispatch_once(&onceToken, ^{
                    SettingsViewController *setVC = [[SettingsViewController alloc] init];
                    navVC = [[HMHNavigationController alloc] initWithRootViewController:setVC];
                });
                
                [self.drawerController setCenterViewController:navVC];
                //切换根控制器
                [UIApplication sharedApplication].keyWindow.rootViewController = self.drawerController;
                [[UIApplication sharedApplication].keyWindow makeKeyAndVisible];
                
                //关闭抽屉控制器
                [self.drawerController closeDrawerAnimated:YES completion:nil];
            }
            break;
        default:
            break;
    }
}

@end
