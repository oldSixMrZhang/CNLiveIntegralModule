//
//  CNLiveTaskListHeaderView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CNLiveTaskListHeaderView;
@protocol CNLiveTaskListHeaderViewDelegate <NSObject>
- (void)clickedDetailButton:(CNLiveTaskListHeaderView *)view;

@end
@interface CNLiveTaskListHeaderView : UIImageView
@property (nonatomic, weak) id<CNLiveTaskListHeaderViewDelegate> delegate;
@property (nonatomic, copy) NSString *score;

@end

NS_ASSUME_NONNULL_END
