//
//  CNLiveTaskListSectionHeaderView.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/2/20.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveTaskListSectionHeaderView.h"
#import "QMUIKit.h"

@interface CNLiveTaskListSectionHeaderView()
/** 内部的label */
@property (nonatomic, weak) UILabel *label;

@end

@implementation CNLiveTaskListSectionHeaderView
static const NSInteger margin = 15;

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(margin, 0, 200, 45)];
        label.textColor = [UIColor blackColor];
        label.font = UIFontMake(16);
        label.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    return self;
}


- (void)setText:(NSString *)text{
    self.label.text = text;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

