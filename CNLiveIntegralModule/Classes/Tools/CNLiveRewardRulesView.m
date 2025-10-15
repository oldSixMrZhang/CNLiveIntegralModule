//
//  CNLiveRewardRulesView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveRewardRulesView.h"
#import <WebKit/WebKit.h>
#import "QMUIKit.h"
#import "YYKit.h"
#import <Masonry/Masonry.h>

#import "CNLiveGoldWhereaboutsView.h"

@interface CNLiveRewardRulesView()<WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) UIImageView *bgView;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) WKWebView *webView;

@end

@implementation CNLiveRewardRulesView
static const NSInteger margin = 0;

#pragma mark - Using Method
+ (void)showWithUrl:(NSString *)url{
    CNLiveRewardRulesView *view = [[CNLiveRewardRulesView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.4f];
    [view.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
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
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.closeBtn];
    [self.bgView addSubview:self.webView];
    [self addAnimation];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.width.offset(320*(SCREEN_WIDTH/375.0));
        make.height.offset(320*(SCREEN_WIDTH/375.0)*454/320.0);
        
    }];
    
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_bgView.mas_centerX).with.offset(0);
        make.bottom.equalTo(_bgView.mas_bottom).with.offset(-0);
        make.width.offset(100*(SCREEN_WIDTH/375.0));
        make.height.offset(56*(SCREEN_WIDTH/375.0));
        
    }];
    
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bgView.mas_top).with.offset(margin);
        make.left.equalTo(_bgView.mas_left).with.offset(margin);
        make.right.equalTo(_bgView.mas_right).with.offset(-margin);
        make.bottom.equalTo(_closeBtn.mas_top).with.offset(margin);
        
    }];
    
}

#pragma mark - Private Methods
- (void)addAnimation{
    _bgView.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _bgView.left, _bgView.top);
    [UIView animateWithDuration:0.3f animations:^{
        self->_bgView.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            self->_bgView.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            
        } completion:^(BOOL finished) {
            //  恢复原位
            self->_bgView.transform = CGAffineTransformIdentity;
            
        }];
        
    }];
    
}
- (void)hiddenAction{
    _bgView.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    [UIView animateWithDuration:0.3f animations:^{
        // 按照比例scalex=0.001,y=0.001进行缩小
        self->_bgView.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveGoldWhereaboutsView class]]){
            [view removeFromSuperview];
            
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
- (void)closeDidClicked:(UIButton *)btn{
    [self hiddenAction];
    
}

#pragma mark - Lazy loading
- (UIImageView *)bgView{
    if (!_bgView) {
        _bgView = [[UIImageView alloc] init];
        _bgView.userInteractionEnabled = YES;
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 25*(SCREEN_WIDTH/375.0);
        _bgView.layer.masksToBounds = YES;
    }
    return _bgView;
}

- (WKWebView *)webView {
    if (_webView == nil) {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.preferences = [WKPreferences new];
        config.preferences.javaScriptEnabled = YES;
        config.preferences.minimumFontSize = 15;
        config.preferences.javaScriptCanOpenWindowsAutomatically = YES;
        config.userContentController = [[WKUserContentController alloc]init];
        _webView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:config];
        _webView.navigationDelegate = self;
        _webView.UIDelegate = self;
        _webView.scrollView.bounces = NO;
        _webView.scrollView.exclusiveTouch = NO;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.layer.cornerRadius = 25*(SCREEN_WIDTH/375.0);
        _webView.layer.masksToBounds = YES;
    }
    return _webView;
}

- (UIButton *)closeBtn{
    if(_closeBtn == nil){
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.titleLabel.font = UIFontMake(15);
        [_closeBtn addTarget:self action:@selector(closeDidClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setTitle:@"我知道了" forState:UIControlStateNormal];
        [_closeBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0] forState:UIControlStateNormal];
        _closeBtn.adjustsImageWhenHighlighted = NO;
    }
    return _closeBtn;
}

@end
