//
//  Step.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/1/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Step : NSObject

@property(nonatomic) int recipe_id;
@property(nonatomic) int seq;
@property(nonatomic) int _id;

@property(nonatomic,retain) NSString * content;
@property(nonatomic,retain) NSString * icon;

@end
