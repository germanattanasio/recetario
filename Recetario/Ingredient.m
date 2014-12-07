//
//  Ingredient.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/1/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "Ingredient.h"

@implementation Ingredient

@synthesize _id,recipe_id,amount,name,icon;


- (NSString *)description {
    return [NSString stringWithFormat: @"_id:%d, recipe_id:%d, amount:%@, name:%@, icon:%@", _id,recipe_id,amount,name,icon];
}
@end
