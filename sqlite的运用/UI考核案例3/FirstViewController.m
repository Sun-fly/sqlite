//
//  FirstViewController.m
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/1.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "FirstViewController.h"




@interface FirstViewController ()
/** id */
@property(nonatomic)int st_id;
/** 姓名 */
@property (weak, nonatomic) IBOutlet UITextField *name;
/** 性别 */
@property(copy,nonatomic)NSString *sex;

/** 分数 */
@property (weak, nonatomic) IBOutlet UILabel *value;

/** 通过与否开关控件 */
@property (weak, nonatomic) IBOutlet UISwitch *isOK;
/** 分割控件 */
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;

///点击按钮事件
- (IBAction)addTap:(UIButton *)sender;
///滑块事件
- (IBAction)sliderTask:(UISlider *)sender;
///开关控件事件
- (IBAction)segmentControllerTask:(UISegmentedControl *)sender;
///关闭键盘
- (IBAction)closeKetBoard:(UITextField *)sender;
///点击空白区域关闭键盘
- (IBAction)closeKB:(id)sender;


@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openSqliteAndCreateTable];
    
    self.value.text=[NSString stringWithFormat:@"%d",50];
    self.sex=[self.segmentController titleForSegmentAtIndex:0];
}
///获取路径，打开数据库，创建表格
-(void)openSqliteAndCreateTable{
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath=[path stringByAppendingPathComponent:@"students.sqlite"];
    NSLog(@"path=%@",dataPath);
    NSFileManager *fileManger=[NSFileManager defaultManager];
    if ([fileManger fileExistsAtPath:dataPath]==NO) {
        if (sqlite3_open([dataPath UTF8String], &db)==SQLITE_OK) {
            char *errmsg;
            const char *sql="create table  if not exists students(ID INTEGER PRIMARY KEY AUTOINCREMENT,name text ,sex text ,value text )";
            if (sqlite3_exec(db, sql, NULL, NULL, &errmsg)!=SQLITE_OK) {
                NSLog(@"创建数据表失败");
            }
        }
        else{
            NSLog(@"创建数据表成功！");
        }
        sqlite3_close(db);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

///将信息添加至sqlite数据库中
- (IBAction)addTap:(UIButton *)sender {
    
    //第一步，判断姓名不能为空
    NSString *name=self.name.text;
    name=[self trim:name];
    if ([name isEqualToString:@""]) {
        [self alertMessage:@"姓名不能为空"];
        return;
    }
    //如果通过
    if (self.isOK.on==YES) {
        char *errmsg;
        if (sqlite3_open([dataPath UTF8String], &db)==SQLITE_OK) {
            NSString *insetSQL=[NSString stringWithFormat:@"insert into students(name,sex,value) values(\"%@\",\"%@\",\"%@\")",self.name.text,self.sex,self.value.text];
            if (sqlite3_exec(db, [insetSQL UTF8String], NULL, NULL, &errmsg)==SQLITE_OK) {
                self.name.text=@"";
                NSLog(@"添加成功！");
                //注册通知
                NSNotification *fication=[NSNotification notificationWithName:@"Notification" object:nil];
                [[NSNotificationCenter defaultCenter]postNotification:fication];
                //跳转至VC2页面
                self.tabBarController.selectedIndex = 1;
            }else{
                NSLog(@"first出错=%s",errmsg);
            }
           sqlite3_close(db);
        }
    }
    else{
        [self alertMessage:@"未通过，不能添加！"];
    }
}
- (IBAction)sliderTask:(UISlider *)sender {
    self.value.text=[NSString stringWithFormat:@"%d",(int)sender.value];
}

- (IBAction)segmentControllerTask:(UISegmentedControl *)sender {
    self.sex=[sender titleForSegmentAtIndex:[sender selectedSegmentIndex]];
}

- (IBAction)closeKetBoard:(UITextField *)sender {
    [self.name resignFirstResponder];
}

- (IBAction)closeKB:(id)sender {

}

///删除空格
-(NSString *)trim:(NSString *)_str{
    return [_str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

/**
 警告框封装
 @param _msg 提醒内容
 */
-(void)alertMessage:(NSString *)_msg {
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:_msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action=[UIAlertAction actionWithTitle:@"我知道了" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:action];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
