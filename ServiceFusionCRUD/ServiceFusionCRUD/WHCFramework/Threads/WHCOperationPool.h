//
//  WHCOperationPool.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHCOperationPool : NSObject

@property (nonatomic, assign) NSInteger count;


+(instancetype)poolCreateWithSync;

+(instancetype)poolCreateWithAsync;

-(void)cleanPool;

-(void)addOperation:(NSOperation *)op;

-(void)stop;

-(void)cancel;

-(void)restart;

@end
