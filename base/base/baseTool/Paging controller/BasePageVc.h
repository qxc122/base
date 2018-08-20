//
//  BaseViewController.h
//  JXCategoryView
//
//  Created by jiaxin on 2018/8/9.
//  Copyright © 2018年 jiaxin. All rights reserved.
//

#import "basicVc.h"
#import "JXCategoryBaseView.h"
#import "JXCategoryTitleView.h"
#define WindowsSize [UIScreen mainScreen].bounds.size

@interface BasePageVc : basicVc

@property (nonatomic, strong) JXCategoryBaseView *categoryView;

@property (nonatomic, strong) UIScrollView *scrollView;


- (Class)preferredCategoryViewClass;

- (NSUInteger)preferredListViewCount;

- (CGFloat)preferredCategoryViewHeight;

@end
