//
//  FloatMenu.m
//  AccountAuthService
//
//  Created by huweitao on 2019/4/19.
//  Copyright © 2019年 DMC. All rights reserved.
//

#define FLOATMENU_TAG 100086
//获取屏幕宽高
#define MScreenWidth  [[UIScreen mainScreen] bounds].size.width
#define MScreenHeight [[UIScreen mainScreen] bounds].size.height

// const
const CGFloat MenuLength = 66;
const NSInteger EnlargeRatio = 4;

#pragma mark - UIView Extension

@interface UIView (pad_extension)

@property (nonatomic, assign) CGFloat x; // x值
@property (nonatomic, assign) CGFloat y; // y值
@property (nonatomic, assign) CGFloat width; // 宽
@property (nonatomic, assign) CGFloat height; // 高
@property (nonatomic, assign) CGSize  size; // size
@property (nonatomic, assign) CGPoint origin; // 点
@property (nonatomic, assign) CGFloat centerX; // 中心点X值
@property (nonatomic, assign) CGFloat centerY; // 中心点Y值

@end

@implementation UIView (pad_extension)

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}


-(CGFloat)width
{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height
{
    return self.frame.size.height;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}
-(void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}
@end

#import "FloatMenu.h"
#import "Base64Images.h"

@interface FloatMenu()

@property (nonatomic, assign) CGPoint beginPoint;
@property (nonatomic, assign) BOOL isLargeSize;
@property (nonatomic, strong) FloatModel *itemsModel;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation FloatMenu

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
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onShouldShrinkMenu:) name:[kShrinkMenu copy] object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Public

#pragma mark - Class methods

+ (void)setupDefaultItemViews
{
    FloatMenu *fMenu = [self createFloatMenu];
    if (!fMenu) {
        return;
    }
    
    NSArray *itemList = [self createDefaultItems];
    [fMenu.itemsModel addItemList:itemList];
}

+ (void)showDefaultItemViews
{
    FloatMenu *fMenu = [self createFloatMenu];
    if (!fMenu) {
        return;
    }
    [fMenu showDefaultItemViews];
}

+ (void)hideDefaultItemViews
{
    FloatMenu *fMenu = [self createFloatMenu];
    if (!fMenu) {
        return;
    }
    [fMenu hideDefaultItemViews];
}

+ (void)show
{
    UIWindow *keyWindow = [self getCurrentKeyWindow];
    if (!keyWindow) {
        return;
    }
    
    FloatMenu *fMenu = [self createFloatMenu];
    if (fMenu) {
        [keyWindow addSubview:fMenu];
    }
    
    // refresh item view
    [self setupDefaultItemViews];
}

+ (void)hide
{
    UIWindow *keyWindow = [self getCurrentKeyWindow];
    if (!keyWindow) {
        return;
    }
    
    FloatMenu *menu = [keyWindow viewWithTag:FLOATMENU_TAG];
    if (menu) {
        [menu removeFromSuperview];
    }
}

+ (void)setupItemIndex:(NSInteger)index title:(nullable NSString *)title icon:(nullable UIImage *)icon clickHandler:(nullable void (^)(NSInteger index))handler
{
    FloatMenu *fMenu = [self createFloatMenu];
    if (!fMenu) {
        return;
    }
    [fMenu.itemsModel resetItemAtIndex:index title:title icon:icon handler:handler];
}

+ (FloatMenu *)createFloatMenu
{
    UIWindow *keyWindow = [self getCurrentKeyWindow];
    if (!keyWindow) {
        return nil;
    }
    
    // reuse
    FloatMenu *menu = [keyWindow viewWithTag:FLOATMENU_TAG];
    if (menu) {
        return menu;
    }
    
    // init menu
    FloatMenu *fMenu = [FloatMenu new];
    fMenu.frame = CGRectMake(0, 0, MenuLength, MenuLength);
    fMenu.backgroundColor = [[UIColor grayColor] colorWithAlphaComponent:0.9];
    fMenu.tag = FLOATMENU_TAG;
    fMenu.layer.cornerRadius = MenuLength / 2.0;
    fMenu.layer.masksToBounds = YES;
    fMenu.image = [Base64Images circleImage];
    return fMenu;
}

+ (NSArray *)createDefaultItems
{
    CGFloat itemL = (MenuLength / 3) * EnlargeRatio;
    CGFloat x = 0.0,y = 0.0;
    CGRect itemFrame = CGRectZero;
    UIImage *icon = nil;
    NSString *title = @"unknown";
    NSMutableArray *itemList = [NSMutableArray array];
    for (NSInteger i = 0; i < 4; i++) {
        // 刷新
        x = 0.0;
        y = 0.0;
        itemFrame = CGRectZero;
        icon = nil;
        title = @"unknown";
        
        switch (i) {
            case 0:
            {
                x = itemL;
                y = 0.0;
                icon = [Base64Images homeImage];
                title = @"Home";
            }
                break;
            case 1:
            {
                x = itemL * 2;
                y = itemL;
                icon = [Base64Images circleImage];
                title = @"Circle";
            }
                break;
            case 2:
            {
                x = itemL;
                y = itemL * 2;
                icon = [Base64Images cupImage];
                title = @"Cup";
            }
                break;
            case 3:
            {
                x = 0.0;
                y = itemL;
                icon = [Base64Images lightImage];
                title = @"Light";
            }
                break;
            default:
                break;
        }
        itemFrame = CGRectMake(x, y, itemL, itemL);
        FloatItem *item = [FloatItem new];
        item.itemFrame = itemFrame;
        item.index = i;
        item.title = title;
        item.icon = icon;
        item.handler = ^(NSInteger index) {
            NSLog(@"click at %ld",(long)index);
        };
        [itemList addObject:item];
    }
    return [itemList copy];
}
    
+ (UIWindow *)getCurrentKeyWindow
{
    return UIApplication.sharedApplication.keyWindow;
}

#pragma mark - Instance methods

- (void)showDefaultItemViews
{
    [self.itemsModel refreshItemViewsOnSuperView:self];
}

- (void)hideDefaultItemViews
{
    [self.itemsModel cleanItemViews];
}

#pragma mark - Private

- (CGRect)enlargeViewSize:(CGRect)frame
{
    CGFloat w = frame.size.width * EnlargeRatio;
    CGFloat h = frame.size.height * EnlargeRatio;
    CGFloat x = (MScreenWidth - w ) / 2;
    CGFloat y = (MScreenHeight - h ) / 2;
    return CGRectMake(x, y, w, h);
}

- (CGRect)shrinkViewSize:(CGRect)frame
{
    CGRect largeFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width / EnlargeRatio, frame.size.height / EnlargeRatio);
    return largeFrame;
}

- (void)shrinkView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = [self shrinkViewSize:self.frame];
        // corner radious
        self.layer.cornerRadius = MenuLength / 2.0;
        self.layer.masksToBounds = YES;
        // make menu back to screen bounds
        self.origin = [self createFormatMoveFrom:self.origin];
    } completion:^(BOOL finished) {
        self.image = [Base64Images circleImage];
        [self hideDefaultItemViews];
        self.isLargeSize = !self.isLargeSize;
    }];
}

- (void)enlargeView
{
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = [self enlargeViewSize:self.frame];
        // corner radious
        self.layer.cornerRadius = 5.0;
        self.layer.masksToBounds = YES;
    } completion:^(BOOL finished) {
        self.image = nil;
        [self showDefaultItemViews];
        self.isLargeSize = !self.isLargeSize;
    }];
}

#pragma mark - Notification

- (void)onShouldShrinkMenu:(NSNotification *)notify
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self shrinkView];
    });
}

#pragma mark - Getter

- (FloatModel *)itemsModel
{
    if (!_itemsModel) {
        _itemsModel = [FloatModel new];
    }
    return _itemsModel;
}

#pragma mark - touch delegate


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIWindow *keyW = [[self class] getCurrentKeyWindow];
    if (!keyW) {
        return;
    }
    self.beginPoint = [touch locationInView: keyW];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIWindow *keyW = [[self class] getCurrentKeyWindow];
    if (!keyW) {
        return;
    }
    
    if (self.isLargeSize) {
        return;
    }
    
    UITouch *touch = [touches anyObject];
    
    CGPoint endP = [touch locationInView: keyW];
    CGPoint preP = [touch previousLocationInView: keyW];
    CGFloat offX = endP.x - preP.x;
    CGFloat offY = endP.y - preP.y;
    
    // 移动View
    self.transform = CGAffineTransformTranslate(self.transform, offX, offY);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UIWindow *keyW = [[self class] getCurrentKeyWindow];
    if (!keyW) {
        return;
    }
    
    // self current position
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView: keyW];
    if (CGPointEqualToPoint(point, self.beginPoint)) {
        // click
        if (self.isLargeSize) {
            [self shrinkView];
        }
        else {
            [self enlargeView];
        }
    }
    else if (self.isLargeSize) {
        return;
    }
    else {
        self.origin = [self createFormatMoveFrom:point];
    }
}

- (CGPoint)createFormatMoveFrom:(CGPoint)point
{
    // move
    if (point.y < self.height && point.x > MScreenWidth - self.width) {
        // top right
        return CGPointMake(MScreenWidth - self.width, 0);
    }
    if (point.y > MScreenHeight - self.height && point.x > MScreenWidth - self.width){
        // bottom right
        return CGPointMake(MScreenWidth - self.width, MScreenHeight - self.height);
    }
    if (point.x < self.width * 0.5  && point.y < self.height) {
        // top left
        return CGPointMake(0,0);
    }
    if (point.y > MScreenHeight - self.height && point.x < self.width * 0.5) {
        // bottom left
        return CGPointMake(0,MScreenHeight - self.height);
    }
    
    if (point.x < MScreenWidth * 0.5) {
        // mid-x left
        if (point.y < self.height) {
            return CGPointMake(point.x - self.width * 0.5, 0);
        }
        else if (point.y > MScreenHeight - self.height) {
            return CGPointMake(point.x - self.width * 0.5, MScreenHeight - self.height);
        }
        else {
            return CGPointMake(0, point.y- self.height * 0.5);
        }
    }
    else {
        // mid-x right
        if (point.y < self.height) {
            return CGPointMake(point.x - self.width * 0.5, 0);
        }
        else if (point.y > MScreenHeight - self.height) {
            return CGPointMake(point.x - self.width * 0.5, MScreenHeight - self.height);
        }
        else {
            return CGPointMake(MScreenWidth - self.width, point.y- self.height * 0.5);
        }
    }
    return CGPointMake(0.0, 0.0);
}

@end
