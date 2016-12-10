//
//  WHCOperationPoolBody.h
//  WHCAPP
//
//  Created by Haochen Wang on 11/25/16.
//  Copyright © 2016 WHC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WHCOperationPoolBody : NSObject

@property (nonatomic, assign) NSInteger operationsCount;

-(instancetype)initOperationPoolBodyWithAsync:(BOOL)isAsync;

-(void)cleanPoolBody;

-(void)addOperation:(NSOperation *)op;

-(void)stop;

-(void)cancel;

-(void)restart;

@end
