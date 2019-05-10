//
//  FloatModel.m
//  AccountAuthService
//
//  Created by huweitao on 2019/4/19.
//  Copyright © 2019年 DMC. All rights reserved.
//

#import "FloatModel.h"
#import "FloatItemView.h"

@interface FloatModel()

@property (nonatomic, strong) NSMutableArray *padItems;
@property (nonatomic, strong) NSMutableArray *padItemViews;

@end

@implementation FloatModel

#pragma mark - Getter

- (NSMutableArray *)padItems
{
    if (!_padItems) {
        _padItems = [NSMutableArray array];
    }
    return _padItems;
}

- (NSMutableArray *)padItemViews
{
    if (!_padItemViews) {
        _padItemViews = [NSMutableArray array];
    }
    return _padItemViews;
}

#pragma mark - Public

#pragma mark - Item相关操作

- (void)addItemWithTitle:(NSString *)title icon:(UIImage *)icon frame:(CGRect)frame handler:(FloatItemHandler)handler
{
    FloatItem *item = [FloatItem new];
    item.title = title;
    item.icon = icon;
    item.handler = handler;
    item.itemFrame = frame;
    [self addItem:item];
}


- (void)addItemList:(NSArray *)items
{
    for (FloatItem *item in items) {
        [self addItem:item];
    }
}

- (void)addItem:(FloatItem *)item
{
    if (!item || ![item isKindOfClass:[FloatItem class]]) {
        return;
    }
    @synchronized (self) {
        [self.padItems addObject:item];
    }
}

- (void)removeItemAtIndex:(NSInteger)index
{
    if (index < 0 || index >= self.padItems.count) {
        return;
    }
    @synchronized (self) {
        [self.padItems removeObjectAtIndex:index];
    }
}

- (void)removeAllItems
{
    @synchronized (self) {
        [self.padItems removeAllObjects];
    }
}

#pragma mark - ItemView相关操作

- (void)refreshItemViewsOnSuperView:(UIView *)superView
{
    if (!superView) {
        return;
    }
    // clean
    [self cleanItemViews];
    // check
    if (self.padItems.count == 0) {
        return;
    }
    for (FloatItem *item in self.padItems) {
        FloatItemView *v = [[FloatItemView alloc] initWithItem:item];
        [self.padItemViews addObject:v];
        [superView addSubview:v];
    }
}

- (void)cleanItemViews
{
    for (FloatItemView *fv in self.padItemViews) {
        [fv removeFromSuperview];
    }
    @synchronized (self) {
        [self.padItemViews removeAllObjects];
    }
}

@end
