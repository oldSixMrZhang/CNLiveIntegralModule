//
//  CNLiveAddScoreManager.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/5.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveAddScoreManager.h"

#import "MJExtension.h"

#import "CNLiveNetworking.h"
#import "CNUserInfoManager.h"
#import "CNLiveEnvironment.h"

#import "CNLiveScoreModel.h"
#import "CNLiveTaskListModel.h"

@interface CNLiveAddScoreManager()
@property (nonatomic, weak) NSTimer *timer;
@property (nonatomic, copy) NSString *taskId;
@property (nonatomic, copy) NSString *contentId;

@end
@implementation CNLiveAddScoreManager
#pragma mark - 单例
+ (instancetype)manager {
    static CNLiveAddScoreManager *_singleton = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //不能再使用alloc方法
        //因为已经重写了allocWithZone方法，所以这里要调用父类的分配空间的方法
        _singleton = [[super allocWithZone:NULL] init];
    });
    return _singleton;
}
// 防止外部调用alloc 或者 new
+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    return [CNLiveAddScoreManager manager];
}
// 防止外部调用copy
- (id)copyWithZone:(nullable NSZone *)zone {
    return [CNLiveAddScoreManager manager];
}
// 防止外部调用mutableCopy
- (id)mutableCopyWithZone:(nullable NSZone *)zone {
    return [CNLiveAddScoreManager manager];
}

#pragma mark - 工具方法
/*
 errorCode 432 errorMessage 此内容今日上限
 errorCode 431 errorMessage 积分任务上限
 errorCode 0 errorMessage 成功
 errorCode 403 errorMessage 缺少必要参数
 */
#pragma mark - 延时请求加分接口
- (void)requestTime:(NSInteger)time taskId:(NSString *)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block{
    CNLiveAddScoreManager *manager = [CNLiveAddScoreManager manager];
    manager.taskId = taskId;
    manager.contentId = contentId;
    manager.block = block;
    [manager performSelector:@selector(sendRequest) withObject:nil afterDelay:time];

}
- (void)sendRequest{
    [CNLiveAddScoreManager requestTaskId:self.taskId contentId:self.contentId block:self.block];
}
#pragma mark - 取消延时请求加分接口
- (void)cancelSendRequest{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(sendRequest) object:nil];
    
}
//首次登录加积分
+ (void)firstLogin:(RequestCompleted _Nullable)block {
    //根据后台数据设置
       NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"CNWjjAddSourceTime"];
       if(!dic[@"isShowIntegral"]||[dic[@"isShowIntegral"] isEqualToString:@"false"]||[dic[@"isShowIntegral"] isEqualToString:@"0"]){
           block?block(NO, @"关闭增加积分", @"0"):@"";
           return;
       }
    //判断是否可以请求加分
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    BOOL haveAdd = [userDefault boolForKey:@"kAddScoreFirstLogin"];
    if(!haveAdd){
        NSDictionary *params = @{@"sid":CNUserShareModel.uid,@"taskId":@"first_login",@"contentId":@""};
        [CNLiveNetworking setAllowRequestDefaultArgument:YES];
        [CNLiveNetworking setupShowDataResult:NO];
        [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"errorCode"] isEqualToString:@"0"]) {
                //完成次数加一
                [CNLiveAddScoreManager updateAddScoreJson:@"TaskList.json" taskType:@"firstTask" taskId:@"first_login"];
                CNLiveScoreModel *model = [CNLiveScoreModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddScoreRequestSuccess" object:nil userInfo:@{@"taskType":@"firstTask", @"taskId":@"first_login", @"score":model.score}];
                [userDefault setBool:YES forKey:@"kAddScoreFirstLogin"];
                block?block(YES, model.desc, model.score):@"";

            }else{
                block?block(NO, @"失败", @"0"):@"";
            }
        }];
        
    }else{
        block?block(NO, @"首次登录已增加积分", @"0"):@"";

    }
    
}

#pragma mark - 直接请求加分接口
+ (void)requestTaskId:(NSString *)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block{
    if(!CNUserShareManager.isLogin){
        block(NO, @"用户未登录", @"0");
        return;
    }
    //根据后台数据设置
    NSDictionary *dic = [[NSUserDefaults standardUserDefaults] objectForKey:@"CNWjjAddSourceTime"];
    if(!dic[@"isShowIntegral"]||[dic[@"isShowIntegral"] isEqualToString:@"false"]||[dic[@"isShowIntegral"] isEqualToString:@"0"]){
        block(NO, @"关闭增加积分", @"0");
        return;
    }
    //首次任务
    NSString *taskType = nil;
    if([taskId isEqualToString:@"update_face"]){//更新头像
        taskType = @"firstTask";
    }
    else if ([taskId isEqualToString:@"update_nick"]){//换个昵称
        taskType = @"firstTask";

    }
    else if ([taskId isEqualToString:@"publish_witness"]){//发条目击者
        taskType = @"firstTask";

    }
    else if ([taskId isEqualToString:@"add_friend"]){//添加好友
        taskType = @"firstTask";

    }
    else if ([taskId isEqualToString:@"publish_moment"]){//发条生活圈
        taskType = @"firstTask";

    }
    else if ([taskId isEqualToString:@"customer_feedback"]){//客服留言
        taskType = @"firstTask";

    }
    //每日任务
    else if ([taskId isEqualToString:@"check_in"]){//签到
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"watch_video"]){//观看视频
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"listen_novel"]){//听本小说
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"read_article"]){//啃篇文档
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"publish_comment"]){//发布评论
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"share_video"]){//分享目击者视频
        taskType = @"dailyTask";

    }
    else if ([taskId isEqualToString:@"share_article"]){//分享文章
        taskType = @"dailyTask";

    }

    //判断是否可以请求加分
    BOOL isOk = [CNLiveAddScoreManager judgeIsAddScoreJson:@"TaskList.json" taskType:taskType taskId:taskId];
    if(isOk){
        NSDictionary *params = @{@"sid":CNUserShareModel.uid,@"taskId":taskId,@"contentId":!contentId?@"":contentId};
        [CNLiveNetworking setAllowRequestDefaultArgument:YES];
        [CNLiveNetworking setupShowDataResult:NO];
        [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
            
            if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"errorCode"] isEqualToString:@"0"]) {
                //完成次数加一
                [CNLiveAddScoreManager updateAddScoreJson:@"TaskList.json" taskType:taskType taskId:taskId];
                CNLiveScoreModel *model = [CNLiveScoreModel mj_objectWithKeyValues:responseObject[@"data"]];
                
                //发送通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"AddScoreRequestSuccess" object:nil userInfo:@{@"taskType":taskType, @"taskId":taskId, @"score":model.score}];
                block(YES, model.desc, model.score);
                
            }else{
                block(NO, @"失败", @"0");
                
            }
            
        }];
    }else{
        block(NO, @"任务达到上限", @"0");

    }
    
}

#pragma mark - 判断是否完成任务
+ (BOOL)judgeIsAddScoreJson:(NSString *)name taskType:(NSString *)taskType taskId:(NSString *)taskId{
    CNLiveTaskListModel *model = [CNLiveAddScoreManager readJson:name taskType:taskType taskId:taskId];

    if([taskType isEqualToString:@"dailyTask"]){
        for (CNLiveTaskListItemModel *smodel in model.dailyTask) {
            if([smodel.taskId isEqualToString:taskId]){
                return smodel.times < smodel.totalCount;//能分享
            }
        }
    }
    if([taskType isEqualToString:@"firstTask"]){
        for (CNLiveTaskListItemModel *smodel in model.firstTask) {
            if([smodel.taskId isEqualToString:taskId]){
                return smodel.times < smodel.totalCount;//能分享
            }
        }
    }
    return NO;

}

#pragma mark - 更新本地完成任务次数
+ (BOOL)updateAddScoreJson:(NSString *)name taskType:(NSString *)taskType taskId:(NSString *)taskId{
    CNLiveTaskListModel *model = [CNLiveAddScoreManager readJson:name taskType:taskType taskId:taskId];

    if([taskType isEqualToString:@"dailyTask"]){
        for (CNLiveTaskListItemModel *smodel in model.dailyTask) {
            if([smodel.taskId isEqualToString:taskId]){
                smodel.times++;
            }
        }
    }
    if([taskType isEqualToString:@"firstTask"]){
        for (CNLiveTaskListItemModel *smodel in model.firstTask) {
            if([smodel.taskId isEqualToString:taskId]){
                smodel.times++;
            }
        }
    }
    NSDictionary *dic = [model mj_keyValues];
    return [CNLiveAddScoreManager writeJsonName:name dic:dic];

}

#pragma mark - 读取本地json
+ (CNLiveTaskListModel *)readJson:(NSString *)name taskType:(NSString *)taskType taskId:(NSString *)taskId{
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@/%@",CNUserShareModel.uid,name]];
    NSDictionary *jsonObject = [NSDictionary dictionaryWithContentsOfFile:filePath];
    CNLiveTaskListModel *model = [CNLiveTaskListModel mj_objectWithKeyValues:jsonObject];
    return model;
    
}

#pragma mark - 写入本地json
+ (BOOL)writeJsonName:(NSString *)name dic:(NSDictionary *)dic{
    if (![NSJSONSerialization isValidJSONObject:dic]) {
        return NO;
    }
    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filePath = [docPath stringByAppendingPathComponent:CNUserShareModel.uid];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = NO;
    BOOL isDirExist = [fileManager fileExistsAtPath:filePath isDirectory:&isDir];
    if (isDir && isDirExist) {
        NSString *savePath = [filePath stringByAppendingPathComponent:name];
        return [dic writeToFile:savePath atomically:YES];

    }else{
        BOOL success = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if(success){
            NSString *savePath = [filePath stringByAppendingPathComponent:name];
            return [dic writeToFile:savePath atomically:YES];
        }
    }
    return NO;
    
}

@end
