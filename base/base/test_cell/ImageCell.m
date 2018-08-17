//
//  ImageCell.m
//  TourismT
//
//  Created by Store on 16/12/17.
//  Copyright © 2016年 qxc122@126.com. All rights reserved.
//

#import "ImageCell.h"
#import "Header.h"
#import "Masonry.h"


@interface ImageCell ()
@property (nonatomic,weak) UIImageView *image;
@property (nonatomic,weak) UIButton *dele;
@end

@implementation ImageCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc]init];
        self.image = image;
        [self.contentView addSubview:image];
        image.image = [UIImage imageNamed:@"nodata"];
        
        UIButton *dele = [[UIButton alloc]init];
        [self.contentView addSubview:dele];
        dele.hidden = YES;
        self.dele = dele;
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.left.equalTo(self);
            make.top.equalTo(self);
            make.bottom.equalTo(self);
        }];
        
        [dele mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(5);
            make.top.equalTo(self).offset(-5);
            make.width.equalTo(@(30));
            make.height.equalTo(@(30));
        }];
        [dele setImage:[UIImage imageNamed:@"nodata"] forState:UIControlStateNormal];


    }
    return self;
}
@end
