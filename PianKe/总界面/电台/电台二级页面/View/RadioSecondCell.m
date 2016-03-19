//
//  RadioSecondCell.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/18.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "RadioSecondCell.h"
#import "RadioSecondListModel.h"
#import "UIImageView+WebCache.h"
@interface RadioSecondCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
- (IBAction)PlayOrPause:(UIButton *)sender;

@end

@implementation RadioSecondCell


+ (instancetype)cellWithtableView:(UITableView *)tableView
{
    static NSString *ID = @"secondCell";
    RadioSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"RadioSecondCell" owner:nil options:nil]lastObject];
    }
    return cell;
}


- (IBAction)PlayOrPause:(UIButton *)sender {
    sender.selected = ![sender isSelected];
    NSLog(@"%@",self.radioListModel.musicUrl);
}

- (void)setRadioListModel:(RadioSecondListModel *)radioListModel
{
    _radioListModel = radioListModel;
    
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:radioListModel.coverimg] placeholderImage:Placholder];
    self.titleLabel.text = radioListModel.title;
    self.likeLabel.text = [NSString stringWithFormat:@"🔊 %ld",radioListModel.musicVisit];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    
}

@end
