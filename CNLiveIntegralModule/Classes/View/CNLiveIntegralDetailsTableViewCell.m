//
//  CNLiveIntegralDetailsTableViewCell.m
//  CNLiveIntegralModule
//
//  Created by CNLive-zxw on 2019/3/1.
//  Copyright © 2019年 cnlive. All rights reserved.
//

#import "CNLiveIntegralDetailsTableViewCell.h"
#import "QMUIKit.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "CNLiveCategory.h"

#import "CNLiveScoreModel.h"

@interface CNLiveIntegralDetailsTableViewCell()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) QMUIButton *scoresBtn;
@property (nonatomic, strong) UIView *line;

@end

@implementation CNLiveIntegralDetailsTableViewCell
static const NSInteger margin = 15;

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        [self xw_layoutSubviews];

    }
    return self;
}

#pragma mark - UI
- (void)setupUI{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.scoresBtn];
    [self.contentView addSubview:self.line];

}
- (void)xw_layoutSubviews{
    [_scoresBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-margin);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(margin);
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.right.lessThanOrEqualTo(_scoresBtn.mas_left).offset(-margin);

    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-margin);
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.right.equalTo(_scoresBtn.mas_left).with.offset(-margin);

    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.left.equalTo(self.mas_left).with.offset(margin);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.offset(0.5);
        
    }];
    
}

#pragma mark - Data
- (void)setModel:(CNLiveScoreModel *)model{
    _model = model;
    _titleLabel.text = model.title;
    _timeLabel.text = model.date;
    [_scoresBtn setTitle:[NSString stringWithFormat:@"%@%@",[model.source isEqualToString:@"1"]?@"+":@"-",model.integral] forState:UIControlStateNormal];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

#pragma mark - Lazy loading
- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor blackColor];
        _titleLabel.font = UIFontMake(17);
        
    }
    return _titleLabel;
    
}
- (UILabel *)timeLabel{
    if(_timeLabel == nil){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor colorWithRed:136/255.0 green:136/255.0 blue:136/255.0 alpha:1.0];
        _timeLabel.font = UIFontMake(11);
        _timeLabel.userInteractionEnabled = YES;
        
    }
    return _timeLabel;
    
}

- (QMUIButton *)scoresBtn{
    if(_scoresBtn == nil){
        _scoresBtn = [QMUIButton buttonWithType:UIButtonTypeCustom];
        _scoresBtn.titleLabel.font = UIFontMake(14);
        [_scoresBtn setTitleColor:[UIColor colorWithRed:249/255.0 green:171/255.0 blue:37/255.0 alpha:1.0] forState:UIControlStateNormal];
        UIImage *image = [self getImageWithImageName:@"mf_soccer_smallcoin" bundleName:@"CNLiveIntegralModule" targetClass:[self class]];
        [_scoresBtn setImage:image forState:UIControlStateNormal];
        _scoresBtn.adjustsImageWhenHighlighted = NO;
        _scoresBtn.spacingBetweenImageAndTitle = 5;
        _scoresBtn.imagePosition = QMUIButtonImagePositionRight;
    }
    return _scoresBtn;
    
}

- (UIView *)line{
    if(_line == nil){
        _line = [[UIView alloc] init];
        _line.backgroundColor = [UIColor colorWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1.0];
    }
    return _line;
    
}

@end
