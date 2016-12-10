//
//  WHCOperationBady.m
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import "WHCOperationBody.h"

@implementation WHCOperationBody

-(instancetype)initWithBodyBlock:(void (^)(void))block inPool:(WHCOperationPool *)pool
{
    self = [super init];
    if (!self)
    {
        return nil;
    }

    if (pool.count == 0)
    {
        [self prepareEnvironmentInPool:pool];
    }
    [pool addOperation:[NSBlockOperation blockOperationWithBlock:block]];
    return self;
}

- (void)prepareEnvironmentInPool:(WHCOperationPool *)pool
{
    NSBlockOperation *environmentOperation = [NSBlockOperation blockOperationWithBlock:^{
        CFRunLoopSourceContext context = {0, (__bridge void *)(self),
            NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL};
        CFRunLoopSourceRef runLoopSource = CFRunLoopSourceCreate(NULL, 0, &context);

        CFRunLoopRef runLoop = [[NSRunLoop currentRunLoop] getCFRunLoop];
        CFRunLoopAddSource(runLoop, runLoopSource, kCFRunLoopDefaultMode);

        while (![NSThread currentThread].isCancelled) {
            @autoreleasepool {
                [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
        }
    }];
    [pool addOperation:environmentOperation];
}

@end
