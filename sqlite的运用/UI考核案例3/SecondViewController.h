//
//  SecondViewController.h
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/1.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "ZYstudentModel.h"

@interface SecondViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    sqlite3 *db;
    NSString *dataPath;
}

@end

