//
//  CAEmitterLayerView.h
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CAEmitterLayerView : UIView
//模仿setter，getter方法
- (void)setEmitterLayer:(CAEmitterLayer *)layer;
- (CAEmitterLayer *)emitterLayer;

//显示出当前view
- (void)show;
//隐藏
- (void)hide;

@end

NS_ASSUME_NONNULL_END
