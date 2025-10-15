//
//  CNLiveSignInButtonView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveSignInButtonView.h"

#import "QMUIKit.h"
#import "YYKit.h"
#import "CNLiveCategory.h"

#import "CNLiveSignInButtonSelectView.h"

@interface CNLiveSignInButtonView()
@property (nonatomic, strong) NSMutableArray *btnsArr;

@end
@implementation CNLiveSignInButtonView
static const NSInteger margin = 6;
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
    CGFloat width = 70*(SCREEN_WIDTH/375.0);
    CGFloat height = 80*(SCREEN_WIDTH/375.0);

    for(int i = 0; i < 7; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i<4?i*(width+margin):(i-4)*(width+margin), i<4?0:(margin+height), width, height);
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [self getImageWithImageName:@"sign_day_bg" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [btn setImage:image forState:UIControlStateNormal];
        btn.adjustsImageWhenHighlighted = NO;
        btn.userInteractionEnabled = NO;
        [self.btnsArr addObject:btn];
        [self addSubview:btn];
        
        if(i == 6){
            btn.width = 2*width+margin;
            UIImage *image = [self getImageWithImageName:@"sign_day_bg7" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
            [btn setImage:image forState:UIControlStateNormal];

        }
        
        CNLiveSignInButtonSelectView *view = [[CNLiveSignInButtonSelectView alloc]initWithFrame:btn.bounds];
        view.hidden = !btn.selected;
        [btn addSubview:view];

    }
    
}

#pragma mark - Setter
- (void)setScores:(NSString *)scores{
    _scores = scores;
    NSArray *arr = scores?[scores componentsSeparatedByString:@","]:@[@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000"];
    arr = arr.count == 7?arr:@[@"1000",@"2000",@"3000",@"4000",@"5000",@"6000",@"7000"];

    CGFloat width = 70*(SCREEN_WIDTH/375.0);
    CGFloat height = 80*(SCREEN_WIDTH/375.0);
    
    for(int i = 0; i < self.btnsArr.count; i++){
        UIButton *btn = self.btnsArr[i];
        CGFloat day_height =  30*(SCREEN_WIDTH/375.0);
        CGFloat score_height =  25*(SCREEN_WIDTH/375.0);
        
        UILabel *day = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, width, day_height)];
        day.textColor = [UIColor whiteColor];
        day.font = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        day.textAlignment = NSTextAlignmentCenter;
        day.text = [NSString stringWithFormat:@"第%d天",i+1];
        [btn addSubview:day];
        
        UILabel *score = [[UILabel alloc] initWithFrame:CGRectMake(0, height-score_height, width, score_height)];
        score.textColor = [UIColor whiteColor];
        score.font = [UIFont fontWithName:@"PingFangSC-Medium" size:11];
        score.textAlignment = NSTextAlignmentCenter;
        score.text = [NSString stringWithFormat:@"+%@",arr[i]];
        [btn addSubview:score];
        
        if(i == 6){
            day.frame = CGRectMake(2*margin, 0, width, day_height);
            day.textAlignment = NSTextAlignmentLeft;

            score.frame = CGRectMake(2*margin, height-score_height, width, score_height);
            score.textAlignment = NSTextAlignmentLeft;
            
        }
    }
}

- (void)setDay:(NSInteger)day{
    _day = day;
    for(int i = 0; i < self.btnsArr.count; i++){
        if(i >= day) break;
        UIButton *btn = self.btnsArr[i];
        for (UIView *view in btn.subviews) {
            if([view isKindOfClass:[CNLiveSignInButtonSelectView class]]){
                view.hidden = NO;
                btn.userInteractionEnabled = NO;
            }
        }
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - Action
- (void)clickBtn:(UIButton *)btn{
//    btn.selected = !btn.selected;
    for (UIView *view in btn.subviews) {
        if([view isKindOfClass:[CNLiveSignInButtonSelectView class]]){
            view.hidden = NO;
            btn.userInteractionEnabled = NO;
        }
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedSignInButton:day:)]) {
        [self.delegate clickedSignInButton:self day:@"1"];
        
    }
    
}
#pragma mark - Lazy loading
- (NSMutableArray *)btnsArr{
    if (!_btnsArr) {
        _btnsArr = [[NSMutableArray alloc] init];
       
    }
    return _btnsArr;
}

@end
