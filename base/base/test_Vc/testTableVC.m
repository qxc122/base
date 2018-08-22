//
//  testTableVC.m
//  base
//
//  Created by 开发者最好的 on 2018/8/17.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "testTableVC.h"
#import "testCellXib.h"
#import "BorrowingBill.h"
#import "ToolHelper.h"

#import "TitleViewController.h"
#import "testCoVc.h"
#import "baseWkVc.h"
#import "testPoPvc.h"
#import "UIViewController+YCPopover.h"
#import "YBPopupMenu.h"
@interface testTableVC ()
@property (weak, nonatomic) UIButton *btn;
@end

@implementation testTableVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.registerCells = @[@"testCellXib",@"BorrowingBill"];
    
    UIButton *btn = [UIButton new];
    [btn setTitle:@"好的" forState:UIControlStateNormal];
    self.btn = btn;
    [btn addTarget:self action:@selector(load) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc]initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightBtn;
    
//    self.fd_prefersNavigationBarHidden = YES;
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"好的" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.rightBarButtonItem.tintColor = [UIColor yellowColor];
}

- (void)load{
    [[ToolHelper shareToolHelper] tpurseappappIdApplysuccess:^(id dataDict, NSString *msg, NSInteger code) {
        NSLog(@"SUCESS");
    } failure:^(NSInteger errorCode, NSString *msg) {
        NSLog(@"FAIL");
    }];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            TitleViewController *vc = [TitleViewController new];
            JXCategoryTitleView *titleCategoryView = (JXCategoryTitleView *)vc.categoryView;
            titleCategoryView.titleColorGradientEnabled = YES;
            titleCategoryView.indicatorLineViewShowEnabled = NO;
            titleCategoryView.indicatorLineViewShowEnabled = YES;
            titleCategoryView.indicatorLineWidth = 20;
            titleCategoryView.lineStyle = JXCategoryLineStyle_IQIYI;
            [self.navigationController pushViewController:vc animated:YES];
        } else if(indexPath.row == 1){
            baseWkVc *vc = [baseWkVc new];
            UINavigationController *navc = [[UINavigationController alloc]initWithRootViewController:vc];
            [self presentViewController:navc animated:YES completion:nil];
        } else if(indexPath.row == 2){
            testCoVc *vc = [testCoVc new];
            [self.navigationController pushViewController:vc animated:YES];
        } else if(indexPath.row == 3){
            baseWkVc *vc = [baseWkVc new];
            [self.navigationController pushViewController:vc animated:YES];
        } else if(indexPath.row == 4){
            testPoPvc *vc = [testPoPvc new];
            [self yc_centerPresentController:vc presentedSize:CGSizeMake(200, 300) completeHandle:^(BOOL presented) {
                if (presented) {
                    NSLog(@"弹出了");
                }else{
                    NSLog(@"消失了");
                }
            }];
        } else if(indexPath.row == 5){
            testPoPvc *vc = [testPoPvc new];
            [self yc_bottomPresentController:vc presentedHeight:220 completeHandle:^(BOOL presented) {
                if (presented) {
                    NSLog(@"弹出了");
                }else{
                    NSLog(@"消失了");
                }
            }];
        }
    } else {
        if(indexPath.row == 0){
#define TITLES @[@"修改", @"删除", @"扫一扫",@"付款"]
#define ICONS  @[@"right",@"right",@"right",@"right"]
            [YBPopupMenu showRelyOnView:self.btn titles:TITLES icons:ICONS menuWidth:120 delegate:nil];
        }
    }
}
- (void)hideBottomBarWhenPush{}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        testCellXib *cell = [tableView dequeueReusableCellWithIdentifier:@"testCellXib" forIndexPath:indexPath];
        return  cell;
    }else{
        BorrowingBill *cell = [BorrowingBill returnCellWith:tableView];
        [self configureBorrowingBill:cell atIndexPath:indexPath];
        return  cell;
    }
}
- (void)configuretestCellXib:(testCellXib *)cell atIndexPath:(NSIndexPath *)indexPath {
    
}
- (void)configureBorrowingBill:(BorrowingBill *)cell atIndexPath:(NSIndexPath *)indexPath {

}

#pragma -mark<UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.empty_type == succes_empty_num) {
        return 2;
    }
    return 0;
}
@end
