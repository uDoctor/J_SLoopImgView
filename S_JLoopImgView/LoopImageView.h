//
//  LoopImageView.h
//  JAN
//
//  Created by pangpangpig-Mac on 16/9/6.
//  Copyright © 2016年 蚊子工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoopTapDelegate <NSObject>
@optional
- (void)bannerTapClick:(NSInteger)index;

@end
@interface LoopImageView : UIView


//定时器  管理
@property (nonatomic, weak) NSTimer         * autoTimer;

/**
 * 是否 自动轮播
 */
@property (nonatomic, assign) BOOL            closeTimer;

/**
 * 用来承接数据的数组   里面可以是模型 也可以是 图片路径
 */
@property (nonatomic, strong) NSArray       * images;

/**
 * 设置代理
 */
@property (nonatomic, weak) id<LoopTapDelegate> delegate;
/**
 * 是否显示 Lable
 */
@property (nonatomic, assign) BOOL hiddenLable;

/**
 * 是否显示 page view
 */
@property (nonatomic, assign) BOOL hiddenPage;
- (void)timerPause;

- (void)timerStart;

/**
 * 刷新的方法
 */
- (void)reloadBannerData;
@end
