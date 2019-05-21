//
//  FloatItemView.m
//  AccountAuthService
//
//  Created by huweitao on 2019/5/6.
//  Copyright © 2019年 DMC. All rights reserved.
//

#import "FloatItemView.h"

@interface FloatItemView()

@property (nonatomic, strong) UIImageView *iconV;
@property (nonatomic, strong) UILabel *lab;
@property (nonatomic, strong) FloatItem *item;

@end

@implementation FloatItemView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        [self addTarget:self action:@selector(itemViewClick:) forControlEvents:UIControlEventTouchUpInside];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)initWithItem:(FloatItem *)item
{
    if (self = [super init]) {
        _item = item;
        self.frame = _item.itemFrame;
        [self configureSubViews];
    }
    return self;
}

- (void)configureSubViews
{
    CGFloat ratio = 0.7;
    CGFloat w = self.frame.size.width;
    CGFloat iconH = floor(self.frame.size.height * ratio);
    CGFloat labH = self.frame.size.height - iconH;
    self.iconV.frame = CGRectMake((w - iconH) / 2, 0, iconH, iconH);
    self.lab.frame = CGRectMake(0, iconH, w, labH);
    
    [self addSubview:self.iconV];
    [self addSubview:self.lab];
    
    //
    self.lab.text = self.item.title;
    self.iconV.image = self.item.icon;
}

#pragma mark - IBAction

- (IBAction)itemViewClick:(UIButton *)sender
{
    if (self.item && self.item.handler) {
        self.item.handler(self.item.index);
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:[kShrinkMenu copy] object:nil];
}

#pragma mark - Getter

- (UIImageView *)iconV
{
    if (!_iconV) {
        _iconV = [UIImageView new];
    }
    return _iconV;
}

- (UILabel *)lab
{
    if (!_lab) {
        _lab = [UILabel new];
        _lab.font = [UIFont systemFontOfSize:12];
        _lab.textColor = [UIColor whiteColor];
        _lab.numberOfLines = 0;
        _lab.textAlignment = NSTextAlignmentCenter;
    }
    return _lab;
}

@end
