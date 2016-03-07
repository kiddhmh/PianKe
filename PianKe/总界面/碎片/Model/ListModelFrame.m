//
//  ListModelFrame.m
//  PianKe
//
//  Created by 胡明昊 on 16/3/7.
//  Copyright © 2016年 CMCC. All rights reserved.
//

#import "ListModelFrame.h"
#import "NSString+Helper.h"
#import "UIView+Frame.h"
#import "ListModel.h"
#import "userinfo.h"
#import "CoverimgTool.h"

@implementation ListModelFrame

- (void)setListM:(ListModel *)listM
{
    _listM = listM;
    userinfo *userM = listM.userinfo;
    
    //重写setter方法计算cell里面内容的高度
    //头像
    CGFloat iconH = 50;
    self.iconF = CGRectMake(CellBorderW, CellBorderW, iconH, iconH);
    
    //昵称
    CGSize unameSize = [userM.uname sizeWithFont:LISTUNAMEFONT];
    CGFloat unameX = CGRectGetMaxX(self.iconF) + CellBorderW;
    CGFloat unameY = (iconH / 2 + CellBorderW) - unameSize.height / 2;
    self.unameF = CGRectMake(unameX,unameY, unameSize.width, unameSize.height);
    
    //发布时间
    CGFloat addtimeY = unameY;
    CGSize addtimeSize = [listM.addtime_f sizeWithFont:LISTTIMEFONT];
    CGFloat addtimeX = SCREENWIDTH - addtimeSize.width - CellBorderW;
    self.addTimeF = CGRectMake(addtimeX, addtimeY, addtimeSize.width, addtimeSize.height);
    
    //配图(如果有的话)
    CGFloat contentY = 0;
    CGFloat coverW = SCREENWIDTH - 2 * CellBorderW;
    if (listM.coverimg.length) { //有配图
        CGFloat coverX = CellBorderW;
        CGFloat coverY = CGRectGetMaxY(self.iconF) + CellBorderW;
        CGFloat coverScale = [CoverimgTool sizeWithSizeString:listM.coverimg_wh];
        self.coverimgF = CGRectMake(coverX, coverY, coverW , coverW * coverScale);
        contentY = CGRectGetMaxY(self.coverimgF) + CellBorderW;
    }else{  //没有配图
        contentY = CGRectGetMaxY(self.iconF) + CellBorderW;
    }
    
    //内容
    CGSize contentSize = [listM.content sizeWithFont:LISTCONTENTFONT maxW:coverW];
    CGFloat contentX = CellBorderW;
    self.contentF = (CGRect){{contentX,contentY},contentSize};
    
    //点赞
    CGFloat commentH = self.addTimeF.size.height;
    CGFloat commentW = commentH * 3;
    CGFloat commentX = SCREENWIDTH * 0.6;
    CGFloat commentY = CGRectGetMaxY(self.contentF) + CellBorderW;
    self.commentF = CGRectMake(commentX, commentY, commentW, commentH);
    
    //喜欢
    CGFloat likeX = CGRectGetMaxX(self.commentF) + SCREENWIDTH * 0.125;
    self.likeFrame = CGRectMake(likeX, commentY, commentW, commentH);
    
    //cell的高度
    self.cellHeight = CGRectGetMaxY(self.commentF) + 2 * CellBorderW;
    
    //底部的线
    self.lineF = CGRectMake(0, self.cellHeight - 1, SCREENWIDTH, 1);
}



@end
