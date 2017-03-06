//
//  ZYstudentModel.h
//  UI考核案例3
//
//  Created by 周亚-Sun on 2017/3/2.
//  Copyright © 2017年 zhouya. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <sqlite3.h>
@interface ZYstudentModel : NSObject
/** id */
@property(nonatomic)int st_id;
/** 姓名 */
@property(copy,nonatomic)NSString *name;
/** 性别 */
@property(copy,nonatomic)NSString *sex;
/** 分数 */
@property(copy,nonatomic)NSString *value;


@end
