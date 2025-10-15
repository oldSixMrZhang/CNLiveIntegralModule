//
//  CNLiveTaskListModel.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/26.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveTaskListModel.h"

@implementation CNLiveTaskListItemModel

@end
@implementation CNLiveTaskListModel
+ (NSDictionary *)mj_objectClassInArray{
    return @{
             @"dailyTask" : @"CNLiveTaskListItemModel",@"firstTask" : @"CNLiveTaskListItemModel"
             };
}
@end
