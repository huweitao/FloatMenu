//
//  FloatItem.h
//  AccountAuthService
//
//  Created by huweitao on 2019/4/19.
//  Copyright © 2019年 DMC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FloatItemHandler)(NSInteger index);

@interface FloatItem : NSObject

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *icon;
@property (nonatomic, assign) CGRect itemFrame;
@property (nonatomic, copy) FloatItemHandler handler;

@end

NS_ASSUME_NONNULL_END
