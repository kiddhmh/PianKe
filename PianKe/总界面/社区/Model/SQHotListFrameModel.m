//
//  SQHotListFrameModel.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/9.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "SQHotListFrameModel.h"
#import "SQHotListModel.h"
#import "counterList.h"
#import "NSString+Helper.h"
@implementation SQHotListFrameModel

- (void)setHotListModel:(SQHotListModel *)hotListModel
{
    _hotListModel = hotListModel;
    
    //标题
    CGSize titleSize = [hotListModel.title sizeWithFont:HotTitleFont maxW:SCREENWIDTH - 2 * CellBorderW];
    self.titleLabelF = CGRectMake(CellBorderW, CellBorderW, titleSize.width, titleSize.height);
    
    //配图(如果有的话)
    CGFloat contentidX = 0;
    CGFloat contemtidY = 0;
    CGFloat imgY = CGRectGetMaxY(self.titleLabelF) + CellBorderW;
    if (hotListModel.coverimg.length) {
        CGFloat imgW = 75;
        CGFloat imgH = 75;
        CGFloat imgX = CellBorderW;
        self.coverImageViewF = CGRectMake(imgX, imgY, imgW, imgH);
        
        contentidX = CGRectGetMaxX(self.coverImageViewF) + CellBorderW;
        contemtidY = imgY;
    }else{
        contentidX = CellBorderW;
        contemtidY = CGRectGetMaxY(self.titleLabelF) + CellBorderW;
    }

    //内容
    CGSize contentidSize = CGSizeMake(SCREENWIDTH - contentidX - CellBorderW, 60);
    self.contentidLabelF = CGRectMake(contentidX, contemtidY, contentidSize.width, contentidSize.height);
    
    //添加时间
    CGFloat timeX = CellBorderW;
    CGFloat timeY = 0;
    if (hotListModel.coverimg.length){
        timeY = CGRectGetMaxY(self.coverImageViewF) + CellBorderW;
    }else{
        timeY = CGRectGetMaxY(self.contentidLabelF) + CellBorderW;
    }
    CGSize timeSize = [hotListModel.addtime_f sizeWithFont:HotTimeFont];
    self.addtimelabelF = CGRectMake(timeX, timeY, timeSize.width, timeSize.height);
    
    //评论
    CGFloat commentH = self.addtimelabelF.size.height;
    CGFloat commentW = commentH * 4;
    CGFloat commentX = SCREENWIDTH - commentW - CellBorderW;
    CGFloat commentY = timeY;
    self.commentLabelF = CGRectMake(commentX, commentY, commentW, commentH);
    
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.addtimelabelF) + 2 * CellBorderW;
    
    //底部的线
    self.lineF = CGRectMake(0, self.cellHeight - 1, SCREENWIDTH, 1);
}

@end
