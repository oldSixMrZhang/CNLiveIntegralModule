//
//  CNLiveSignInButtonView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class CNLiveSignInButtonView;
@protocol CNLiveSignInButtonViewDelegate <NSObject>
- (void)clickedSignInButton:(CNLiveSignInButtonView *)view day:(NSString *)day;

@end
@interface CNLiveSignInButtonView : UIView

@property (nonatomic, assign) NSInteger day;
@property (nonatomic, copy) NSString *scores;
@property (nonatomic, weak) id<CNLiveSignInButtonViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end

NS_ASSUME_NONNULL_END
