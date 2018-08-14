//
//  basicVc.m
//  Tourism
//
//  Created by Store on 16/11/8.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "basicVc.h"

@interface basicVc ()

@end


@implementation basicVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}


- (void)popSelf{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)OPenVc:(basicVc *)vc{
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.willToBeRemovedVcs.count) {
        NSMutableArray *muArry =[self.navigationController.viewControllers mutableCopy];
        for (UIViewController *vc in self.navigationController.viewControllers) {
            for (Class class in self.willToBeRemovedVcs) {
                if ([vc isKindOfClass:class] && ![vc isEqual:self.navigationController.topViewController]) {
                    [muArry removeObject:vc];
                    break;
                }
            }
        }
        self.navigationController.viewControllers = muArry;
        self.willToBeRemovedVcs = nil;
    }
}
@end
