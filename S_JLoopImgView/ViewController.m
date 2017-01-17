//
//  ViewController.m
//  S_JLoopImgView
//
//  Created by pangpangpig-Mac on 2017/1/17.
//  Copyright © 2017年 蚊子工作室. All rights reserved.
//

#import "ViewController.h"

#import "LoopImageView.h"
@interface ViewController ()<LoopTapDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    LoopImageView * loop =[[LoopImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
        loop.images = @[
                        @"https://image.yumao1688.com/uploads/resources/product-desc/36175/b2c152dd84d2af314e957b877d6b46920b96799b.jpeg",
                        @"https://image.yumao1688.com/uploads/resources/product-desc/36175/c8bff9fb45479d4ba03b68d9431a9d39f2fca130.jpeg",
                        @"https://image.yumao1688.com/uploads/resources/product-desc/36174/0663a4dc068f743d6fc5091f7d3be687f297fffb.jpeg"
                        ];
    loop.closeTimer = NO;       //关闭定时器
    loop.hiddenLable = NO;      //隐藏 Lable
    loop.hiddenPage = NO;       //影藏 page
    [loop reloadBannerData];    // 可刷新
    loop.delegate = self;       // 点击代理回调
    [self.view addSubview:loop];
}

- (void)bannerTapClick:(NSInteger)index
{
    NSLog(@"点击了 -- 【%ld】", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
