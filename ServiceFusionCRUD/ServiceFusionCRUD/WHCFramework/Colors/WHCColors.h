//
//  WHCColors.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/22/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:a]
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#define ClearColor              [UIColor clearColor]
#define SnowColor               COLOR(255, 250, 250, 1.0)
#define IndigoColor             COLOR(13, 79, 139, 1.0)
#define DenimColor              COLOR(67, 114, 170, 1.0)
