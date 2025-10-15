//
//  CNLiveTaskListTableViewCell.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/26.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define kCNLiveTaskListTableViewCell @"CNLiveTaskListTableViewCell"
@class CNLiveTaskListItemModel;
@class CNLiveTaskListTableViewCell;

@protocol CNLiveTaskListTableViewCellDelegate <NSObject>
- (void)clickedCellButton:(CNLiveTaskListTableViewCell *)cell type:(NSString *)type;

@end
@interface CNLiveTaskListTableViewCell : UITableViewCell
@property (nonatomic, strong) CNLiveTaskListItemModel *model;
@property (nonatomic, weak) id<CNLiveTaskListTableViewCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
