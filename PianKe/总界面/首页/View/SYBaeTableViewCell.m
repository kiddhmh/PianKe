//
//  SYBaeTableViewCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/2.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SYBaeTableViewCell.h"
#import "list.h"
#import "MusicView.h"
@implementation SYBaeTableViewCell

/**
 *  获取数据类型对应的cell
 */
+ (NSString *)cellIdentifierForRow:(list *)listModel
{
    
    if (listModel.songid > 0){
        return @"SYMusicCell";
    }else if (listModel.tag_info){
        return @"SYTagInfoCell";
    }else {
        return @"SYTitleCell";
    }
}


#pragma mark -
#pragma mark - 初始化子控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.ennameLabel = [[UILabel alloc] init];
        self.ennameLabel.backgroundColor = [UIColor whiteColor];
        self.ennameLabel.font = [UIFont systemFontOfSize:10];
        self.ennameLabel.textColor = [UIColor lightGrayColor];
        self.ennameLabel.numberOfLines = 0;
        [self.contentView addSubview:self.ennameLabel];
        
        self.coverImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.coverImageView];
        
        self.musicView = [[MusicView alloc] init];
        [self.contentView addSubview:self.musicView];
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.backgroundColor = [UIColor whiteColor];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.titleLabel.textColor = [UIColor blackColor];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        
        self.contentLabel = [[UILabel alloc] init];
        self.contentLabel.backgroundColor = [UIColor whiteColor];
        self.contentLabel.textColor = [UIColor darkGrayColor];
        self.contentLabel.font = [UIFont systemFontOfSize:13];
        self.contentLabel.numberOfLines = 0;
        [self.contentView addSubview:self.contentLabel];
        
        self.tag_infoLabel = [[UILabel alloc] init];
        self.tag_infoLabel.backgroundColor = [UIColor whiteColor];
        self.tag_infoLabel.font = [UIFont systemFontOfSize:10];
        self.tag_infoLabel.textColor = [UIColor lightGrayColor];
        self.tag_infoLabel.numberOfLines = 0;
        [self.contentView addSubview:self.tag_infoLabel];
        
        self.likeButton = [[UIButton alloc] init];
        [self.likeButton setBackgroundColor:[UIColor whiteColor]];
        [self.likeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        self.likeButton.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.contentView addSubview:self.likeButton];
        
        self.lineView = [UIView new];
        self.lineView.backgroundColor = RGB(238, 238, 238);
        [self.contentView addSubview:self.lineView];
        
        self.highlighted = NO;
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

@end
