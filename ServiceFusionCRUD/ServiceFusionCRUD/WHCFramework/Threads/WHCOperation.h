//
//  WHCOperation.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WHCOperationPool.h"

@interface WHCOperation : NSObject

+(instancetype)operationCreateWithBlock:(void(^)(void))block inPool:(WHCOperationPool *)pool;

+(instancetype)operationCreateWithBlock:(void(^)(void))block;

+(instancetype)operationOnceWithBlock:(void(^)(void))block;

+(instancetype)operationWithoutRunloopBlock:(void(^)(void))block;

@end
