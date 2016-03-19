//
//  LPXQheadView.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/4.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "LPXQheadView.h"
#import "LPXQheadModel.h"
#import "Masonry.h"
#import "UIImageView+SDWedImage.h"
#import "UIImageView+WebCache.h"
#import "SQHotListModel.h"
#import "userinfo.h"
#import "SQHotListModel.h"
@implementation LPXQheadView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.titleLabel];
        [self addSubview:self.fromButton];
        [self addSubview:self.moreButton];
        [self addSubview:self.louzhuImageView];
        [self addSubview:self.louzhuLabel];
        [self addSubview:self.addtimeLabel];
        
        __weak typeof(self)vc = self;
        [_louzhuLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(vc.louzhuImageView.mas_right).offset(10);
            make.centerY.equalTo(vc.louzhuImageView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(SCREENWIDTH * 0.8, 20));
        }];
    }
    return self;
}

- (void)loadData:(LPXQheadModel *)headModel
{
    self.titleLabel.text = headModel.title;
    
    self.addtimeLabel.text = headModel.addtime;
    
    if (headModel.uname) {
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"from: %@",headModel.uname] attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:10]}];
        [att addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:11],
                             NSForegroundColorAttributeName : RGB(55, 207, 16)
                             } range:NSMakeRange(6, headModel.uname.length)];
        [self.fromButton setAttributedTitle:att forState:UIControlStateNormal];
    }else{
        [self.fromButton setTitle:@"from: " forState:UIControlStateNormal];
    }

    [self.louzhuImageView downloadImage:headModel.icon place:[UIImage imageNamed:@"timeline_image_placeholder"]];
}


-(void)setHotList:(SQHotListModel *)hotList
{
    _hotList = hotList;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.text = hotList.title;
    self.titleLabel.numberOfLines = 0;
    
    self.addtimeLabel.text = hotList.addtime_f;
    
    [self.louzhuImageView sd_setImageWithURL:[NSURL URLWithString:hotList.userinfo.icon] placeholderImage:Placholder];
    
    [self.fromButton setTitle:@"from: " forState:UIControlStateNormal];
    [self.fromButton setTitleColor:RGB(55, 207, 16) forState:UIControlStateNormal];
    
    _louzhuLabel.layer.borderWidth = 0;
    NSDictionary *att = @{
                          NSForegroundColorAttributeName : [UIColor darkGrayColor],
                          NSFontAttributeName : [UIFont systemFontOfSize:12]
                          };
    NSAttributedString *attri = [[NSAttributedString alloc] initWithString:hotList.userinfo.uname attributes:att];
    self.louzhuLabel.attributedText = attri;
}


#pragma mark -
#pragma mark - 懒加载
- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(12, 40, SCREENWIDTH-20,45)];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:22];
    }
    return _titleLabel;
}

- (UIButton *)fromButton
{
    if (!_fromButton) {
        _fromButton = [[UIButton alloc] init];
        _fromButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        _fromButton.frame = CGRectMake(-5, 10, SCREENWIDTH * 0.3, 20);
        _fromButton.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _fromButton;
}

- (UIButton *)moreButton
{
    if (!_moreButton) {
        _moreButton = [[UIButton alloc] init];
        [_moreButton setTitle:@"More·小姐 ->" forState:UIControlStateNormal];
        [_moreButton setTitleColor:RGB(55, 207, 16) forState:UIControlStateNormal];
        _moreButton.frame = CGRectMake(SCREENWIDTH * 0.73, 10, SCREENWIDTH * 0.3 - 10, 20);
        _moreButton.titleLabel.textAlignment = NSTextAlignmentRight;
        _moreButton.titleLabel.font = [UIFont systemFontOfSize:11];
    }
    return _moreButton;
}

- (UIImageView *)louzhuImageView
{
    if (!_louzhuImageView) {
        _louzhuImageView = [[UIImageView alloc] init];
        _louzhuImageView.frame = CGRectMake(12, 95, 50, 50);
        _louzhuImageView.contentMode = UIViewContentModeScaleAspectFit;
        _louzhuImageView.layer.cornerRadius = 25;
        _louzhuImageView.layer.masksToBounds = YES;
    }
    return _louzhuImageView;
}


- (UILabel *)louzhuLabel
{
    if (!_louzhuLabel) {
        _louzhuLabel = [[UILabel alloc] init];
        
        NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:@"片刻 楼主" attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:12]}];
        [att addAttributes:@{
                             NSFontAttributeName : [UIFont systemFontOfSize:10],
                             NSForegroundColorAttributeName : [UIColor orangeColor],
                             
                             } range:NSMakeRange(3, 2)];
        [_louzhuLabel setAttributedText:att];
        
        _louzhuLabel.layer.borderWidth = 1;
        _louzhuLabel.layer.borderColor = [UIColor orangeColor].CGColor;
    }
    return _louzhuLabel;
}


- (UILabel *)addtimeLabel
{
    if (!_addtimeLabel) {
        _addtimeLabel = [[UILabel alloc] init];
        _addtimeLabel.font = [UIFont systemFontOfSize:12];
        _addtimeLabel.textColor = [UIColor darkGrayColor];
        _addtimeLabel.textAlignment = NSTextAlignmentRight;
        _addtimeLabel.frame = CGRectMake(SCREENWIDTH * 0.7 - 2, 110, SCREENWIDTH * 0.3 - 10, 20);
    }
    return _addtimeLabel;
}

@end
