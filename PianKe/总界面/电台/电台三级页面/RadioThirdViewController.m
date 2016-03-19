//
//  RadioThirdViewController.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/19.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioThirdViewController.h"
#import "RadioSecondListModel.h"
#import "RadioSecondRadioInfo.h"
#import "RadioMusicView.h"
#import "MusicManager.h"
#import "RadioSecondListModel.h"
@interface RadioThirdViewController ()
@property (nonatomic,strong) RadioMusicView *musicView;
/**
 *  传递模型
 */
@property (nonatomic,strong) RadioSecondListModel *dataModel;
@property (nonatomic,copy) NSString *uname;
@property (nonatomic,strong) UIButton *backBtn;
@end

@implementation RadioThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.backBtn];
    
    [self.view addSubview:self.musicView];
    [self.musicView passRadioMessage:self.dataModel andName:self.uname];
}


- (RadioMusicView *)musicView
{
    if (!_musicView) {
        _musicView = [[RadioMusicView alloc] initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT * 7)];
    }
    return _musicView;
}

- (void)passModel:(RadioSecondListModel *)model andName:(NSString *)name
{
    self.dataModel = model;
    self.uname = name;
}

- (UIButton *)backBtn
{
    if (!_backBtn) {
        _backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10,30, 60, 30)];
        [_backBtn setTitle:@"返回" forState:UIControlStateNormal];
        _backBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_backBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [_backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}

- (void)back
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
