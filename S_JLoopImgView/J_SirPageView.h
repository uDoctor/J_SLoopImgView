//
//  J_SirPageView.h
//  JAN
//
//  Created by 李杨 on 16/9/16.
//  Copyright © 2016年 蚊子工作室. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface J_SirPageView : UIView

@property (nonatomic, assign) NSInteger currentPage;


- (void) setPageNumber:(NSInteger) numbers;
//- (void) setPageCurrentNumber:(NSInteger) currentPage;

@end
