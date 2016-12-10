//
//  WHCOperationBady.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCOperationPool.h"

@interface WHCOperationBody : NSObject

-(instancetype)initWithBodyBlock:(void (^)(void))block inPool:(WHCOperationPool *)pool;

@end
