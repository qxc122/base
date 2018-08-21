//
//  MACRO_URL.h
//  base
//
//  Created by 开发者最好的 on 2018/8/21.
//  Copyright © 2018年 开发者最好的. All rights reserved.
//

#ifndef MACRO_URL_h
#define MACRO_URL_h

#ifdef DEBUG
#define  URLBASIC  @"http://172.18.126.105:7080/tour-app"
#else
#define  URLBASIC  @"https://tour.tempus.cn/tour-app"
#endif

#ifdef DEBUG
#define URLAddress  @"URLAddress"
#define productURLAddress  @"https://tour.tempus.cn/tour-app"
#define tesetURLAddress  @"http://172.18.126.105:7080/tour-app"
#endif


#endif /* MACRO_URL_h */
