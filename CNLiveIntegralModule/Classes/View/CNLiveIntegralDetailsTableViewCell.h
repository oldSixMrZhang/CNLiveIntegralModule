//
//  CNLiveIntegralDetailsTableViewCell.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
static NSString * const kCNLiveIntegralDetailsTableViewCell = @"CNLiveIntegralDetailsTableViewCell";
@class CNLiveScoreModel;

@interface CNLiveIntegralDetailsTableViewCell : UITableViewCell
@property (nonatomic, strong) CNLiveScoreModel *model;

@end

NS_ASSUME_NONNULL_END
