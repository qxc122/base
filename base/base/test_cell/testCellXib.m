//
//  testCell.m
//  base
//
//  Created by 开发者最好的 on 2018/8/17.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import "testCellXib.h"

@implementation testCellXib

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (CGSize)sizeThatFits:(CGSize)size {
    CGFloat totalHeight = 200;
    totalHeight += 40; // margins
    return CGSizeMake(300, totalHeight);
}
@end
