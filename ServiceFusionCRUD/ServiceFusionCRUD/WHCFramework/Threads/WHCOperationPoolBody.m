//
//  WHCOperationPoolBody.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCOperationPoolBody.h"
#import <sys/sysctl.h>

@interface WHCOperationPoolBody ()

@property (nonatomic, strong) NSOperationQueue *queue;

@end

@implementation WHCOperationPoolBody

-(instancetype)initOperationPoolBodyWithAsync:(BOOL)isAsync
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    if (isAsync)
    {
        [queue setMaxConcurrentOperationCount:MAXOPCOUNT()];
    }
    else
    {
        [queue setMaxConcurrentOperationCount:2];
    }
    self.queue = queue;
    return self;
}

static inline uint32_t MAXOPCOUNT()
{
    uint32_t cpus;
    uint32_t activecpu;
    size_t s_cpus = sizeof(cpus);
    size_t s_activecpu = sizeof(activecpu);
    sysctlbyname("hw.ncpu", &cpus, &s_cpus, NULL, 0);
    sysctlbyname("hw.activecpu", &activecpu, &s_activecpu, NULL, 0);
    int max_avaliable_count = (2*cpus-1)-(cpus-activecpu);                    //压测最优值
    return max_avaliable_count>2?max_avaliable_count:2;
}

-(NSInteger)operationsCount
{
    return self.queue.operationCount;
}

-(void)cleanPoolBody
{
    for (NSOperation *op in self.queue.operations)
    {
        [op cancel];
    }
    [self.queue cancelAllOperations];
}

-(void)addOperation:(NSOperation *)op
{
    if (self.queue)
    {
        [self.queue addOperation:op];
    }
}

-(void)stop
{
    if (self.queue)
    {
        [self.queue setSuspended:NO];
    }
}

-(void)restart
{
    if (self.queue)
    {
        [self.queue setSuspended:YES];
    }
}

-(void)cancel
{
    if (self.queue)
    {
        [self cleanPoolBody];
        self.queue = nil;
    }
}


















@end
