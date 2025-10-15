//
//  CNLiveTaskListHeaderView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveTaskListHeaderView.h"
#import "QMUIKit.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>

#import "CNUserInfoManager.h"
#import "CNLiveCategory.h"

@interface CNLiveTaskListHeaderView()
@property (nonatomic, strong) UIImageView *headView;
@property (nonatomic, strong) UILabel *currentScore;
@property (nonatomic, strong) UILabel *getScore;
@property (nonatomic, strong) QMUIButton *detailBtn;

@end

@implementation CNLiveTaskListHeaderView
static const NSInteger margin = 15;
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = YES;
        [self setup];
    }
    return self;
}

#pragma mark - UI
- (void)setup {
    [self addSubview:self.headView];
    [self addSubview:self.currentScore];
    [self addSubview:self.getScore];
    [self addSubview:self.detailBtn];

}

- (void)layoutSubviews{
    [super layoutSubviews];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.top.equalTo(self.mas_top).with.offset(25*SCREEN_WIDTH/375.0+NavigationContentTop);
        make.width.height.offset(50*SCREEN_WIDTH/375.0);
        
    }];
    [_currentScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_right).with.offset(margin);
        make.top.equalTo(_headView.mas_top);
        make.width.offset(100);
        make.height.offset(15*SCREEN_WIDTH/375.0);

    }];
    [_getScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_headView.mas_right).with.offset(margin);
        make.top.equalTo(_currentScore.mas_bottom).with.offset(0);
        make.height.offset(35*SCREEN_WIDTH/375.0);

    }];
    [_detailBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_getScore.mas_right).with.offset(2*margin);
        make.centerY.equalTo(_getScore.mas_centerY);

    }];
    
}
#pragma mark - Data
- (void)setScore:(NSString *)score{
    _score = score;
    _getScore.text = [score floatValue] > 10000.0?[NSString stringWithFormat:@"%.2lfw",[score floatValue]/10000.0]:score;

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
#pragma mark - Action
- (void)clickedDetailButton:(UIButton *)btn{
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedDetailButton:)]) {
        [self.delegate clickedDetailButton:self];
        
    }
}
#pragma mark - Lazy loading
- (UIImageView *)headView{
    if (!_headView) {
        _headView = [[UIImageView alloc] init];
        _headView.userInteractionEnabled = YES;
        _headView.layer.cornerRadius = 25*SCREEN_WIDTH/375.0;
        _headView.layer.masksToBounds = YES;
        _headView.layer.borderColor = [UIColor whiteColor].CGColor;
        _headView.layer.borderWidth = 1.5;
        UIImage *xw_image = [self getImageWithImageName:@"default_avatar_f" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_headView sd_setImageWithURL:[NSURL URLWithString:CNUserShareModel.faceUrl] placeholderImage:xw_image];

    }
    return _headView;
}
- (UILabel *)currentScore{
    if(_currentScore == nil){
        _currentScore = [[UILabel alloc] init];
        _currentScore.textColor = [UIColor whiteColor];
        _currentScore.font = UIFontMake(14);
        _currentScore.userInteractionEnabled = YES;
        _currentScore.text = @"当前积分";
        
    }
    return _currentScore;
    
}
- (UILabel *)getScore{
    if(_getScore == nil){
        _getScore = [[UILabel alloc] init];
        _getScore.textColor = [UIColor whiteColor];
        _getScore.font = UIFontMake(32);
        _getScore.userInteractionEnabled = YES;
        _getScore.text = @"0.00";

    }
    return _getScore;
    
}
- (QMUIButton *)detailBtn{
    if(_detailBtn == nil){
        _detailBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _detailBtn.adjustsButtonWhenHighlighted = NO;
        _detailBtn.titleLabel.font = UIFontMake(12);
        [_detailBtn addTarget:self action:@selector(clickedDetailButton:) forControlEvents:UIControlEventTouchUpInside];
        [_detailBtn setTitle:@"明细" forState:UIControlStateNormal];
        UIImage *image = [self getImageWithImageName:@"integrate_next_white" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_detailBtn setImage:image forState:UIControlStateNormal];
        [_detailBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _detailBtn.spacingBetweenImageAndTitle = 5;
        _detailBtn.imagePosition = QMUIButtonImagePositionRight;
    }
    return _detailBtn;
    
}

@end
