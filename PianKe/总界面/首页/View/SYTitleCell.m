//
//  SYTitleCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SYTitleCell.h"
#import "Masonry.h"
#import "list.h"
#import "UIImageView+WebCache.h"
#import "MusicView.h"
@implementation SYTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}


#pragma mark - 
#pragma mark - 自动适配
- (void)setup
{
    __weak typeof(self)vc = self;
    [vc.ennameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.mas_top).offset(Padding);
        make.left.equalTo(vc.mas_left).offset(Padding);
        make.right.equalTo(vc.mas_right).offset(-Padding);
        make.height.mas_equalTo(20);
    }];
    
    [vc.coverImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.ennameLabel.mas_bottom).offset(Padding);
        make.centerX.equalTo(vc.mas_centerX);
        make.left.equalTo(vc.ennameLabel.mas_left);
    }];
    
    [vc.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.coverImageView.mas_bottom).offset(Padding);
        make.left.equalTo(vc.ennameLabel.mas_left);
        make.right.equalTo(vc.ennameLabel.mas_right);
        make.height.mas_equalTo(40);
    }];
    
    [vc.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.titleLabel.mas_bottom).offset(Padding);
        make.left.equalTo(vc.titleLabel.mas_left);
        make.right.equalTo(vc.titleLabel.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    [vc.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.contentLabel.mas_bottom).offset(Padding);
        make.right.equalTo(vc.ennameLabel.mas_right);
        make.height.equalTo(vc.ennameLabel.mas_height);
        make.width.mas_equalTo(60);
        make.bottom.mas_equalTo(vc.mas_bottom).offset(-Padding);
    }];
    
    [vc.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.and.bottom.equalTo(vc);
        make.height.mas_equalTo(1);
    }];
}


- (void)setListModel:(list *)listModel
{
    self.musicView.hidden = YES;
    self.ennameLabel.text = [NSString stringWithFormat:@"%@·%@",listModel.name,listModel.enname];
    [self.coverImageView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    self.titleLabel.text = listModel.title;
    self.contentLabel.text = listModel.content;
    [self.likeButton setTitle:[NSString stringWithFormat:@"💗%ld",listModel.like] forState:UIControlStateNormal];
}

@end
