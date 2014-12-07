//
//  Recipe.h
//  Recetario
//
//  Created by germana on 9/17/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DatabaseService.h"

@interface Recipe : NSObject

@property(nonatomic) int _id;
@property(nonatomic, retain) NSString *name;
@property(nonatomic, retain) NSString *icon;
@property(nonatomic, retain) NSString *category;
@property(nonatomic, retain) NSMutableArray *steps;
@property(nonatomic, retain) NSMutableArray *igredients;
@property(nonatomic) BOOL favorite;



@end
