//
//  Step.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/1/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "Step.h"

@implementation Step

@synthesize _id,recipe_id,seq,content,icon;

- (NSString *)description {
    return [NSString stringWithFormat: @"_id:%d, recipe_id:%d, seq:%d, content:%@, icon:%@", _id,recipe_id,seq,content,icon];
}

@end
