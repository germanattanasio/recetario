//
//  Ingredient.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/1/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ingredient : NSObject

@property(nonatomic) int recipe_id;
@property(nonatomic) int _id;

@property(nonatomic,retain) NSString * name;
@property(nonatomic,retain) NSString * icon;
@property(nonatomic,retain) NSString * amount;

@end
