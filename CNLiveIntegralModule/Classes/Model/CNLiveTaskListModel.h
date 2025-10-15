//
//  CNLiveTaskListModel.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/26.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface CNLiveTaskListItemModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *taskType;

@property (nonatomic, assign) NSInteger times;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger totalCount;
@property (nonatomic, copy) NSString *url;

@end
@interface CNLiveTaskListModel : NSObject
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, strong) NSArray *dailyTask;
@property (nonatomic, strong) NSArray *firstTask;


@end

NS_ASSUME_NONNULL_END
