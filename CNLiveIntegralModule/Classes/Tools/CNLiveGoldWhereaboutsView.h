//
//  CNLiveGoldWhereaboutsView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

/**
 * 金币下落
 */

#import "CAEmitterLayerView.h"

NS_ASSUME_NONNULL_BEGIN
@class CNLiveScoreModel;

typedef NS_ENUM(NSUInteger, CNLiveGoldWhereaboutsViewType) {
    CNLiveGoldWhereaboutsViewTypeSignIn,//签到
    CNLiveGoldWhereaboutsViewTypeAddScore,//熊猫
    CNLiveGoldWhereaboutsViewTypeLogin//游客登录

};

@interface CNLiveGoldWhereaboutsView : CAEmitterLayerView

// 默认签到
+ (void)showWithModel:(CNLiveScoreModel *)model;

// 默认展示添加积分视图
+ (void)showWithDesc:(NSString *)desc score:(NSString *)score;

// 游客模式浏览加积分
+ (void)showWithDesc:(NSString *)desc delegate:(id)delegate;

+ (void)hide;

@end

NS_ASSUME_NONNULL_END
