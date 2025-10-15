//
//  CNLiveAddScoreView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/28.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveAddScoreView.h"

#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "QMUIKit.h"
#import "YYKit.h"

#import "CNLiveIntegralServiceProtocol.h"
#import "NSString+CNLiveExtension.h"
#import "CNLiveCategory.h"

#import "CNLiveGoldWhereaboutsView.h"

@interface CNLiveAddScoreView()
@property (nonatomic, strong) UIImageView *midImage;
@property (nonatomic, strong) UIButton *scoreBtn;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UIButton *colseBtn;

@property (nonatomic, strong) UILabel *descLabel;

@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *desc;

@end

@implementation CNLiveAddScoreView
#pragma mark - Using Method
+ (void)showWithDesc:(NSString *)desc score:(NSString *)score{
    CNLiveAddScoreView *view = [[CNLiveAddScoreView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.4f];
    view.desc = desc;
    view.score = score;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
    
}
+ (void)showWithDesc:(NSString *)desc score:(NSString *)score delegate:(id<CNLiveAddScoreViewDelegate>)delegate {
    CNLiveAddScoreView *view = [[CNLiveAddScoreView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    view.backgroundColor = [UIColor colorWithWhite:0.2f alpha:0.4f];
    view.desc = desc;
    view.score = score;
    view.delegate = delegate;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
        [self setupUI];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickedClose)];
        [self addGestureRecognizer:tap];
    }
    return self;
}
#pragma mark - UI
- (void)setupUI{
    [self addSubview:self.midImage];
    [self addSubview:self.scoreBtn];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.colseBtn];
    [self addSubview:self.descLabel];
    
    [self xw_layoutSubviews];
    
    [self addAnimation];
}

- (void)xw_layoutSubviews{
    [_midImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-30*(SCREEN_WIDTH/375.0));
        make.width.offset(SCREEN_WIDTH);
        make.height.offset(SCREEN_WIDTH);
        
    }];
    [_scoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(_midImage.mas_bottom);
        make.width.offset(160*(SCREEN_WIDTH/375.0));
        make.height.offset(44*(SCREEN_WIDTH/375.0));
        
    }];
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.bottom.equalTo(_midImage.mas_bottom).with.offset(-2*(SCREEN_WIDTH/375.0));
        make.width.offset(160*(SCREEN_WIDTH/375.0));
        make.height.offset(44*(SCREEN_WIDTH/375.0));
        
    }];
    [_colseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_midImage.mas_top).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-10*(SCREEN_WIDTH/375.0));
        make.width.height.offset(30*(SCREEN_WIDTH/375.0));
        
    }];
    [_descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.centerY.equalTo(self.mas_centerY).with.offset(-35*(SCREEN_WIDTH/375.0));
        make.width.offset(150*(SCREEN_WIDTH/375.0));
        make.height.offset(80*(SCREEN_WIDTH/375.0));
        
    }];
    
}

#pragma mark - Data
- (void)setScore:(NSString *)score{
    _score = score;
    if([score isEqualToString:@"立即登录"]){
        _scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
        _scoreLabel.text = score;
    }else{
        _scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
        _scoreLabel.text = [NSString stringWithFormat:@"+%@",score];
    }
    
}

- (void)setDesc:(NSString *)desc{
    _desc = desc;
    
    NSMutableString *str = [[NSMutableString alloc]initWithString:desc];
    
    CGSize size = [@"钱" textSizeIn:CGSizeMake(HUGE_VAL, HUGE_VAL) font:_descLabel.font];
    NSInteger characters1 = ceil(140*(SCREEN_WIDTH/375.0)/size.width);
    NSInteger characters2 = ceil(110*(SCREEN_WIDTH/375.0)/size.width);
    NSInteger characters3 = ceil(90*(SCREEN_WIDTH/375.0)/size.width);

    if(str.length > characters1){
        [str insertString:@"\n"atIndex:characters1];
    }
    if(str.length > characters1+characters2){
        [str insertString:@"\n"atIndex:characters1+characters2];
    }
    if(str.length > characters1+characters2+characters3){
        [str insertString:@"\n"atIndex:characters1+characters2+characters3];
    }
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
    paragraphStyle.lineSpacing = 10*(SCREEN_WIDTH/375.0);
    paragraphStyle.alignment = NSTextAlignmentCenter;
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    [attributes setObject:paragraphStyle forKey:NSParagraphStyleAttributeName];
    _descLabel.attributedText = [[NSAttributedString alloc] initWithString:str attributes:attributes];
    
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

#pragma mark - Private Methods
- (void)addAnimation{
    _midImage.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _midImage.left, _midImage.top);
    _scoreBtn.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _scoreBtn.left, _scoreBtn.top);
    _scoreLabel.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _scoreLabel.left, _scoreLabel.top);
    _colseBtn.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _scoreLabel.left, _scoreLabel.top);
    _descLabel.transform = CGAffineTransformMake(0.01, 0, 0, 0.01, _scoreLabel.left, _scoreLabel.top);
    
    [UIView animateWithDuration:0.3f animations:^{
        self->_midImage.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        self->_scoreBtn.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        self->_scoreLabel.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        self->_colseBtn.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        self->_descLabel.transform = CGAffineTransformMake(1.05f, 0, 0, 1.0f, 0, 0);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.1f animations:^{
            self->_midImage.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_scoreBtn.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_scoreLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_colseBtn.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            self->_descLabel.transform = CGAffineTransformMake(1, 0, 0, 1, 0, 0);
            
        } completion:^(BOOL finished) {
            //  恢复原位
            self->_midImage.transform = CGAffineTransformIdentity;
            self->_scoreBtn.transform = CGAffineTransformIdentity;
            self->_scoreLabel.transform = CGAffineTransformIdentity;
            self->_colseBtn.transform = CGAffineTransformIdentity;
            self->_descLabel.transform = CGAffineTransformIdentity;
            
        }];
        
    }];
    
}
- (void)hiddenAction{
    _midImage.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _scoreBtn.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _scoreLabel.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _colseBtn.layer.transform = CATransform3DMakeScale(1, 1, 1);
    _descLabel.layer.transform = CATransform3DMakeScale(1, 1, 1);
    
    [UIView animateWithDuration:0.3f animations:^{
        // 按照比例scalex=0.001,y=0.001进行缩小
        _midImage.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        _scoreBtn.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        _scoreLabel.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        _colseBtn.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        _descLabel.layer.transform = CATransform3DMakeScale(0.001, 0.001, 1);
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
    
}

#pragma mark - Action
+ (void)hide {
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveGoldWhereaboutsView class]]){
            [view removeAllSubviews];
            [view removeFromSuperview];
            
        }
    }
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveAddScoreView class]]){
            [view removeAllSubviews];
            [view removeFromSuperview];
            
        }
    }
    
}
- (void)clickedClose {
    [self hiddenAction];
    
    for (UIView *view in [UIApplication sharedApplication].keyWindow.subviews) {
        if([view isKindOfClass:[CNLiveGoldWhereaboutsView class]]){
            [view removeFromSuperview];
            
        }
    }
}
- (void)clickedCloseBtn:(UIButton *)btn{
    [self clickedClose];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(loginNow)]) {
        [self.delegate loginNow];
    }
}

#pragma mark - Lazy loading
- (UIImageView *)midImage{
    if (!_midImage) {
        _midImage = [[UIImageView alloc] init];
        _midImage.userInteractionEnabled = YES;
        UIImage *image = [self getImageWithImageName:@"add_score_bg" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        _midImage.image = image;
        _midImage.contentMode = UIViewContentModeCenter;
    }
    return _midImage;
}
- (UIButton *)scoreBtn{
    if (!_scoreBtn) {
        _scoreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _scoreBtn.adjustsImageWhenHighlighted = NO;
        UIImage *image = [self getImageWithImageName:@"add_score_label" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_scoreBtn setImage:image forState:UIControlStateNormal];
        [_scoreBtn addTarget:self action:@selector(clickedCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _scoreBtn;
}
- (UILabel *)scoreLabel{
    if(!_scoreLabel){
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.textColor = [UIColor colorWithRed:133/255.0 green:64/255.0 blue:4/255.0 alpha:1.0];
        _scoreLabel.userInteractionEnabled = NO;
        _scoreLabel.layer.cornerRadius = 20*(SCREEN_WIDTH/375.0);
        _scoreLabel.layer.masksToBounds = YES;
        _scoreLabel.textAlignment = NSTextAlignmentCenter;
        _scoreLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:30];
    }
    return _scoreLabel;
}
- (UIButton *)colseBtn{
    if(!_colseBtn){
        _colseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_colseBtn addTarget:self action:@selector(clickedClose) forControlEvents:UIControlEventTouchUpInside];
        UIImage *image = [self getImageWithImageName:@"add_score_close" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_colseBtn setImage:image forState:UIControlStateNormal];
        
    }
    return _colseBtn;
}
- (UILabel *)descLabel{
    if(!_descLabel){
        _descLabel = [[UILabel alloc] init];
        _descLabel.textColor = [UIColor colorWithRed:160/255.0 green:17/255.0 blue:13/255.0 alpha:1.0];
        _descLabel.userInteractionEnabled = NO;
        _descLabel.textAlignment = NSTextAlignmentCenter;
        _descLabel.numberOfLines = 3;
        _descLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _descLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:16*(SCREEN_WIDTH/375.0)];
        
    }
    return _descLabel;
}


@end
