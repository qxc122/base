//
//  AppDelegate.m
//  base
//
//  Created by 开发者最好的 on 2018/8/14.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "AppDelegate.h"
#import "NetworkStateTool.h"
#import "Header.h"
#import "mainTableVc.h"
#ifdef DEBUG
    #ifdef FPS_TEST
        #import "WSLFPS.h"
        #import "WSLSuspendingView.h"
    #endif
#endif


@interface AppDelegate ()
@property (strong, nonatomic) NetworkStateTool *netStaue;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.netStaue = [NetworkStateTool sharedInstance];
#ifdef DEBUG
     #ifdef FPS_TEST
        WSLSuspendingView * suspendingView = [WSLSuspendingView sharedSuspendingView];
    
        WSLFPS * fps = [WSLFPS sharedFPSIndicator];
        [fps startMonitoring];
        fps.FPSBlock = ^(float fps) {
            suspendingView.fpsLabel.text = [NSString stringWithFormat:@"FPS = %.2f",fps];
        };
    #endif
#endif
    
    mainTableVc *MainVc = [[mainTableVc alloc] init];
    UINavigationController *nnvc = [[UINavigationController alloc]initWithRootViewController:MainVc];
    self.window.rootViewController = nnvc;
    [self.window makeKeyAndVisible];

 
    [[UINavigationBar appearance] setBackgroundImage:[[UIColor redColor] imageWithColor] forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIColor redColor] imageWithColor]];
    
    UINavigationBar *navBar = [UINavigationBar appearance];
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    md[NSFontAttributeName] = PingFangSC_Medium(17);
    md[NSForegroundColorAttributeName] = [UIColor yellowColor];
    [navBar setTitleTextAttributes:md];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
