//
//  WHCOperationPool.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCOperationPool.h"
#import "WHCOperationPoolBody.h"

@interface WHCOperationPool ()

@property (nonatomic, strong) WHCOperationPoolBody *operationPoolBody;

@end

@implementation WHCOperationPool

-(id)initWithWOperatinPoolWithAsync:(BOOL)isAsync
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    self.operationPoolBody = [[WHCOperationPoolBody alloc] initOperationPoolBodyWithAsync:isAsync];
    return self;
}

+(instancetype)poolCreateWithAsync
{
    return [[self alloc] initWithWOperatinPoolWithAsync:YES];
}

+(instancetype)poolCreateWithSync
{
    return [[self alloc] initWithWOperatinPoolWithAsync:NO];
}

-(NSInteger)count
{
    return [self.operationPoolBody operationsCount];
}

-(void)cleanPool
{
    if (self.operationPoolBody)
    {
        [self.operationPoolBody cleanPoolBody];
    }
}


-(void)addOperation:(NSOperation *)op
{
    if (self.operationPoolBody)
    {
        [self.operationPoolBody addOperation:op];
    }
}

-(void)stop
{
    if (self.operationPoolBody)
    {
        [self.operationPoolBody stop];
    }
}

-(void)restart
{
    if (self.operationPoolBody)
    {
        [self.operationPoolBody restart];
    }
}


-(void)cancel
{
    if (self.operationPoolBody)
    {
        [self.operationPoolBody cancel];
        self.operationPoolBody = nil;
    }
}
@end
