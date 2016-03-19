//
//  ReadSecondCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ReadSecondCell.h"
#import "ReadSecondListModel.h"
#import "UIImageView+WebCache.h"
@interface ReadSecondCell ()
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
/**
 *  配图
 */
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
/**
 *  内容
 */
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;


@end

@implementation ReadSecondCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    NSString *ID = @"ReadSecond";
    ReadSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"ReadSecondCell" owner:nil options:nil]lastObject];
    }
    return cell;
}

- (void)setListModel:(ReadSecondListModel *)listModel
{
    _listModel = listModel;
    [self.photoImageView sd_setImageWithURL:[NSURL URLWithString:listModel.coverimg] placeholderImage:Placholder];
    self.titleLabel.text = listModel.title;
    self.contentLabel.text = listModel.content;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}


@end
