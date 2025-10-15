//
//  CNLiveGoldWhereaboutsView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveGoldWhereaboutsView.h"
#import <AVFoundation/AVFoundation.h>

//#import "CNAudioOrVideoMananger.h"
//#import "CNAudioPlayerManager.h"
//#import "LVCPlayer.h"
#import "CNLiveCategory.h"
#import "CNLiveIntegralServiceProtocol.h"

#import "CNLiveAddScoreView.h"
#import "CNLiveSignInView.h"
#import "CNLiveScoreModel.h"

@interface CNLiveGoldWhereaboutsView()<CNLiveAddScoreViewDelegate>
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *score;

@property (nonatomic, strong) CNLiveScoreModel *model;

@property (nonatomic, weak) id delegate;

@end
@implementation CNLiveGoldWhereaboutsView
#pragma mark - Using Method
+ (void)showWithDesc:(NSString *)desc delegate:(id)delegate{//浏览加积分
    CNLiveGoldWhereaboutsView *sView = [[CNLiveGoldWhereaboutsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    sView.desc = desc;
    sView.delegate = delegate;
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    [sView show:CNLiveGoldWhereaboutsViewTypeLogin];
}

+ (void)showWithDesc:(NSString *)desc score:(NSString *)score{
    CNLiveGoldWhereaboutsView *sView = [[CNLiveGoldWhereaboutsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    sView.desc = desc;
    sView.score = score;
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    [sView show:CNLiveGoldWhereaboutsViewTypeAddScore];
    
}

+ (void)showWithModel:(CNLiveScoreModel *)model {
    CNLiveGoldWhereaboutsView *sView = [[CNLiveGoldWhereaboutsView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    sView.model = model;
    [[UIApplication sharedApplication].keyWindow addSubview:sView];
    [sView show:CNLiveGoldWhereaboutsViewTypeSignIn];
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

#pragma mark - UI
- (void)setup {
    //初始化一些参数
    self.emitterLayer.masksToBounds = YES;
    self.emitterLayer.emitterShape = kCAEmitterLayerLine;
    self.emitterLayer.emitterMode = kCAEmitterLayerSurface;
    self.emitterLayer.emitterSize = self.frame.size;
    self.emitterLayer.emitterPosition = CGPointMake(self.bounds.size.width/2.0, -20);

}

#pragma mark - Private Methods
- (void)show:(CNLiveGoldWhereaboutsViewType)type {
    
    self.emitterLayer.birthRate = 4;

    NSMutableArray *arr = [[NSMutableArray alloc]init];

    for (int i = 1; i <= 4; i++) {
        __block CAEmitterCell *snowFlake = [CAEmitterCell emitterCell];
        snowFlake.birthRate = 2.5f;
        snowFlake.yAcceleration = 2500.f;
        snowFlake.emissionRange = 0.5 * M_PI;
        snowFlake.spinRange = 0.25 * M_PI;
        
        UIImage *image = [self getImageWithImageName:[NSString stringWithFormat:@"gold_whereabouts%d",i] bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        snowFlake.contents = (__bridge id _Nullable)(image.CGImage);
        snowFlake.lifetime = 100.f;

        snowFlake.scale = 0.08;
        snowFlake.scaleRange = 0.08;
        snowFlake.velocity = 0.0;
        snowFlake.velocityRange = 100.f;
        
        [arr addObject:snowFlake];

    }
    self.emitterLayer.emitterCells = arr;

    [self controlAmountOfGoldCOINS:arr];
    
    NSString *sounds = [[NSUserDefaults standardUserDefaults] valueForKey:@"GoldCoinSound"];//0有声音 1没声音
//    if (!(sounds && [sounds isEqualToString:@"1"])) {//0有声音
//        if(![CNAudioOrVideoMananger IsEnter] && ![[CNAudioPlayerManager sharedInstance] isPlaying] && ![LVCPlayer currentVCIsPalyer]){//不在语音通话
//            AVAudioSession *audioSession = [AVAudioSession sharedInstance];
//            [audioSession setCategory:AVAudioSessionCategoryAmbient error:nil];
//            [audioSession setActive:YES error:nil];
//        }
//    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleUrl = [bundle URLForResource:@"CNLiveIntegralModule" withExtension:@"bundle"];
    NSBundle *targetBundle = [NSBundle bundleWithURL:bundleUrl];
    NSURL *url = [NSURL fileURLWithPath:[targetBundle pathForResource:@"gold_whereabouts" ofType:@"mp3"]];
    __block AVAudioPlayer *soundPlayer = [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    if (!(sounds && [sounds isEqualToString:@"1"])) {//0有声音
        soundPlayer.volume = 0.5;//0.0~1.0之间
        [soundPlayer prepareToPlay];
        [soundPlayer play];//播放
    }
    
    //停止金币产生
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.emitterLayer setValue:@0.f forKeyPath:@"birthRate"];

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [soundPlayer stop];//播放
        if(soundPlayer){
            soundPlayer = nil;

        }
        if (!(sounds && [sounds isEqualToString:@"1"])) {
//            if(![CNAudioOrVideoMananger IsEnter] && ![[CNAudioPlayerManager sharedInstance] isPlaying]){//不在语音通话
//                //金币下落结束
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"CNLiveGoldWhereaboutsViewEnd" object:nil];
//            }
        }
        
        switch (type) {
            case CNLiveGoldWhereaboutsViewTypeSignIn://签到
            {
                [CNLiveSignInView showWithScore:self.model.score scores:self.model.scores.count>0?self.model.scores[0]:@"1000,2000,3000,4000,5000,6000,7000" day:self.model.times url:self.model.url];
            }
                break;
                
            case CNLiveGoldWhereaboutsViewTypeAddScore://增加积分
            {
                if(self.score && ![self.score isEqualToString:@""] && self.desc && ![self.desc isEqualToString:@""]){
                    [CNLiveAddScoreView showWithDesc:self.desc score:self.score];
                }else{
                    [self hide];
                }
            }
                break;
                
            case CNLiveGoldWhereaboutsViewTypeLogin://立即登录
            {
                if(self.desc && ![self.desc isEqualToString:@""]){
                    [CNLiveAddScoreView showWithDesc:self.desc score:@"立即登录" delegate:self.delegate];
                }else{
                    [self hide];
                }

            }
                break;
        }
        
        
    });
    
}

- (void)hide {
    [self removeFromSuperview];
    
}

+ (void)hide {
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveGoldWhereaboutsView class]]){
            [view removeFromSuperview];
            
        }
    }

}

- (void)controlAmountOfGoldCOINS:(NSMutableArray *)arr{
    
    __block CAEmitterCell *snowFlake0 = arr[0];
    __block CAEmitterCell *snowFlake1 = arr[1];
    __block CAEmitterCell *snowFlake2 = arr[2];
    __block CAEmitterCell *snowFlake3 = arr[3];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        snowFlake0.birthRate = 4;
        snowFlake1.birthRate = 4;
        snowFlake2.birthRate = 4;
        snowFlake3.birthRate = 4;
        [self.emitterLayer setValue:@4.f forKeyPath:@"birthRate"];

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        snowFlake0.birthRate = 1;
        snowFlake1.birthRate = 1;
        snowFlake2.birthRate = 1;
        snowFlake3.birthRate = 1;
        [self.emitterLayer setValue:@4.f forKeyPath:@"birthRate"];

    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        snowFlake0.birthRate = 1;
        snowFlake1.birthRate = 0;
        snowFlake2.birthRate = 1;
        snowFlake3.birthRate = 0;
        [self.emitterLayer setValue:@1.f forKeyPath:@"birthRate"];
        
    });
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        snowFlake0.birthRate = 1;
        snowFlake1.birthRate = 1;
        snowFlake2.birthRate = 1;
        snowFlake3.birthRate = 0;
        [self.emitterLayer setValue:@4.f forKeyPath:@"birthRate"];

    });
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (void)dealloc{
    NSLog(@"CNLiveGoldWhereaboutsView - dealloc");
}

- (void)loginNow{
    [self hide];
}

@end
