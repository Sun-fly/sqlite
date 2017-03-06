//
//  SecondViewController.m
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/1.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import "SecondViewController.h"


@interface SecondViewController ()
/** 显示数据的表示图 */
@property (weak, nonatomic) IBOutlet UITableView *ZYtableView;

/** student对象的动态数组 */
@property(strong,nonatomic)NSMutableArray *dictMutableArray;


@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ZYtableView.delegate=self;
    self.ZYtableView.dataSource=self;
    self.dictMutableArray=[[NSMutableArray alloc]init];
    [self loadData];
    //注册通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(Notification:) name:@"Notification" object:nil];
    
}
//通知事件
-(void)Notification:(NSNotification *)sender{
    [self loadData];
}
///加载数据，获取信息
-(void)loadData{
    [self.dictMutableArray removeAllObjects];
    
    NSString *path=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    dataPath=[path stringByAppendingPathComponent:@"students.sqlite"];
    NSFileManager *manger=[NSFileManager defaultManager];
    if ([manger fileExistsAtPath:dataPath]==YES) {
        if (sqlite3_open([dataPath UTF8String], &db)==SQLITE_OK) {
            NSLog(@"secend页面打开数据库路径成功！");
        }
    sqlite3_stmt *stmt;
    NSString *selectSQL=[NSString stringWithFormat:@"select id,name,sex,value from students"];
     if (sqlite3_prepare_v2(db, [selectSQL UTF8String], -1, &stmt, NULL)==SQLITE_OK) {
        while (sqlite3_step(stmt)==SQLITE_ROW) {
            ZYstudentModel *student=[[ZYstudentModel alloc]init];
            student.st_id=sqlite3_column_int(stmt, 0);
            student.name=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 1)];
            student.sex=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 2)];
            student.value=[NSString stringWithUTF8String:(char *)sqlite3_column_text(stmt, 3)];
            [self.dictMutableArray addObject:student];
        }
    }else{
        NSLog(@"second出错=%s",sqlite3_errmsg(db));
    }
//    NSLog(@"个数=%lu，self.dictMutableArray=%@",(unsigned long)self.dictMutableArray.count,self.dictMutableArray);
    sqlite3_finalize(stmt);
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.ZYtableView reloadData];
//    NSLog(@"表示图已经刷新了！");
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dictMutableArray.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZYstudentModel *student=self.dictMutableArray[indexPath.row];
   
    static NSString *cellID=@"mycell";
    UITableViewCell *cell=[self.ZYtableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    cell.textLabel.text=[NSString stringWithFormat:@"姓名：%@",student.name];
    cell.textLabel.textColor=[UIColor blackColor];
    cell.textLabel.font=[UIFont boldSystemFontOfSize:16];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"性别：%@   分数：%@",student.sex,student.value];
    
    return cell;
}
///编辑删除
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    ZYstudentModel *student=self.dictMutableArray[indexPath.row];
    
    [self deletaData:student];
    
    NSArray *indexPaths=[NSArray arrayWithObject:indexPath];
    
    [self.ZYtableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationRight];
    
}
///删除数据
-(void)deletaData:(ZYstudentModel *)_student{
    sqlite3_stmt *stmt;
    char *sql="delete from students where id=?";
        if (sqlite3_prepare_v2(db, sql, -1, &stmt, NULL)!=SQLITE_OK)
        {
            NSAssert1(0, @"Erroe while creating delete statement '%s'", sqlite3_errmsg(db));
        }
    sqlite3_bind_int(stmt, 1, _student.st_id);
    if (sqlite3_step(stmt)!=SQLITE_DONE) {
        NSAssert1(0, @"Error while deleting '%s'", sqlite3_errmsg(db));
    }
    sqlite3_reset(stmt);
    sqlite3_finalize(stmt);
    
    [self.dictMutableArray removeObject:_student];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"Notification" object:nil];
}

@end
