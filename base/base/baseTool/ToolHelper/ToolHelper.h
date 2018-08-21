//
//  NetworkStateTool.h
//  base
//
//  Created by 开发者最好的 on 2018/8/15.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
#import "single.h"
#import "MACRO_URL.h"
typedef void (^RequestSuccess)(id dataDict, NSString *msg, NSInteger code);
typedef void (^RequestFailure)(NSInteger errorCode, NSString *msg);
typedef void (^RequestProgress)(NSProgress *uploadProgress);


@interface ToolHelper : NSObject
singleH(ToolHelper);

-(BOOL)isReachable;


- (void)getWithPath:(NSString *)path
         parameters:(NSMutableDictionary *)parameters
            success:(RequestSuccess)successBlock
            failure:(RequestFailure)failureBlock;

- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock;
@end
