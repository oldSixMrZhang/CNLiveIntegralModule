//
//  CNLiveSignInView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

/**
 *  签到
 */

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNLiveSignInView : UIView
@property (nonatomic, copy) NSString *url;

/**
 *  签到
 *
 *  @param score 1000
 *  @param scores "1000,2000,3000,4000,5000,6000,7000"
 *  @param day 第几天
 *  @param url 签到规则url
 *
 */
+ (void)showWithScore:(NSString *)score scores:(NSString *)scores day:(NSInteger)day url:(NSString *)url;

@end

NS_ASSUME_NONNULL_END
