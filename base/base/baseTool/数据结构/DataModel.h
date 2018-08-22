//
//  DataModel.h
//  base
//
//  Created by 开发者最好的 on 2018/8/22.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModel : NSObject
@property (nonatomic,strong) NSString *arrDate;
@property (nonatomic,strong) NSURL *bankIcon;
@property (nonatomic,strong) NSString *bankName;
@property (nonatomic,strong) NSString *calDate;
@property (nonatomic,strong) NSNumber *cardNo;
@property (nonatomic,strong) NSString *fee;
@property (nonatomic,strong) NSString *price;
@end
