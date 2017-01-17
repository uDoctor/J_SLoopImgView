//
//  J_SirPageView.m
//  JAN
//
//  Created by 李杨 on 16/9/16.
//  Copyright © 2016年 蚊子工作室. All rights reserved.
//

#import "J_SirPageView.h"

@implementation J_SirPageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void) setPageNumber:(NSInteger) numbers
{
    // 总宽度
    CGFloat pageViewWidth = (10 + 5) *numbers - 5;
    for (int i = 0; i < numbers; i ++) {
        UIImageView * imgView =[[UIImageView alloc] initWithFrame:CGRectMake((self.frame.size.width - pageViewWidth - 10)  + 15 * i, (self.frame.size.height - 4)/(float)2, 10 , 2)];
        imgView.backgroundColor = [UIColor redColor];
        imgView.clipsToBounds = YES;
        imgView.layer.cornerRadius = 1;
        imgView.tag = 100 + i ;
        [self addSubview:imgView];
    }
}
static NSInteger currentPageNumber = 0;
- (void)setCurrentPage:(NSInteger)currentPage
{

    currentPageNumber = currentPage;
    for (UIImageView * imgView in self.subviews) {
        if (imgView.tag == 100 + currentPage) {
            imgView.backgroundColor =[UIColor colorWithRed:251/255.0 green:120/255.0 blue:35/255.0 alpha:1.0];
        }
        else
            imgView.backgroundColor = [UIColor whiteColor];
    }

}
- (NSInteger)currentPage
{

    return currentPageNumber;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
