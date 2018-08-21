//
//  mainTableVc.m
//  portal
//
//  Created by Store on 2017/9/25.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "mainTableVc.h"

#import "testTableVC.h"
#import "TitleViewController.h"
#import "testCoVc.h"
#import "baseWkVc.h"


@interface mainTableVc ()

@end

@implementation mainTableVc

- (void)viewDidLoad {
    [super viewDidLoad];

    self.fd_prefersNavigationBarHidden = YES;
    
    testTableVC *homePagevc = [[testTableVC alloc]init];
    homePagevc.title = @"首页";
    UINavigationController *navhomePagevc = [[UINavigationController alloc] initWithRootViewController:homePagevc];
    
    
    testCoVc *manageMoneyvc = [[testCoVc alloc]init];
    manageMoneyvc.title = @"COtest";
    UINavigationController *navmanageMoneyvc = [[UINavigationController alloc] initWithRootViewController:manageMoneyvc];
    
    
    baseWkVc *minevc = [[baseWkVc alloc]init];
    minevc.title = @"网页";
    UINavigationController *navminevc = [[UINavigationController alloc] initWithRootViewController:minevc];
    
    TitleViewController *titleViewController = [[TitleViewController alloc]init];
    titleViewController.title = @"分页";
    UINavigationController *navminetitleViewControllerVc = [[UINavigationController alloc] initWithRootViewController:titleViewController];
    
    
    UIImage * normalImage1 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage1 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navhomePagevc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"首页" image:normalImage1 selectedImage:selectImage1];
    

    
    UIImage * normalImage2 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage2 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navmanageMoneyvc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"COtest" image:normalImage2 selectedImage:selectImage2];

    
    UIImage * normalImage3 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage3 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navminevc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"网页" image:normalImage3 selectedImage:selectImage3];
    
    UIImage * normalImage4 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIImage * selectImage4 = [[UIImage imageNamed:@"right"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    navminetitleViewControllerVc.tabBarItem = [[UITabBarItem alloc] initWithTitle:@"分页" image:normalImage4 selectedImage:selectImage4];
    
    self.viewControllers = [NSArray arrayWithObjects:navhomePagevc,navmanageMoneyvc,navminevc,navminetitleViewControllerVc, nil];

    
    self.tabBar.backgroundImage = [[UIColor whiteColor] imageWithColor];
    [self.tabBar setTintColor:ColorWithHex(0xE3BF7C, 1.0)];
    self.tabBar.translucent = NO;
}

@end
