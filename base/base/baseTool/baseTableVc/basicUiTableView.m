//
//  basicUiTableView.m
//  TourismT
//
//  Created by Store on 2017/7/24.
//  Copyright © 2017年 qxc122@126.com. All rights reserved.
//

#import "basicUiTableView.h"
#import "UIScrollView+EmptyDataSet.h"
#import "Masonry.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "Header.h"
#import "NSString+Add.h"
@interface basicUiTableView ()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

//NSInteger Mystatus = AFNetworkReachabilityStatusReachableViaWWAN;
@implementation basicUiTableView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.style = UITableViewStyleGrouped;
        self.Pagesize = 10;
        self.Pagenumber = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTableView];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
//    [self.header beginRefreshing];
}
- (void)setTableView{

    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:self.style];
    [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    tableView.backgroundColor =  [UIColor clearColor];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view);
        make.left.equalTo(self.view);
        make.top.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.mj_header = self.header;
    tableView.emptyDataSetSource = self;
    tableView.emptyDataSetDelegate = self;
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
#pragma -mark<mj_header  头部>
- (MJRefreshHeader *)header{
    if (!_header) {
        MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _header = header;
    }
    return _header;
}
- (void)loadNewData{
    
}

#pragma -mark<mj_footer  头部>
- (void)set_MJRefreshFooter{
    MJRefreshFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
    self.footer = footer;
}
#pragma -mark<加载更多数据>
- (void)loadMoreData{
    
}
- (void)setRegisterCells:(NSArray *)registerCells{
    _registerCells = registerCells;
    for (Class tmp in registerCells) {
        [self.tableView registerClass:tmp forCellReuseIdentifier:NSStringFromClass(tmp)];
    }
}


#pragma --mark< UITableViewDelegate 高>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.empty_type == succes_empty_num) {
        id cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
        if ([cell isKindOfClass:[UITableViewCell class]]) {
            kWeakSelf(self);
            return [tableView fd_heightForCellWithIdentifier:NSStringFromClass([cell class]) configuration:^(id cell) {
                NSString *method =[NSString stringWithFormat:@"configure%@:atIndexPath:",NSStringFromClass([cell class])];

                SEL selector = NSSelectorFromString(method);
                if ([weakself respondsToSelector:selector]) {
                    [weakself performSelector:selector withObject:cell withObject:indexPath];
                }
            }];
        }
    }
    return 0.01;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//}
#pragma --mark< 创建cell >
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCellT"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCellT"];
    }
    return  cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
     return nil;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
     return nil;
}
#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return 1;
    }
    return 0;
}

    
- (void)loadNewDataEndHeadsuccessSet:(UITableView *)TableView code:(NSInteger)code footerIsShow:(BOOL)footerIsShow hasMore:(NSString *)hasMore{
    self.empty_type = code;
    if (self.header.isRefreshing) {
        [self.header endRefreshing];
    }
    [TableView reloadData];
    if (footerIsShow) {
        if(!self.footer){
            [self set_MJRefreshFooter];
        }
        if ([hasMore isEqualToString:@"1"]) {
            self.footer.hidden = NO;
            if (self.footer.state == MJRefreshStateNoMoreData) {
                [self.footer resetNoMoreData];
            }
        }else{
            self.footer.hidden = YES;
        }
        self.Pagenumber++;
    }
}
- (void)loadNewDataEndHeadfailureSet:(UITableView *)TableView errorCode:(NSInteger)errorCode{
    self.empty_type = errorCode;
    [self.header endRefreshing];
    if(self.footer){
        self.footer.hidden = YES;
    }
    [TableView reloadData];
}
    
- (void)loadMoreDataEndFootsuccessSet:(UITableView *)TableView  hasMore:(NSString *)hasMore{
    [self.footer endRefreshing];
    if ([hasMore isEqualToString:@"1"]) {
        self.footer.hidden = NO;
        if (self.footer.state == MJRefreshStateNoMoreData) {
            [self.footer resetNoMoreData];
        }
    }else{
        self.footer.hidden = YES;
    }
    self.Pagenumber++;
    [TableView reloadData];
}
- (void)loadMoreDataEndFootfailureSet:(UITableView *)TableView errorCode:(NSInteger)errorCode msg:(NSString *)msg{
    [self.footer endRefreshing];
}
  
#pragma --<空白页处理>
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    if (self.empty_type == succes_empty_num) {
        return [UIImage imageNamed:@"place"];
    } else if (self.empty_type == fail_empty_num) {
        return [UIImage imageNamed:@"place"];
    } else if (self.empty_type == NoNetworkConnection_empty_num) {
        return [UIImage imageNamed:@"place"];
    }else{
        return [UIImage imageNamed:@"开小差"];
    }
    return nil;
}
    
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"网络连接异常，请检查网络", @"网络连接异常，请检查网络")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"网络已连接，请重试", @"网络已连接，请重试")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else if (self.empty_type == succes_empty_num){
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",self.NodataTitle&&self.NodataTitle.length?self.NodataTitle:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"\n%@",NSLocalizedString(@"服务器开小差了,请重试", @"服务器开小差了,请重试")] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }
    return nil;
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView{
    if (self.empty_type == NoNetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }else if (self.empty_type == succes_empty_num){
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        NSAttributedString *title = [[NSString stringWithFormat:@"%@\n\n",self.NodataDescribe&&self.NodataDescribe.length?self.NodataDescribe:@" "] CreatMutableAttributedStringWithFont:PingFangSC_Regular(14) Color:ColorWithHex(0x000000, 0.4) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
        [all appendAttributedString:title];
        return all;
    }else{
        NSMutableAttributedString *all = [[NSMutableAttributedString alloc]init];
        [all appendAttributedString:[@"\n\n\n " CreatMutableAttributedStringWithFont:PingFangSC_Regular(12) Color:ColorWithHex(0x2D2D2D, 0.3) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0]];
        return all;
    }
    return nil;
}
    //按钮文本或者背景样式
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    if (self.empty_type == NoNetworkConnection_empty_num) {
        return [NSLocalizedString(@"检查设置", @"检查设置") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }else if (self.empty_type != succes_empty_num){
        return [NSLocalizedString(@"重新加载", @"重新加载") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }if (self.empty_type == NoNetworkConnection_TO_NetworkConnection_empty_num) {
        return [NSLocalizedString(@"重新加载", @"重新加载") CreatMutableAttributedStringWithFont:PingFangSC_Regular(16) Color:ColorWithHex(0x4EA2FF, 1.0) LineSpacing:0 Alignment:NSTextAlignmentCenter BreakMode:NSLineBreakByTruncatingTail firstLineHeadIndent:0 headIndent:0 paragraphSpacing:0 WordSpace:0];
    }
    return nil;
}
//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
//
//}
//- (CGPoint)offsetForEmptyDataSet:(UIScrollView *)scrollView{
//      return CGPointMake(SCREENWIDTH*0.5, 300);
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView{
//    return 30;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView{
//    return 15.0;
//}
    
    
    
//空白页的背景色
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor clearColor];
}
    
//是否显示空白页，默认YES
- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return !self.header.isRefreshing;
}
    
//空白页点击事件
//- (void)emptyDataSetDidTapView:(UIScrollView *)scrollView {
//    [self DidTap];
//}
    
- (void)emptyDataSetDidTapButton:(UIScrollView *)scrollView{

}
@end

