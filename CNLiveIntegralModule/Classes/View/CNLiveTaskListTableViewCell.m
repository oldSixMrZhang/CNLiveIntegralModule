//
//  CNLiveTaskListTableViewCell.m
//  CNLiveIntegralModule
//
//  Created by CNLiveLive-zxw on 2019/2/26.
//  Copyright © 2019年 CNLivelive. All rights reserved.
//

#import "CNLiveTaskListTableViewCell.h"
#import <Masonry/Masonry.h>
#import <SDWebImage/SDWebImage.h>
#import "QMUIKit.h"

#import "CNLiveTaskListModel.h"

@interface CNLiveTaskListTableViewCell()
@property (nonatomic, strong) UIImageView *leftImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *pointLabel;
@property (nonatomic, strong) UILabel *progressLabel;
@property (nonatomic, strong) UIButton *completeBtn;
@property (nonatomic, copy) NSString *type;

@end

@implementation CNLiveTaskListTableViewCell
static const NSInteger margin = 20;

#pragma mark - Init
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
        
    }
    return self;
}

#pragma mark - UI
- (void)setupUI{
    [self.contentView addSubview:self.leftImage];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.pointLabel];
    
    [self.contentView addSubview:self.progressLabel];
    [self.contentView addSubview:self.completeBtn];
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [_leftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(margin);
        make.left.equalTo(self.contentView.mas_left).with.offset(margin*3/4.0);
        make.width.offset(30);
        make.height.offset(30);
        
    }];
    
    [_completeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(margin);
        make.right.equalTo(self.contentView.mas_right).with.offset(-margin*3/4.0);
        make.height.offset(30);
        make.width.offset(60);
        
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(margin/2.0);
        make.left.equalTo(_leftImage.mas_right).with.offset(margin*3/4.0);
        make.right.equalTo(_completeBtn.mas_left).with.offset(-margin*3/4.0);
        make.height.offset(20);
        
    }];
    
    [_pointLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(margin/2.0);
        make.left.equalTo(_leftImage.mas_right).with.offset(margin*3/4.0);
        make.height.offset(10);
        
    }];
    
    [_progressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom).with.offset(margin/2.0);
        make.left.equalTo(_pointLabel.mas_right).with.offset(margin*3/4.0);
        make.height.offset(10);
        
    }];
    
}

#pragma mark - Data
- (void)setType:(NSString *)type{
    _type = type;
    if([type isEqualToString:@"update_face"]||[type isEqualToString:@"update_nick"]){//头像 昵称
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"publish_witness"]){//发布目击者
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"add_friend"]){//添加好友
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"publish_moment"]){//生活圈
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"share_video"]){//分享目击者视频
        [_completeBtn setTitle:@"去分享" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"share_article"]){//分享文章
        [_completeBtn setTitle:@"去分享" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"publish_comment"]){//评论
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"read_article"]){//看文章-> 视讯中国 -> 今日要闻
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"customer_feedback"]){//帮助与反馈
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"watch_video"]){//看视频 -> 视讯中国 -> 目击者
        [_completeBtn setTitle:@"去观看" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"check_in"]){//签到
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }
    else if ([type isEqualToString:@"listen_novel"]){//听小说
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
    }

}
- (void)setModel:(CNLiveTaskListItemModel *)model{
    _model = model;
    [_leftImage sd_setImageWithURL:[NSURL URLWithString:model.icon] completed:nil];
    _titleLabel.text = model.title;
    _pointLabel.text = [NSString stringWithFormat:@"积分值+%@",model.score];
    
    NSString *timesStr = [NSString stringWithFormat:@"完成%ld/%ld",(long)model.times,(long)model.totalCount];
    NSString *times = [NSString stringWithFormat:@"%ld",(long)model.times];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:timesStr];
    NSRange range = [timesStr rangeOfString:times];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0] range:range];
    _progressLabel.attributedText = str;
    self.type = model.taskId;
    if(model.times >= model.totalCount){
        [_completeBtn setTitle:@"已完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0] forState:UIControlStateNormal];
        _completeBtn.layer.borderColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0].CGColor;
        _completeBtn.userInteractionEnabled = NO;
        
    }else{
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0] forState:UIControlStateNormal];
        _completeBtn.layer.borderColor = [UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0].CGColor;
        _completeBtn.userInteractionEnabled = YES;

    }
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark - Private Methods

#pragma mark - Action
- (void)clickCompleteBtn:(UIButton *)btn{
//    btn.selected = !btn.selected;
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickedCellButton:type:)]) {
        [self.delegate clickedCellButton:self type:_type];
        
    }

}
#pragma mark - Lazy loading
- (UIImageView *)leftImage{
    if (!_leftImage) {
        _leftImage = [[UIImageView alloc] init];
        _leftImage.userInteractionEnabled = YES;

    }
    return _leftImage;
}
- (UILabel *)titleLabel{
    if(_titleLabel == nil){
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0];
        _titleLabel.font = UIFontMake(16);
        _titleLabel.userInteractionEnabled = YES;

    }
    return _titleLabel;
    
}
- (UILabel *)pointLabel{
    if(_pointLabel == nil){
        _pointLabel = [[UILabel alloc] init];
        _pointLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
        _pointLabel.font = UIFontMake(12);
        _pointLabel.userInteractionEnabled = YES;

    }
    return _pointLabel;
    
}
- (UILabel *)progressLabel{
    if(_progressLabel == nil){
        _progressLabel = [[UILabel alloc] init];
        _progressLabel.textColor = [UIColor colorWithRed:155/255.0 green:155/255.0 blue:155/255.0 alpha:1.0];
        _progressLabel.font = UIFontMake(12);
        _progressLabel.userInteractionEnabled = YES;
        
    }
    return _progressLabel;
    
}

- (UIButton *)completeBtn{
    if(_completeBtn == nil){
        _completeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _completeBtn.titleLabel.font = UIFontMake(12);
        _completeBtn.backgroundColor = [UIColor whiteColor];
        _completeBtn.layer.cornerRadius = 15;
        _completeBtn.layer.masksToBounds = YES;
        _completeBtn.layer.borderWidth = 1;
        [_completeBtn addTarget:self action:@selector(clickCompleteBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [_completeBtn setTitle:@"去完成" forState:UIControlStateNormal];
        [_completeBtn setTitleColor:[UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0] forState:UIControlStateNormal];
        _completeBtn.layer.borderColor = [UIColor colorWithRed:35/255.0 green:212/255.0 blue:30/255.0 alpha:1.0].CGColor;
        
    }
    return _completeBtn;
    
}

@end
