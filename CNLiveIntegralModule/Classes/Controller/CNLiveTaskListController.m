//
//  CNLiveTaskListController.m
//  CNLiveIntegralModule
//
//  Created by 153993236@qq.com on 11/12/2019.
//  Copyright (c) 2019 153993236@qq.com. All rights reserved.
//

#import "CNLiveTaskListController.h"

#import "MJExtension.h"
#import "QMUIKit.h"
#import "YYKit.h"
#import <Masonry/Masonry.h>

#import "CNLiveServices.h"
#import "CNLiveNetworking.h"
#import "CNLiveEnvironment.h"
#import "CNUserInfoManager.h"
#import "CNLiveCategory.h"

#import "CNLiveTaskListTableViewCell.h"
#import "CNLiveTaskListSectionHeaderView.h"
#import "CNLiveTaskListModel.h"
#import "CNLiveGoldWhereaboutsView.h"//金币下落
#import "CNLiveAddScoreView.h"

//#import "CNTabBarViewController.h"
//#import "CNNavigationController.h"
//#import "CNClassifySegmentController.h"
//#import "CNSubClassifySegmentController.h"

//#import "CNMinePersonInfoController.h"//个人资料
//#import "CNAddNewFriendViewController.h"//添加好友
//#import "CNFirendNewListViewController.h"//生活圈
//#import "CNReportAndComplaintWebController.h"//帮助与反馈
//#import "CNGifFaceListHeaderView.h"
#import "CNLiveNavigationBar.h"

#import "CNLiveTaskListHeaderView.h"
#import "CNLiveIntegralDetailsController.h"//积分明细
#import "CNLiveAddScoreManager.h"

@interface CNLiveTaskListController ()<UITableViewDelegate,UITableViewDataSource,CNLiveTaskListTableViewCellDelegate,CNLiveTaskListHeaderViewDelegate>
@property (nonatomic, strong) CNLiveNavigationBar *navigationBar;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CNLiveTaskListHeaderView *headView;
@property (nonatomic, strong) NSMutableArray *data;

@end

@implementation CNLiveTaskListController
#pragma mark - CNLiveTaskListTableViewCellDelegate
- (void)clickedCellButton:(CNLiveTaskListTableViewCell *)cell type:(NSString *)type{
    if([type isEqualToString:@"update_face"]||[type isEqualToString:@"update_nick"]){//头像 昵称
//        CNMinePersonInfoController *infoVC = [[CNMinePersonInfoController alloc] init];
//        [[AppDelegate sharedAppDelegate] pushViewController:infoVC withBackTitle:@" "];
        
    }
    else if ([type isEqualToString:@"publish_witness"]){//发布目击者
//        [self selectChannelId:@"1" classifyId:@"101"];
        
    }
    else if ([type isEqualToString:@"add_friend"]){//添加好友
//        CNAddNewFriendViewController *newFriendVC = [[CNAddNewFriendViewController alloc] init];
//        [[AppDelegate sharedAppDelegate] pushViewController:newFriendVC withBackTitle:@"返回"];
        
    }
    else if ([type isEqualToString:@"publish_moment"]){//生活圈
//        CNFirendNewListViewController *vc = [[CNFirendNewListViewController alloc] init];
//        [[AppDelegate sharedAppDelegate] pushViewController:vc withBackTitle:@" "];
        
    }
    else if ([type isEqualToString:@"share_video"]){//分享目击者视频
//        [self selectChannelId:@"1" classifyId:@"101"];

    }
    else if ([type isEqualToString:@"share_article"]){//分享文章
//        [self selectChannelId:@"1" classifyId:@"102"];
        
    }
    else if ([type isEqualToString:@"publish_comment"]){//评论
//        [self selectChannelId:@"1" classifyId:@"101"];

    }
    else if ([type isEqualToString:@"read_article"]){//看文章-> 视讯中国 -> 今日要闻
//        [self selectChannelId:@"1" classifyId:@"102"];

    }
    else if ([type isEqualToString:@"customer_feedback"]){//帮助与反馈
//        NSString *savePath = [NSString stringWithFormat:@"%@%@",CNWjjUserTermsUrls,@"bzfk"];
//        NSDictionary *h5Dic = [[NSUserDefaults standardUserDefaults] objectForKey:savePath];
//        NSString *uuid = [CNLiveBusinessTools uuid];
//        NSString *defaultH5Url = @"http://wjjh5.cnlive.com/cnhf.html";
//        NSString *baseH5Url = [NSString isEmpty:h5Dic[@"detailUrl"]]?defaultH5Url:h5Dic[@"detailUrl"];
//        NSString *h5Url = [NSString stringWithFormat:@"%@?sid=%@&uuid=%@",baseH5Url,CNUserShareModel.uid,uuid];
//        NSString *h5Title = [NSString stringWithFormat:@"%@",h5Dic[@"title"]];
//        CNReportAndComplaintWebController *webVC = [[CNReportAndComplaintWebController alloc] initWithUrl:h5Url webType:CNFeedbackWebType pageTitle:h5Title];
//        [[AppDelegate sharedAppDelegate] pushViewController:webVC withBackTitle:@" "];
    }
    else if ([type isEqualToString:@"watch_video"]){//看视频 -> 视讯中国 -> 目击者
//        [self selectChannelId:@"1" classifyId:@"101"];

    }
    else if ([type isEqualToString:@"check_in"]){//签到
        if([self.isFrom isEqualToString:@"Classify"]){
            UITabBarController *tabbar = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbar.selectedIndex = 2;
        }
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([type isEqualToString:@"listen_novel"]){//听小说
//        [self selectChannelId:@"219" classifyId:@"215"];
    }

}


#pragma mark - Data
- (void)loadData{
    NSDictionary *params = @{@"sid":CNUserShareModel.uid,@"appId":AppId};
    [CNLiveNetworking setAllowRequestDefaultArgument:YES];
    [CNLiveNetworking setupShowDataResult:NO];
    __weak typeof(self) weakSelf = self;
    [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodGET URLString:CNIntegralGetTasksUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf) return ;
         if (error) {
             if (error.code == -1001||error.code == -1003||error.code == -1009) {
                 [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeNoNet noData:strongSelf.data.count == 0 block:^{
                     [self loadData];
                 }];
             }else{
                 [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeLoadFail noData:strongSelf.data.count == 0 block:^{
                     [strongSelf loadData];
                 }];
             }
             strongSelf.tableView.emptyView.backgroundColor = [UIColor whiteColor];
            return;
        }
        if(responseObject[@"data"] && [responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
            CNLiveTaskListModel *model = [CNLiveTaskListModel mj_objectWithKeyValues:responseObject[@"data"]];
            [strongSelf.data addObject:model];
            strongSelf.headView.score = model.integral;
            [strongSelf.tableView reloadData];
            [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeNoData noData:strongSelf.data.count == 0 block:nil];
            strongSelf.tableView.emptyView.backgroundColor = [UIColor whiteColor];

            if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"errorCode"] isEqualToString:@"0"]) {
                if([responseObject isKindOfClass:[NSDictionary class]]){
                    //存入任务列表
                    if(responseObject[@"data"] && [responseObject[@"data"] isKindOfClass:[NSDictionary class]]){
                        [CNLiveAddScoreManager writeJsonName:@"TaskList.json" dic:responseObject[@"data"]];
                    }
                }
                
            }
        }

    }];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear: animated];
    self.navigationController.navigationBar.hidden = YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    self.view.backgroundColor = [UIColor whiteColor];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notification:) name:@"AddScoreRequestSuccess" object:nil];

    [self loadData];
    [self createUI];
    
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AddScoreRequestSuccess" object:nil];
    
}
//实现方法
- (void)notification:(NSNotification *)noti{
    NSString *taskId = noti.userInfo[@"taskId"];
    
    //改变总积分
    NSInteger addScore = [noti.userInfo[@"score"] integerValue];
    NSInteger scored = [self.headView.score integerValue];
    NSString *scoreStr =  [NSString stringWithFormat:@"%ld",scored + addScore];
    self.headView.score = scoreStr;

    //改变任务次数
    NSArray *arr = [self.tableView indexPathsForVisibleRows];
    for (NSIndexPath *indexPath in arr) {
        CNLiveTaskListTableViewCell *cell = (CNLiveTaskListTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        if([taskId isEqualToString:cell.model.taskId]){
            cell.model.times++;
            cell.model = cell.model;
        }
    }
    
}

//- (void)viewWillDisappear:(BOOL)animated{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.headView];
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.tableView];

}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);

    }];
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(self.data.count > 0){
        if(section == 0){
            CNLiveTaskListModel *model = self.data[0];
            return model.dailyTask.count;
            
        }else if(section == 1){
            CNLiveTaskListModel *model = self.data[0];
            return model.firstTask.count;
            
        }
    }
    return 0;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNLiveTaskListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCNLiveTaskListTableViewCell forIndexPath:indexPath];
    cell.delegate = self;
    if(self.data.count > 0){
        CNLiveTaskListModel *model = self.data[0];
        if(indexPath.section == 0){
            cell.model = model.dailyTask[indexPath.row];
            
        }else if(indexPath.section == 1){
            cell.model = model.firstTask[indexPath.row];
            
        }
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSArray *arr = @[@"每日任务",@"首次任务"];
    CNLiveTaskListSectionHeaderView *header = [tableView  dequeueReusableHeaderFooterViewWithIdentifier:kCNLiveTaskListSectionHeaderView];
    header.text = arr[section];
    return header;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45.0; 
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

#pragma mark - CNLiveTaskListHeadViewDelegate
- (void)clickedDetailButton:(CNLiveTaskListHeaderView *)view{
    CNLiveIntegralDetailsController *vc = [[CNLiveIntegralDetailsController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Action

#pragma mark - Lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.bounces = NO;
        [_tableView registerClass:[CNLiveTaskListTableViewCell class] forCellReuseIdentifier:kCNLiveTaskListTableViewCell];
        [_tableView registerClass:[CNLiveTaskListSectionHeaderView class] forHeaderFooterViewReuseIdentifier:kCNLiveTaskListSectionHeaderView];
        
    }
    return _tableView;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (CNLiveTaskListHeaderView *)headView{
    if (!_headView) {
        _headView = [[CNLiveTaskListHeaderView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationContentTop+SCREEN_WIDTH*100/375.0)];
        UIImage *image = [self getImageWithImageName:@"integrate_list_bg" bundleName:@"CNLiveIntegralModule" targetClass:[CNLiveTaskListController class]];
        _headView.image = image;
        _headView.delegate = self;
    }
    return _headView;
}

- (CNLiveNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [CNLiveNavigationBar navigationBar];
        _navigationBar.backgroundColor = [UIColor clearColor];
        UIImage *image = [self getImageWithImageName:@"cnlive_back_white_b" bundleName:@"CNLiveCustomControl" targetClass:[CNLiveNavigationBar class]];
        _navigationBar.leftImage = image;

        _navigationBar.title.text = @"任务列表";
        _navigationBar.title.textColor = [UIColor whiteColor];
        _navigationBar.lineHidden = YES;
                
        __weak typeof(self) weakSelf = self;
        _navigationBar.onClickLeftButton = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
             if(!strongSelf) return ;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };

    }
    return _navigationBar;
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

@end
