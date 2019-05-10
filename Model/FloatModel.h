//
//  FloatModel.h
//  AccountAuthService
//
//  Created by huweitao on 2019/4/19.
//  Copyright © 2019年 DMC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FloatItem.h"

NS_ASSUME_NONNULL_BEGIN

@interface FloatModel : NSObject

// Item相关操作
- (void)resetItemAtIndex:(NSInteger)index title:(NSString *)title icon:(UIImage *)icon handler:(FloatItemHandler)handler;
- (void)addItemList:(NSArray *)items;
- (void)addItem:(FloatItem *)item;
- (void)removeItemAtIndex:(NSInteger)index;
- (void)removeAllItems;

// Item View
- (void)refreshItemViewsOnSuperView:(UIView *)superView;
- (void)cleanItemViews;

@end

NS_ASSUME_NONNULL_END
