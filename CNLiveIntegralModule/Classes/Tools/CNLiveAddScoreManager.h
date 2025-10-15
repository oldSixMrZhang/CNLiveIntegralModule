//
//  CNLiveAddScoreManager.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/5.
//  Copyright © 2019年 cnlive. All rights reserved.
//

/**
 * 增加请求
 */

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^RequestCompleted) (BOOL isSuccess, NSString *desc, NSString *score);

@interface CNLiveAddScoreManager : NSObject
@property (nonatomic, copy) RequestCompleted block;

//延时调用
+ (instancetype)manager;
- (void)requestTime:(NSInteger)time taskId:(NSString *)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block;
//取消延时
- (void)cancelSendRequest;

//首次登录加积分
+ (void)firstLogin:(RequestCompleted _Nullable)block;

//直接调用
+ (void)requestTaskId:(NSString *_Nonnull)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block;

+ (BOOL)judgeIsAddScoreJson:(NSString *)name taskType:(NSString *_Nonnull)taskType taskId:(NSString *_Nonnull)taskId;
+ (BOOL)writeJsonName:(NSString *)name dic:(NSDictionary *_Nonnull)dic;

@end

NS_ASSUME_NONNULL_END
