//
//  NetworkStateTool.h
//  base
//
//  Created by 开发者最好的 on 2018/8/15.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"

@interface NetworkStateTool : NSObject
+ (NetworkStateTool *)sharedInstance;
-(BOOL)isReachable;
@end
