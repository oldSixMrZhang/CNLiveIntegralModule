//
//  CNLiveAddScoreView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

/**
 * 增加积分
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNLiveAddScoreView : UIView
@property (nonatomic, weak) id delegate;

// 做任务增加积分
+ (void)showWithDesc:(NSString *)desc score:(NSString *)score;

// 游客模式增加积分
+ (void)showWithDesc:(NSString *)desc score:(NSString *)score delegate:(id)delegate;

+ (void)hide;

@end

NS_ASSUME_NONNULL_END
