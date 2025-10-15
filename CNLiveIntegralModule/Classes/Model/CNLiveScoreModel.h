//
//  CNLiveScoreModel.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/2.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CNLiveScoreModel : NSObject
//积分明细
@property (nonatomic, copy) NSString *date;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *source;
@property (nonatomic, copy) NSString *title;

//签到
@property (nonatomic, strong) NSArray *scores;
@property (nonatomic, assign) NSInteger times;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *desc;

@property (nonatomic, copy) NSString *status;

@end

NS_ASSUME_NONNULL_END
