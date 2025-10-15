//
//  CNLiveIntegralService.m
//  CNLiveIntegralModule
//
//  Created by 153993236@qq.com on 11/12/2019.
//  Copyright (c) 2019 153993236@qq.com. All rights reserved.
//

#import "CNLiveIntegralService.h"

#import "MJExtension.h"

#import "CNLiveServices.h"
#import "CNLiveManager.h"

// 任务列表
#import "CNLiveTaskListController.h"

// 增加积分
#import "CNLiveAddScoreManager.h"
#import "CNLiveAddScoreView.h"
// 金币下落
#import "CNLiveGoldWhereaboutsView.h"
// 签到
#import "CNLiveSignInView.h"

#import "CNLiveScoreModel.h"

@BeeHiveService(CNLiveIntegralServiceProtocol,CNLiveIntegralService)
@interface CNLiveIntegralService ()<CNLiveIntegralServiceProtocol>

@end

@implementation CNLiveIntegralService

#pragma mark - 任务列表
// 任务列表
- (UIViewController *)getTaskListViewController {
    return [CNLiveTaskListController new];
}

- (void)pushToTaskListViewController {
    CNLiveTaskListController *vc = [[CNLiveTaskListController alloc]init];
    [CNLivePageJumpManager jumpViewController:vc];
}

- (void)pushToTaskListViewController:(NSString *)isFrom{
    CNLiveTaskListController *vc = [[CNLiveTaskListController alloc]init];
    vc.isFrom = isFrom;
    [CNLivePageJumpManager jumpViewController:vc];
}

#pragma mark - 增加积分
// 请求
//延时调用
- (void)requestTime:(NSInteger)time taskId:(NSString *)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block{
    [[CNLiveAddScoreManager manager] requestTime:time taskId:taskId contentId:contentId block:block];
}
//取消延时
- (void)cancelSendRequest{
    [[CNLiveAddScoreManager manager] cancelSendRequest];
}

//首次登录加积分
- (void)firstLogin:(RequestCompleted _Nullable)block{
    [CNLiveAddScoreManager firstLogin:block];
}

//直接调用
- (void)requestTaskId:(NSString *)taskId contentId:(NSString *)contentId block:(RequestCompleted _Nullable)block{
    [CNLiveAddScoreManager requestTaskId:taskId contentId:contentId block:block];
}

// 视图
// 默认展示添加积分视图
- (void)showAddScoreViewWithDesc:(NSString *)desc score:(NSString *)score{
    [CNLiveAddScoreView showWithDesc:desc score:score];
}

// 游客模式浏览加积分
- (void)showAddScoreViewWithDesc:(NSString *)desc score:(NSString *)score delegate:(id<CNLiveAddScoreViewDelegate>)delegate{
    [CNLiveAddScoreView showWithDesc:desc score:score delegate:delegate];
}

- (void)hideAddScoreView{
    [CNLiveAddScoreView hide];
}

#pragma mark - 金币下落
// 默认签到
- (void)showGoldWhereaboutsViewWithDic:(NSDictionary *)dic{
    CNLiveScoreModel * model = [CNLiveScoreModel mj_objectWithKeyValues:dic];
    [CNLiveGoldWhereaboutsView showWithModel:model];
}

// 默认展示添加积分视图
- (void)showGoldWhereaboutsViewWithDesc:(NSString *)desc score:(NSString *)score{
    [CNLiveGoldWhereaboutsView showWithDesc:desc score:score];
}

// 游客模式浏览加积分
- (void)showGoldWhereaboutsViewWithDesc:(NSString *)desc delegate:(id)delegate{
    [CNLiveGoldWhereaboutsView showWithDesc:desc delegate:delegate];
}

- (void)hideGoldWhereaboutsView{
    [CNLiveGoldWhereaboutsView hide];
}

#pragma mark - 签到
- (void)showSignInViewWithDic:(NSDictionary *)dic {
    CNLiveScoreModel *model = [CNLiveScoreModel mj_objectWithKeyValues:dic];
    [CNLiveSignInView showWithScore:model.score scores:model.scores.count>0?model.scores[0]:@"1000,2000,3000,4000,5000,6000,7000" day:model.times url:model.url];
}


@end
