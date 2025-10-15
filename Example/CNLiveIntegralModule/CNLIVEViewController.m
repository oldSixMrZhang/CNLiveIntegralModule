//
//  CNLIVEViewController.m
//  CNLiveIntegralModule
//
//  Created by 153993236@qq.com on 11/18/2019.
//  Copyright (c) 2019 153993236@qq.com. All rights reserved.
//

#import "CNLIVEViewController.h"

#import "CNLiveEnvironment.h"
#import "CNLiveNetworking.h"
#import "CNUserInfoManager.h"

@interface CNLIVEViewController ()

@end

@implementation CNLIVEViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
	// Do any additional setup after loading the view, typically from a nib.
//    NSArray *userIds = @[@"10514405",@"10528152"];
                
    NSArray *userIds = @[@"10528152"];

    for(int i = 0; i < userIds.count; i++ ){
        [self request:userIds[i]];
    }
    
}

- (void)request:(NSString *)userId{
     // 签到
     NSDictionary *params = @{@"sid":userId,@"appId":AppId};
     [CNLiveNetworking setAllowRequestDefaultArgument:YES];
     [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralSignInUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
    
     }];
     
     //1.观看视频/分享目击者视频
     NSArray *contentIds1 = @[@"769_cf49366d0e274bd2a8c6ecc751ddbab6",
                             @"769_afe6c01e49784eb79ce32e240be3e029",
                             @"769_799f6825b3d14e8c885049e5542ed56a",
                             @"769_fc8fb5e3aab1412c91b032b2297b9e76",
                             @"769_bd81aa260e1f4f569fb549af51c5004e",
                             @"769_938f9aca45ec4c0dbd860438fcac29fc",
                             @"769_62c8ed911f5e4a8e90e808b928794fa0",
                             @"769_3eba7437d0484328b31c6b7f61345a3d",
                             @"769_0a637e368210483f94537a8d9af2e130",
                             @"769_2516ed081c95405dbfa357298ec25dd7"];
     for(int i = 0; i < contentIds1.count; i++ ){
         NSDictionary *params1 = @{@"sid":userId,@"taskId":@"watch_video",@"contentId":contentIds1[i],@"appId":AppId};
          [CNLiveNetworking setAllowRequestDefaultArgument:YES];
          [CNLiveNetworking setupShowDataResult:NO];
          [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params1 CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
              
          }];
         
         NSDictionary *params2 = @{@"sid":userId,@"taskId":@"share_video",@"contentId":contentIds1[i],@"appId":AppId};
         [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params2 CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
             
         }];
     
     }
        
     //2.听本小说
     NSArray *contentIds2 = @[@"300827",
                             @"300853",
                             @"300945",
                             @"300946",
                             @"300947",
                             @"300948",
                             @"329015",
                             @"329016",
                             @"329027",
                             @"329028",
                             @"329079"];
     for(int i = 0; i < contentIds2.count; i++ ){
         NSDictionary *params = @{@"sid":userId,@"taskId":@"listen_novel",@"contentId":contentIds2[i],@"appId":AppId};
         [CNLiveNetworking setAllowRequestDefaultArgument:YES];
         [CNLiveNetworking setupShowDataResult:NO];
         [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
             
         }];
     }
     
     //3.啃篇文档/分享文章内容
     NSArray *contentIds3 = @[@"399227",@"399219",@"399204",@"399384",@"399382",@"968",@"399381",@"399380",@"399377",@"399376",@"399373"];
     for(int i = 0; i < contentIds3.count; i++ ){
         NSDictionary *params1 = @{@"sid":userId,@"taskId":@"read_article",@"contentId":contentIds2[i],@"appId":AppId};
         [CNLiveNetworking setAllowRequestDefaultArgument:YES];
         [CNLiveNetworking setupShowDataResult:NO];
         [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params1 CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
             
         }];
         
         NSDictionary *params2 = @{@"sid":userId,@"taskId":@"share_article",@"contentId":contentIds3[i],@"appId":AppId};
         [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params2 CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
         
         }];
         
         NSDictionary *params3 = @{@"sid":userId,@"taskId":@"publish_comment",@"contentId":contentIds3[i],@"appId":AppId};
         [CNLiveNetworking requestNetworkWithMethod:CNLiveRequestMethodPOST URLString:CNIntegralAddUrl Param:params3 CacheType:CNLiveNetworkCacheTypeNetworkOnly CompletionBlock:^(NSURLSessionTask *requestTask, id responseObject, NSError *error) {
         
         }];

     }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
