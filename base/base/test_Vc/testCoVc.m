//
//  testCoVc.m
//  base
//
//  Created by 开发者最好的 on 2018/8/17.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "testCoVc.h"
#import "testCoCellXib.h"
#import "ImageCell.h"
@interface testCoVc ()

@end

@implementation testCoVc

- (void)viewDidLoad {
    [super viewDidLoad];
    self.registerCoCells  =@[@"testCoCellXib",@"ImageCell"];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
#pragma mark----UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        testCoCellXib *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.registerCoCells[indexPath.section] forIndexPath:indexPath];
        return cell;
    } else {
        ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:self.registerCoCells[indexPath.section] forIndexPath:indexPath];
        return cell;
    }
}

#pragma mark----UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(150,150);
    } else {
        return CGSizeMake(50,50);
    }

}
@end
