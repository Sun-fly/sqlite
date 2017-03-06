//
//  ZYDrawView.m
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/2.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ZYDrawView.h"

@implementation ZYDrawView

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        self.picturePoint=CGPointMake(150, 100);
    }
    return self;
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    //创建上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //填充颜色
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    
    //绘制实心图片
    CGContextFillRect(context, CGRectMake(self.picturePoint.x, self.picturePoint.y, 100, 100));
    
    
    
    
}


@end
