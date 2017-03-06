//
//  ThreeViewController.m
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/1.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "ThreeViewController.h"

@interface ThreeViewController ()
/**
 显示的标签
 */
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
///手势事件
- (IBAction)gesture:(id)sender;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.numberLabel.text=[NSString stringWithFormat:@"%d",66];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)gesture:(id)sender {
    
    
    self.numberLabel.text=[NSString stringWithFormat:@"%d",arc4random()%101];
}
@end
