//
//  WHCOperation.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCOperation.h"
#import "WHCOperationBody.h"

@interface WHCOperation ()

@property (nonatomic, strong) WHCOperationBody *operationBody;

@end

@implementation WHCOperation


-(id)initWithBlock:(void(^)(void))block inPool:(WHCOperationPool *)pool
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.operationBody = [[WHCOperationBody alloc] initWithBodyBlock:block inPool:pool];
    return self;
}

+(instancetype)operationCreateWithBlock:(void(^)(void))block inPool:(WHCOperationPool *)pool
{
    return [[self alloc] initWithBlock:block inPool:pool];
}

+(instancetype)operationCreateWithBlock:(void(^)(void))block
{
    return [[self alloc] initWithBlock:block inPool:[WHCOperationPool poolCreateWithAsync]];
}

+(instancetype)operationOnceWithBlock:(void(^)(void))block
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, block);
    return [[super alloc] init];
}

+(instancetype)operationWithoutRunloopBlock:(void(^)(void))block
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block);
    return [[super alloc] init];
}

@end
