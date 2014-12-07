//
//  Recipe.m
//  Recetario
//
//  Created by germana on 9/17/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "Recipe.h"

@implementation Recipe

@synthesize _id,icon,name,igredients,steps,category,favorite;

- (NSString *)description {
    return [NSString stringWithFormat: @"_id:%d, name:%@, cat:%@, fav:%d, icon:%@", _id,name,category,favorite,icon];
}

@end
