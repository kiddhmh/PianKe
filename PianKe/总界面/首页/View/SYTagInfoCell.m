//
//  SYTagInfoCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SYTagInfoCell.h"
#import "Masonry.h"
#import "list.h"
#import "UIImageView+WebCache.h"
#import "Tag_Info.h"
#import "MusicView.h"
@implementation SYTagInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setup];
    }
    return self;
}


- (void)setup
{
    //给子控件设置约束
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
        make.bottom.equalTo(vc.contentLabel.mas_top).offset(-Padding);
    }];
    
    [vc.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.coverImageView.mas_bottom).offset(Padding);
        make.left.equalTo(vc.coverImageView.mas_left);
        make.right.equalTo(vc.coverImageView.mas_right);
        make.height.mas_equalTo(60);
    }];
    
    [vc.tag_infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(vc.contentLabel.mas_bottom).offset(Padding);
        make.left.equalTo(vc.ennameLabel.mas_left);
        make.right.equalTo(vc.likeButton.mas_left);
        make.height.equalTo(vc.ennameLabel.mas_height);
    }];
    
    [vc.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60);
        make.centerY.equalTo(vc.tag_infoLabel.mas_centerY);
        make.top.equalTo(vc.contentLabel.mas_bottom).offset(Padding);
        make.bottom.mas_equalTo(vc.mas_bottom).offset(-Padding);
        make.right.mas_equalTo(-Padding);
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
    self.contentLabel.text = listModel.content;
    self.tag_infoLabel.text = [NSString stringWithFormat:@"%@%ld",listModel.tag_info.tag,listModel.tag_info.count];
    [self.likeButton setTitle:[NSString stringWithFormat:@"💗%ld",listModel.like] forState:UIControlStateNormal];
}

@end
