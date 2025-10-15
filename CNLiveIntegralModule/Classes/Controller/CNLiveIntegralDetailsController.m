//
//  CNLiveIntegralDetailsController.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveIntegralDetailsController.h"

#import "QMUIKit.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import "CNLiveNetworking.h"
#import "CNLiveEnvironment.h"
#import "CNUserInfoManager.h"
#import "CNLiveUserAgreementManager.h"
#import "CNLiveRefreshHeader.h"
#import "CNLiveRefreshFooter.h"
#import "CNLiveCategory.h"
#import "CNLiveBaseKit.h"
#import "CNLiveNavigationBar.h"

#import "CNLiveIntegralDetailsTableViewCell.h"
#import "CNLiveScoreModel.h"

@interface CNLiveIntegralDetailsController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CNLiveNavigationBar *navigationBar;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, assign) NSInteger pageNo;
@property (nonatomic, assign) BOOL isRefreshing;

@end

@implementation CNLiveIntegralDetailsController

#pragma mark - Data
- (void)loadData{
    NSDictionary *params = @{@"pageSize":@"15",
                            @"pageNo":[NSString stringWithFormat:@"%ld",_pageNo],
                            @"sid":CNUserShareModel.uid,@"appId":AppId};
    [CNLiveNetworking setAllowRequestDefaultArgument:YES];
    [CNLiveNetworking setupShowDataResult:NO];
    __weak typeof(self) weakSelf = self;
    [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodGET URLString:CNIntegralDetailsUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {

        __strong typeof(weakSelf) strongSelf = weakSelf;
        if(!strongSelf) return ;
        [strongSelf.tableView.mj_header endRefreshing];
        [strongSelf.tableView.mj_footer endRefreshing];
        strongSelf.isRefreshing = NO;

        if (error) {
            if (error.code == -1001||error.code == -1003||error.code == -1009) {
                [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeNoNet noData:strongSelf.data.count == 0 block:^{
                    [strongSelf.tableView.mj_header beginRefreshing];
                
                }];
            }else{
                [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeLoadFail noData:strongSelf.data.count == 0 block:^{
                    [strongSelf.tableView.mj_header beginRefreshing];
                
                }];
            }
            strongSelf.tableView.emptyView.top = 0;
            strongSelf.tableView.mj_footer.hidden = self.data.count == 0;
            return;
        }
        if ([responseObject isKindOfClass:[NSDictionary class]] && [responseObject[@"errorCode"] isEqualToString:@"0"]) {
            if(strongSelf.pageNo == 1 && strongSelf.data.count>0){
                [strongSelf.data removeAllObjects];
            }
            strongSelf.pageNo++;
            NSArray *arr = [CNLiveScoreModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"list"]];
            [strongSelf.data addObjectsFromArray:arr];
            if (arr.count < 15) {
                [strongSelf.tableView.mj_footer endRefreshingWithNoMoreData];
                
            } else {
                [strongSelf.tableView.mj_footer endRefreshing];
                
            }
        }
        strongSelf.tableView.mj_footer.hidden = strongSelf.data.count == 0;
        [strongSelf.tableView reloadData];
        
        [strongSelf.tableView showEmptyViewWithType:CNLiveCustomTipsTypeNoData noData:strongSelf.data.count == 0 block:nil];
        strongSelf.tableView.emptyView.top = 0;

    }];
    
}

- (void)loadMoreData{
    if(!_isRefreshing){
        _isRefreshing = YES;
        [self loadData];
    }
}

#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _pageNo = 1;
    _isRefreshing = NO;
    
    [self.tableView.mj_header beginRefreshing];
    [self createUI];
    
}

#pragma mark - UI
- (void)createUI {
    [self.view addSubview:self.navigationBar];
    [self.view addSubview:self.tableView];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CNLiveIntegralDetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCNLiveIntegralDetailsTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.model = self.data[indexPath.row];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30+40;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Lazy loading
- (CNLiveNavigationBar *)navigationBar {
    if (!_navigationBar) {
        _navigationBar = [CNLiveNavigationBar navigationBar];
        _navigationBar.title.text = @"积分明细";
        _navigationBar.rightTitle = @"积分规则";
        [_navigationBar.right setTitleColor:[UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0] forState:UIControlStateNormal];
        _navigationBar.right.titleLabel.font = [UIFont systemFontOfSize:16.0];
        _navigationBar.right.frame = CGRectMake(SCREEN_WIDTH-80-15, StatusBarHeight, 80, NavigationBarHeight);
        __weak typeof(self) weakSelf = self;
        _navigationBar.onClickLeftButton = ^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(!strongSelf) return ;
            [strongSelf.navigationController popViewControllerAnimated:YES];
        };
        _navigationBar.onClickRightButton = ^{
            [CNLiveUserAgreementManager jumpToAgreementH5WithType:CNLiveUserAgreementIntegralRules];
        };
    }
    return _navigationBar;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationContentTop, SCREEN_WIDTH, SCREEN_HEIGHT-NavigationContentTop) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        [_tableView registerClass:[CNLiveIntegralDetailsTableViewCell class] forCellReuseIdentifier:kCNLiveIntegralDetailsTableViewCell];
        __weak __typeof(self)weakSelf = self;
        CNLiveRefreshHeader *header = [CNLiveRefreshHeader headerWithRefreshingBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(!strongSelf) return ;
            strongSelf.pageNo = 1;
            [strongSelf loadMoreData];
        }];
        _tableView.mj_header = header;
        CNLiveRefreshFooter *footer = [CNLiveRefreshFooter footerWithRefreshingBlock:^{
            __strong typeof(weakSelf) strongSelf = weakSelf;
            if(!strongSelf) return ;
            [strongSelf loadMoreData];
        }];
        footer.hidden = YES;
        _tableView.mj_footer = footer;
    }
    return _tableView;
}

- (NSMutableArray *)data{
    if (!_data) {
        _data = [[NSMutableArray alloc] init];
    }
    return _data;
}

- (void)dealloc{
    
}

@end
