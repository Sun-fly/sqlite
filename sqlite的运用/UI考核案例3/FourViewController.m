//
//  FourViewController.m
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/1.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "FourViewController.h"

@interface FourViewController ()


@end

@implementation FourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    myView=[[ZYDrawView alloc]init];
    self.view=myView;
    
    
    
}

///触摸事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    //生成触摸对象
    UITouch *touchObject=[touches anyObject];
   //生成触摸点的坐标
    CGPoint touchPoint=[touchObject locationInView:self.view];
    //另定制的视图的坐标等于触摸点的坐标
    myView.picturePoint = touchPoint;
    //重新绘制的视图
    [self.view setNeedsDisplay];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
