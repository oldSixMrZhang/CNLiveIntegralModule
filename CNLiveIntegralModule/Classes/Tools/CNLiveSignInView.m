//
//  CNLiveSignInView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveSignInView.h"
#import "QMUIKit.h"
#import "YYKit.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "CNLiveCategory.h"

#import "CNLiveIntegralServiceProtocol.h"

#import "CNLiveSignInButtonView.h"
#import "CNLiveGoldWhereaboutsView.h"
#import "CNLiveRewardRulesView.h"

@interface CNLiveSignInView()
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) QMUIButton *scoreBtn;
@property (nonatomic, strong) UIButton *rulesBtn;
@property (nonatomic, strong) CNLiveSignInButtonView *signInButtonView;
@property (nonatomic, strong) UIButton *closeBtn;

@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *scores;
@property (nonatomic, assign) NSInteger day;

@end

@implementation CNLiveSignInView
static const NSInteger margin = 15;
+ (void)showWithScore:(NSString *)score scores:(NSString *)scores day:(NSInteger)day url:(NSString *)url{
    CNLiveSignInView *view = [[CNLiveSignInView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.4f];
    view.score = score;
    view.scores = scores;
    view.day = day;
    view.url = url;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
        [self xw_layoutSubviews];
        [self addAnimation];

    }
    return self;
}

#pragma mark - UI
- (void)setup {
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.scoreBtn];
    [self.bgView addSubview:self.signInButtonView];
    [self.bgView addSubview:self.rulesBtn];
    [self addSubview:self.closeBtn];
    
}
- (void)xw_layoutSubviews{
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(-20*(SCREEN_WIDTH/375.0));
        make.width.offset(335*(SCREEN_WIDTH/375.0));
        make.height.offset(335*(SCREEN_WIDTH/375.0)*370/335.0);

    }];
    
    [_scoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX).with.offset(0);
        make.top.equalTo(_bgView.mas_top).with.offset(45*(SCREEN_WIDTH/375.0));
        make.width.offset(120*(SCREEN_WIDTH/375.0));
        make.height.offset(40*(SCREEN_WIDTH/375.0));
        
    }];
    
    [_signInButtonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX).with.offset(0);
        make.top.equalTo(_scoreBtn.mas_bottom).with.offset(65*(SCREEN_WIDTH/375.0));
        make.width.offset(280*(SCREEN_WIDTH/375.0)+18);
        make.height.offset(160*(SCREEN_WIDTH/375.0)+5);

    }];
    
    [_rulesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX).with.offset(0);
        make.top.equalTo(_signInButtonView.mas_bottom).with.offset(0);
        make.bottom.equalTo(_bgView.mas_bottom).with.offset(-0);
        make.width.offset(100*(SCREEN_WIDTH/375.0));
        
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX).with.offset(0);
        make.top.equalTo(_bgView.mas_bottom).with.offset(margin*(SCREEN_WIDTH/375.0));
        make.width.offset(35*(SCREEN_WIDTH/375.0));
        make.height.offset(35*(SCREEN_WIDTH/375.0));
        
    }];
    
}

#pragma mark - Private Methods
- (void)addAnimation{
    _bgView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _bgView.left, _bgView.top);
    _closeBtn.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _closeBtn.left, _closeBtn.top);

    [UIView animateWithDuration:0.3f animations:^{
        _bgView.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        _closeBtn.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);

    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            _bgView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            _closeBtn.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);

        } completion:^(BOOL finished) {
            //  恢复原位
            _bgView.transform = CGAffineTransformIdentity;
            _closeBtn.transform = CGAffineTransformIdentity;

        }];
        
    }];
    
}
- (void)hiddenAction{
    _bgView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _closeBtn.layer.transform = CATransform3DMakeScale(1, 1, 1);

    [UIView animateWithDuration:0.3f animations:^{
        // 按照比例scalex=0.001,y=0.001进行缩小
        _bgView.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        _closeBtn.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);

    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveGoldWhereaboutsView class]]){
            [view removeFromSuperview];
            
        }
    }
}

#pragma mark - Data
- (void)setUrl:(NSString *)url{
    _url = url;
    
}
- (void)setScore:(NSString *)score{
    _score = score;
    [_scoreBtn setTitle:[NSString stringWithFormat:@"+%@",score] forState:UIControlStateNormal];

}
- (void)setDay:(NSInteger)day{
    _day = day;
    _signInButtonView.day = day;
}
- (void)setScores:(NSString *)scores{
    _scores = scores;
    _signInButtonView.scores = scores;

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - Action
- (void)clickRulesBtn:(UIButton *)btn{
    [self removeFromSuperview];
    [CNLiveRewardRulesView showWithUrl:self.url];
    
}
- (void)clickCloseBtn:(UIButton *)btn{
    [self hiddenAction];

}
#pragma mark - Lazy loading
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.userInteractionEnabled = YES;
        UIImage *image = [self getImageWithImageName:@"sign_allday_bg" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        _bgView.image = image;
    }
    return _bgView;
}
- (QMUIButton *)scoreBtn{
    if(_scoreBtn == nil){
        _scoreBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _scoreBtn.titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
//        [_scoreBtn addTarget:self action:@selector(clickScoreBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_scoreBtn setTitle:@"+0" forState:UIControlStateNormal];
        UIImage *image = [self getImageWithImageName:@"sign_in_soccer" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_scoreBtn setImage:image forState:UIControlStateNormal];
        [_scoreBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _scoreBtn.adjustsImageWhenHighlighted = NO;
        _scoreBtn.userInteractionEnabled = NO;
        _scoreBtn.spacingBetweenImageAndTitle = 5;
        _scoreBtn.imagePosition = QMUIButtonImagePositionRight;
    }
    return _scoreBtn;
    
}
- (CNLiveSignInButtonView *)signInButtonView{
    if(_signInButtonView == nil){
        _signInButtonView = [[CNLiveSignInButtonView alloc]initWithFrame:CGRectMake(0, 0, 280*(SCREEN_WIDTH/375.0)+50, 160*(SCREEN_WIDTH/375.0)+30)];

    }
    return _signInButtonView;
    
}

- (UIButton *)rulesBtn{
    if(_rulesBtn == nil){
        _rulesBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rulesBtn.titleLabel.font = UIFontMake(14);
        [_rulesBtn addTarget:self action:@selector(clickRulesBtn:) forControlEvents:UIControlEventTouchUpInside];
        [_rulesBtn setTitle:@"签到规则" forState:UIControlStateNormal];
        [_rulesBtn setTitleColor:[UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1.0] forState:UIControlStateNormal];
        _rulesBtn.adjustsImageWhenHighlighted = NO;
    }
    return _rulesBtn;
    
}
- (UIButton *)closeBtn{
    if(_closeBtn == nil){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.titleLabel.font = UIFontMake(12);
        [_closeBtn addTarget:self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [self getImageWithImageName:@"sign_day_close" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_closeBtn setImage:image forState:UIControlStateNormal];
        _closeBtn.adjustsImageWhenHighlighted = NO;

    }
    return _closeBtn;
    
}

@end
