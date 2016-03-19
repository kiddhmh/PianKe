//
//  RadioMusicView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/19.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioMusicView.h"
#import "Masonry.h"
#import "RadioSecondListModel.h"
#import "UIImageView+WebCache.h"
#import "MusicManager.h"
#import "MusicView.h"

@interface RadioMusicView ()
/**
 *  配图
 */
@property (nonatomic,strong) UIImageView *coverImageView;
/**
 *  标题
 */
@property (nonatomic,strong) UILabel *titleLabel;
/**
 *  喜欢数
 */
@property (nonatomic,strong) UIButton *likeBtn;
/**
 *  评论数
 */
@property (nonatomic,strong) UIButton *commentBtn;

@property (nonatomic,strong) NSString *currentURL;

@property (nonatomic,strong) MusicView *musicView;

@end

@implementation RadioMusicView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //初始化子控件
        [self setupSubViews];
        
        //自动适配
        [self setupAutoLayout];
    }
    return self;
}


#pragma mark - 自动适配
- (void)setupAutoLayout
{
    __weak typeof(self)weakSelf = self;
    CGFloat padding = 30;
    CGFloat coverW = SCREENWIDTH - 2 * padding;
    [weakSelf.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).offset(padding);
        make.left.equalTo(weakSelf.mas_left).offset(padding);
        make.right.equalTo(weakSelf.mas_right).offset(-padding);
        make.height.mas_equalTo(coverW);
    }];
    
    [weakSelf.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.coverImageView.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.coverImageView);
        make.right.equalTo(weakSelf.coverImageView);
        make.height.mas_equalTo(padding);
    }];
    
    [weakSelf.likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.coverImageView.mas_left).offset(padding);
        make.top.equalTo(weakSelf.titleLabel.mas_bottom).offset(padding);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(60);
    }];
    
    [weakSelf.commentBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeBtn.mas_top);
        make.right.equalTo(weakSelf.coverImageView.mas_right).offset(-padding);
        make.size.mas_equalTo(CGSizeMake(60,20));
    }];
    
    [weakSelf.progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.likeBtn.mas_bottom).offset(padding);
        make.left.equalTo(weakSelf.likeBtn.mas_left);
        make.right.equalTo(weakSelf.commentBtn.mas_right);
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.height.mas_equalTo(3);
    }];
    
    [weakSelf.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.progressView.mas_right).offset(padding / 2);
        make.centerY.equalTo(weakSelf.progressView.mas_centerY);
        make.height.mas_equalTo(padding / 2);
        make.width.mas_equalTo(padding);
    }];
    
}


#pragma mark - 初始化子控件
- (void)setupSubViews
{
    [self addSubview:self.coverImageView];
    [self addSubview:self.likeBtn];
    [self addSubview:self.commentBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.progressView];
    [self addSubview:self.currentLabel];
}



#pragma mark - 懒加载
- (UIImageView *)coverImageView
{
    if (!_coverImageView) {
        _coverImageView = [[UIImageView alloc] init];
        _coverImageView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _coverImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textAlignment  =NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIButton *)likeBtn
{
    if (!_likeBtn) {
        _likeBtn = [[UIButton alloc] init];
        _likeBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_likeBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _likeBtn;
}


- (UIButton *)commentBtn
{
    if (!_commentBtn) {
        _commentBtn = [[UIButton alloc] init];
        _commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [_commentBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    }
    return _commentBtn;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleDefault];
        _progressView.trackTintColor = [UIColor groupTableViewBackgroundColor];
        _progressView.progressTintColor = [UIColor darkGrayColor];
    }
    return _progressView;
}

- (UILabel *)currentLabel
{
    if (!_currentLabel) {
        _currentLabel = [[UILabel alloc] init];
        _currentLabel.font = [UIFont systemFontOfSize:11];
        _currentLabel.textColor = [UIColor lightGrayColor];
    }
    return _currentLabel;
}


- (void)passRadioMessage:(RadioSecondListModel *)listModel andName:(NSString *)name
{
    if (self.musicView.isPlaying) {
        [self.musicView pause];
    }
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:Placholder];
    self.titleLabel.text = listModel.title;
    [self.likeBtn setTitle:@"💗 635" forState:UIControlStateNormal];
    [self.commentBtn setTitle:@"💬 91" forState:UIControlStateNormal];
    self.playing = YES;
    
    if (listModel.musicUrl != self.currentURL) {
        self.player = nil;
        self.player = [[MusicManager defaultManager] playingURLMusic:listModel.musicUrl];
        [self.player play];
        self.currentURL = listModel.musicUrl;
        self.playing = YES;
        
        //添加通知
        NSDictionary *info = @{
                               @"model" : listModel,
                               @"uname" : name,
                               @"player" : self.player
                               };
        [[NSNotificationCenter defaultCenter] postNotificationName:MHDidPlayMusicNotification object:nil userInfo:info];
    }
}

- (MusicView *)musicView{
    if (!_musicView) {
        _musicView = [[MusicView alloc] init];
    }
    return _musicView;
}


@end
