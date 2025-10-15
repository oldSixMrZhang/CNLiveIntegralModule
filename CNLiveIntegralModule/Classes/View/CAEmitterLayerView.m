//
//  CAEmitterLayerView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CAEmitterLayerView.h"

@interface CAEmitterLayerView() {
    CAEmitterLayer *_emitterLayer;
}

@end

@implementation CAEmitterLayerView
+ (Class)layerClass {
    return [CAEmitterLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _emitterLayer = (CAEmitterLayer *)self.layer;
    }
    return self;
}

- (void)setEmitterLayer:(CAEmitterLayer *)layer {
    _emitterLayer = layer;
}

- (CAEmitterLayer *)emitterLayer {
    return _emitterLayer;
}

- (void)show {
    
}

- (void)hide {
    
}

@end
