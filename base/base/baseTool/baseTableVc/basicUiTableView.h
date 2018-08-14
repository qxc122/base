//
//  basicUiTableView.h
//  TourismT
//
//  Created by Store on 2017/7/24.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"
#import "MJRefresh.h"


typedef NS_ENUM(NSInteger, empty_num)
{
    In_loading_empty_num = -48, //加载中
    
    fail_empty_num , //加载失败
    succes_empty_num ,   //加载成功
    NoNetworkConnection_empty_num ,   //无网络连接
    NoNetworkConnection_TO_NetworkConnection_empty_num,   //从无网络连接 到有 网络连接
    noItems_empty_num,   //没有数组
};


@interface basicUiTableView : basicVc
@property (nonatomic,strong) MJRefreshHeader *header;//头部
@property (nonatomic,strong) MJRefreshFooter *footer;//底部
@property (nonatomic,strong) NSString  *NodataTitle; // 没有数据时候的标题
@property (nonatomic,strong) NSString  *NodataDescribe; // 没有数据时候的描叙
@property (nonatomic,assign) empty_num  empty_type; //
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,assign) UITableViewStyle  style; // 默认是分组
@property (nonatomic,assign) NSInteger Pagenumber;
@property (nonatomic,assign) NSInteger Pagesize;

@property (nonatomic,strong) NSArray  *registerCells; //需要注册的cell


@property (nonatomic,assign) BOOL isNeedRefreshWhenLoginOrOut;
- (void)loadNewDataEndHeadsuccessSet:(UITableView *)TableView code:(NSInteger)code footerIsShow:(BOOL)footerIsShow  hasMore:(NSString *)hasMore;
- (void)loadNewDataEndHeadfailureSet:(UITableView *)TableView errorCode:(NSInteger)errorCode;

- (void)loadMoreDataEndFootsuccessSet:(UITableView *)TableView  hasMore:(NSString *)hasMore;
- (void)loadMoreDataEndFootfailureSet:(UITableView *)TableView errorCode:(NSInteger)errorCode msg:(NSString *)msg;
@end
