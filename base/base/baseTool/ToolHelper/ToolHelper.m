//
//  NetworkStateTool.m
//  base
//
//  Created by 开发者最好的 on 2018/8/15.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "ToolHelper.h"
#import "Header.h"


@interface ToolHelper ()
@property (strong, nonatomic) Reachability *reachability;
@end


@implementation ToolHelper
singleM(ToolHelper);
- (instancetype)init
{
    self = [super init];
    if (self) {
#ifdef DEBUG
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
#endif
        self.reachability = [Reachability reachabilityForInternetConnection];
        [self.reachability startNotifier];
    }
    return self;
}
-(BOOL)isReachable{
    return self.reachability.isReachable;
}
    
#ifdef DEBUG
- (void)networkStateChange{
    if ([self.reachability currentReachabilityStatus] == ReachableViaWiFi) {
        NSLog(@"有wifi");
    }else if ([self.reachability currentReachabilityStatus] == ReachableViaWWAN) {
        NSLog(@"使用手机自带网络进行上网");
    }else {
        NSLog(@"没有网络");
    }
}
#endif
@end
