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
@interface testTableVC ()

@end

@implementation testTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.registerCells = @[@"testCellXib",@"BorrowingBill"];
}

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
