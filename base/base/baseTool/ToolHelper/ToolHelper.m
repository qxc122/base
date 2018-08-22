//
//  NetworkStateTool.m
//  base
//
//  Created by 开发者最好的 on 2018/8/15.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "ToolHelper.h"
#import "Header.h"
#import "NSUserDefaults+storage.h"
#import "AFNetworking.h"
#import "NSDictionary+Add.h"

#define REAUESRTIMEOUT      60    //网络请求超时时间

#define PROMPT_FAIL          @"加载失败,请重试～"
#define PROMPT_NOTCONNECT   @"网络连接异常,请检查手机网络~"
#define PROMPT_NOTJSON      @"服务器返回数据有误"

//数据请求码
typedef NS_ENUM(NSInteger, RespondCode)
{
    kRespondCodeNotJson             = -200,
    KRespondCodeNone                = -100,
    KRespondCodeFail                = -1, /** 失败 */
    kRespondCodeSuccess            = 0,/** 成功 */
    kRespondCodeExoipDateAccessToken = 100001,   /** Token无效 */
    kRespondCodePassworderror = 1026,   /** 错误码001026表示密码错误 */
    KRespondCodeNotConnect         = -12315,    //网络无连接
};

@interface ToolHelper ()
@property (strong, nonatomic) Reachability *reachability;
#ifdef DEBUG
@property (strong, nonatomic) NSString *baseURL;
#endif

//公共请求参数
@property (strong, nonatomic) NSString *accessToken;
//。。。。。可以按需求添加
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
#ifdef DEBUG
        NSString *url = [NSUserDefaults getObjectWithKey:URLAddress];
        if (!url) {
            [NSUserDefaults setObject:tesetURLAddress withKey:URLAddress];
            url = tesetURLAddress;
        }
        self.baseURL = url;
#else
        self.baseURL = URLBASIC;
#endif
    }
    return self;
}

- (void)getWithPath:(NSString *)path
         parameters:(NSMutableDictionary *)parameters
            success:(RequestSuccess)successBlock
            failure:(RequestFailure)failureBlock
{
    if (![self.reachability isReachable]) {
        failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
    } else {
        NSMutableDictionary *muDic = parameters;
        if (!muDic) {
            muDic = [NSMutableDictionary new];
        }
        
        //TODO
        //        if (!self.accessToken) {
        //
        //        } else {
        //
        //        }
        [muDic setObject:@"accessToken" forKey:self.accessToken];  //添加公共参数 按需添加
        //......
#ifdef DEBUG
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURL, path];
#else
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", URLBASIC, path];
#endif
        
#ifdef DEBUG
        NSLog(@"strTmp=%@  path=%@",[muDic DicToJsonstr],urlStr);
#endif
        
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
        [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        manager.requestSerializer = [AFJSONRequestSerializer serializer]; // 上传JSON格式
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"application/json", nil];
        
        kWeakSelf(self);
        [manager GET:urlStr parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                [weakself parseResponseData:result success:successBlock failure:failureBlock];
            }else{
                failureBlock(KRespondCodeNone, @"服务器返回数据为空");
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
            NSLog(@"请求参数=%@  path=%@",[error description],urlStr);
#endif
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }];
    }
}

- (void)postJsonWithPath:(NSString *)path
              parameters:(NSMutableDictionary *)parameters
                 success:(RequestSuccess)successBlock
                 failure:(RequestFailure)failureBlock
{
    if (![self.reachability isReachable]) {
        failureBlock(KRespondCodeNotConnect, PROMPT_NOTCONNECT);
    } else {
        NSMutableDictionary *muDic = parameters;
        if (!muDic) {
            muDic = [NSMutableDictionary new];
        }
        
        //TODO
//        if (!self.accessToken) {
//
//        } else {
//
//        }
//        [muDic setObject:@"accessToken" forKey:self.accessToken];  //添加公共参数 按需添加
        //......
#ifdef DEBUG
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", self.baseURL, path];
#else
        NSString *urlStr = [NSString stringWithFormat:@"%@%@", URLBASIC, path];
#endif

        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        manager.requestSerializer = [AFJSONRequestSerializer serializer];
        //    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"application/json",@"text/html", nil];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/x-zip-compressed"];
        manager.responseSerializer = [AFHTTPResponseSerializer serializer]; // AFN不会解析,数据是data，需要自己解析
        manager.requestSerializer.timeoutInterval = REAUESRTIMEOUT;
        
        
        kWeakSelf(self);
        [manager POST:urlStr parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                id result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:NULL];
                [weakself parseResponseData:result success:successBlock failure:failureBlock];
            }else{
                failureBlock(KRespondCodeNone, @"服务器返回数据为空");
            }
#ifdef DEBUG
            NSLog(@"-------Start--------");
            NSLog(@"请求成功：参数=%@  path=%@",[muDic DicToJsonstr],urlStr);
            NSLog(@"-------End--------");
#endif
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
#ifdef DEBUG
            NSLog(@"-------Start--------");
            NSLog(@"请求失败：参数=%@ \n 路径=%@ \n 错误信息=%@\n",[muDic DicToJsonstr],urlStr,[error description]);
            NSLog(@"-------End--------");
#endif
            NSDictionary *tmp = error.userInfo;
            NSString *tmpStr = tmp[@"NSLocalizedDescription"];
            failureBlock(KRespondCodeFail, tmpStr);
        }];
    }
}

//验证返回数据是否正确
- (void)parseResponseData:(id)responseData
                  success:(RequestSuccess)successBlock
                  failure:(RequestFailure)failureBlock{
    NSDictionary *jsonRootObject = (NSDictionary *)responseData;
    if (jsonRootObject == nil) {
        failureBlock(kRespondCodeNotJson, PROMPT_NOTJSON);
    }else {
        NSInteger code = [[jsonRootObject valueForKeyPath:@"head.code"] integerValue];
        NSString *msg = [jsonRootObject valueForKeyPath:@"head.msg"];
        id data = [jsonRootObject objectForKey:@"data"];
        if (code == kRespondCodeSuccess) {
            successBlock(data, msg, code);
        }else if (code == KRespondCodeFail) {
            failureBlock(code, msg);
        }else {
            failureBlock(code, msg);
        }
    }
}

-(BOOL)isReachable{
    return self.reachability.isReachable;
}

- (void)tpurseappappIdApplysuccess:(RequestSuccess)successBlock
                           failure:(RequestFailure)failureBlock{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    [params setObject:@"sdfsdfsdfsdf123123123123" forKey:@"deviceId"];
    [self postJsonWithPath:@"/tpurse/app/appIdApply" parameters:params success:successBlock failure:failureBlock];
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
