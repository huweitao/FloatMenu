//
//  FloatMenu.h
//  AccountAuthService
//
//  Created by huweitao on 2019/4/19.
//  Copyright © 2019年 DMC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FloatModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FloatMenu : UIImageView

+ (void)show;
+ (void)showOnTopLevel;
+ (void)hide;
+ (void)setupItemIndex:(NSInteger)index title:(nullable NSString *)title icon:(nullable UIImage *)icon clickHandler:(nullable void (^)(NSInteger index))handler;

@end

NS_ASSUME_NONNULL_END
