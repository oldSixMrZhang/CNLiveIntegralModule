//
//  CNLiveSignInButtonSelectView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveSignInButtonSelectView.h"
#import "CNLiveCategory.h"

@interface CNLiveSignInButtonSelectView()
@property (nonatomic, strong) UIImageView *selectView;

@end

@implementation CNLiveSignInButtonSelectView
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.selectView];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - Lazy loading
- (UIImageView *)selectView{
    if (!_selectView) {
        _selectView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 27, 27)];
        _selectView.center = self.center;
        _selectView.userInteractionEnabled = YES;
        UIImage *image = [self getImageWithImageName:@"sign_day_select" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        _selectView.image = image;
    }
    return _selectView;
}

@end
