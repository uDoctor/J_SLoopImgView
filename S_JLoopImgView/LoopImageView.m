//
//  LoopImageView.m
//  JAN
//
//  Created by pangpangpig-Mac on 16/9/6.
//  Copyright © 2016年 蚊子工作室. All rights reserved.
//

#import "LoopImageView.h"
#import "J_SirPageView.h"
#import "BannerModel.h"
#import <UIImageView+WebCache.h>
@interface LoopImageView()<UIScrollViewDelegate>

//tssss
@property (nonatomic, strong) J_SirPageView  * pageController;
//自定义 page controller
//@property (nonatomic, strong) J_SirPageControl * myPageControl;
//
@property (nonatomic, strong) UIScrollView          * scrollImgsView;




//

// 记录每一张 图片显示 size
@property (nonatomic, assign) CGSize        imgViewSize;
// 上一次的 秒数
@property (nonatomic, assign) long long       lastSecond;

// left middle right 3 imageView
@property (nonatomic, strong) UIImageView * leftImgView;
@property (nonatomic, strong) UIImageView * middleImgView;
@property (nonatomic, strong) UIImageView * rightImgView;

//
@property (nonatomic, assign) NSInteger     rightIndex;
@property (nonatomic, assign) NSInteger     middleIndex;
@property (nonatomic, assign) NSInteger     leftIndex;

// 详情view
@property (nonatomic, strong) UIView     * bottomView;
// 详情说明
@property (nonatomic, strong) UILabel    * detailLable;

//
@property (nonatomic, assign) long        second_0;
@end
@implementation LoopImageView


- (instancetype)initWithFrame:(CGRect)frame andShowImages:(NSArray *)imagePathArray
{
    return nil;
}

- (instancetype)initWithFrame:(CGRect)frame andShowModels:(NSArray *)modelArray
{
    return nil;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollImgsView     = [[UIScrollView alloc] init];
        self.pageController     = [[J_SirPageView alloc] init];
        self.imgViewSize        = frame.size;
        self.hiddenLable        = NO;
        self.hiddenPage         = NO;
        self.closeTimer         = YES;
        self.second_0           = 0;
        self.detailLable        = [[UILabel alloc] init];
        self.bottomView         = [[UIView alloc] init];
    }
    return self;
}



- (void)setImages:(NSArray *)images
{
    _images = images;
    if (images.count==1) {
        self.scrollImgsView.scrollEnabled = NO;
    }else
        self.scrollImgsView.scrollEnabled = YES;
    
    if (images.count >2) {
        self.leftIndex   =self.images.count - 1;
        self.middleIndex =0;
        self.rightIndex  =1;
    }else if(images.count == 2)
    {
        self.leftIndex   =1;
        self.middleIndex =0;
        self.rightIndex  =1;
    }
    else if(images.count == 1)
    {
        self.leftIndex   =0;
        self.middleIndex =0;
        self.rightIndex  =0;
    }
    [self loopImageViews:images];

//    [self timerStart];
    
}
// 三张图片
- (void)loopImageViews:(NSArray*)imagePathArray
{
    float img_w = self.imgViewSize.width;
    float img_h = self.imgViewSize.height;
    
    self.scrollImgsView.frame = CGRectMake(0, 0, img_w, img_h);
    self.scrollImgsView.delegate = self;
    self.scrollImgsView.contentSize = CGSizeMake(img_w*3, 0);
    self.scrollImgsView.pagingEnabled = YES;
    self.scrollImgsView.contentOffset   = CGPointMake(img_w, 0);
    [self addSubview:self.scrollImgsView];
    
    self.leftImgView =[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, img_w, img_h)];
    [self.scrollImgsView addSubview:self.leftImgView];
    
    self.middleImgView =[[UIImageView alloc] initWithFrame:CGRectMake(img_w, 0, img_w, img_h)];
    [self.scrollImgsView addSubview:self.middleImgView];
    self.middleImgView.userInteractionEnabled = YES;
    
    // 在中间页面添加手势
    UITapGestureRecognizer * tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.middleImgView addGestureRecognizer:tap];
    
    
    self.rightImgView =[[UIImageView alloc] initWithFrame:CGRectMake(img_w * 2 ,0, img_w, img_h)];
    [self.scrollImgsView addSubview:self.rightImgView];
    
    //底部view
    self.bottomView.frame = CGRectMake(0, img_h - 30, img_w, 30);
    self.bottomView.backgroundColor = [UIColor colorWithRed:0.1 green:0.09 blue:0.09 alpha:0.3];
    if (!self.hiddenLable) {
        [self addSubview:self.bottomView];
    }
    
    // 图片说明 放在 底部view上
    self.detailLable.frame = CGRectMake(20, 0, img_w - 20, 30);
    self.detailLable.textColor =[UIColor whiteColor];
    self.detailLable.font =[UIFont systemFontOfSize:15.0];
    [self.bottomView addSubview:self.detailLable];
    
    
    self.pageController.frame =CGRectMake(img_w-150, img_h-20, 150, 20);
    [self.pageController setPageNumber:imagePathArray.count];
    [self.pageController setCurrentPage:0];
    [self addSubview:self.pageController];
    
}



#pragma mark - reload data method
- (void) reloadBannerData
{
//    self.leftImgView.image     =[UIImage imageNamed:self.images[self.leftIndex]];
//    self.middleImgView.image   =[UIImage imageNamed:self.images[self.middleIndex]];
//    self.rightImgView.image    =[UIImage imageNamed:self.images[self.rightIndex]];
    if (self.images.count <=0) {
        return;
    }
    if ([self.images[0] isKindOfClass:[NSString class]]) {
            if ([self.images[_leftIndex] hasPrefix:@"http"])
                [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_leftIndex]] placeholderImage:nil];
            else
                self.leftImgView.image =[UIImage imageNamed:@"default_img"];
        
            if ([self.images[_middleIndex] hasPrefix:@"http"])
            [self.middleImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_middleIndex]] placeholderImage:nil];
            else
                self.middleImgView.image =[UIImage imageNamed:@"default_img"];
        
            if ([self.images[_rightIndex] hasPrefix:@"http"])
            [self.rightImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_rightIndex]] placeholderImage:nil];
            else
                self.rightImgView.image =[UIImage imageNamed:@"default_img"];
    }
    else
    {
        BannerModel * lbanner = self.images[_leftIndex];
        BannerModel * mbanner = self.images[_middleIndex];
        BannerModel * rbanner = self.images[_rightIndex];
        
        if ([lbanner.imgUrl hasPrefix:@"http"])
            [self.leftImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_leftIndex]] placeholderImage:nil];
        else
            self.leftImgView.image =[UIImage imageNamed:@"default_img"];
        
        if ([mbanner.imgUrl hasPrefix:@"http"]){
            [self.middleImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_middleIndex]] placeholderImage:nil];
            self.detailLable.text = mbanner.name;
        }
        else
            self.middleImgView.image =[UIImage imageNamed:@"default_img"];
        
        if ([rbanner.imgUrl hasPrefix:@"http"])
            [self.rightImgView sd_setImageWithURL:[NSURL URLWithString:self.images[_rightIndex]] placeholderImage:nil];
        else
            self.rightImgView.image =[UIImage imageNamed:@"default_img"];
    }
    
    
    [self.pageController setCurrentPage:_middleIndex];

    [self timerStart];
    
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    float img_W = self.middleImgView.frame.size.width;
    //像左滑动
    if (self.scrollImgsView.contentOffset.x >= img_W * 2 -1) {
        self.scrollImgsView.contentOffset = CGPointMake(img_W, 0);
        self.rightIndex  ++;
        self.middleIndex ++;
        self.leftIndex   ++;
        
        if (self.leftIndex > self.images.count-1)
            self.leftIndex = 0;
        
        if (self.middleIndex > self.images.count-1)
            self.middleIndex = 0;
        
        if (self.rightIndex > self.images.count-1)
            self.rightIndex = 0;
        
    }else if (self.scrollImgsView.contentOffset.x <= 1)
    {
        self.scrollImgsView.contentOffset = CGPointMake(img_W, 0);
        self.leftIndex   --;
        self.middleIndex --;
        self.rightIndex  --;
        
        if (self.leftIndex<0)
            self.leftIndex = self.images.count-1;
        
        if (self.middleIndex<0)
            self.middleIndex = self.images.count-1;
        
        if (self.rightIndex<0)
            self.rightIndex = self.images.count-1;
    }
    
    
    [self reloadBannerData];
}

- (void)autoLoopImageView
{
//    [self.scrollImgsView setContentOffset:CGPointMake(img_W*2, 0) animated:YES];
    [UIView setAnimationsEnabled:YES];

        [UIView animateWithDuration:0.7 animations:^{
//            [UIView setAnimationsEnabled:NO];
            float img_W = self.imgViewSize.width;
            self.scrollImgsView.contentOffset = CGPointMake(img_W*2, 0);
            self.rightIndex  ++;
            self.middleIndex ++;
            self.leftIndex   ++;
            
            if (self.leftIndex   > self.images.count-1) self.leftIndex   = 0;
            if (self.middleIndex > self.images.count-1) self.middleIndex = 0;
            if (self.rightIndex  > self.images.count-1) self.rightIndex  = 0;
        } completion:^(BOOL finished) {
//            if (finished) {
                self.scrollImgsView.contentOffset   = CGPointMake(self.imgViewSize.width, 0);
                [self reloadBannerData];
//            }
        }];
//    });
}

#pragma mark - tao 点击事件
- (void)tapClick:(UITapGestureRecognizer*)tap
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(bannerTapClick:)]) {
        [self.delegate bannerTapClick:_middleIndex];
    }

}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.closeTimer) {
        return;
    }
    [self timerStart];
   
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.closeTimer) {
        return;
    }
    [self timerPause];
}

- (void)timerPause
{
    [self.autoTimer invalidate];
    self.autoTimer = nil;
}

- (void)timerStart
{
    self.closeTimer = NO;
    if (!self.autoTimer) {
//        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            //自动轮播定时器
            self.autoTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(autoLoopImageView) userInfo:nil repeats:YES];
            //  NSDefaultRunLoopMode -- 默认模式
            //  UITrackingRunLoopMode -- 跟踪模式   优先级 高于默认模式
            //  UITrackingRunLoopMode -- 站位模式   包含前面两种
            [[NSRunLoop mainRunLoop] addTimer:self.autoTimer forMode:NSRunLoopCommonModes];
//            [self.autoTimer setFireDate:[NSDate distantPast]];
//            [self.autoTimer fire];
//            [[NSRunLoop currentRunLoop] run];
//        });
    }
}

@end
