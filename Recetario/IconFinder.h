//
//  IconFinder.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/21/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IconFinder : NSObject 

+ (IconFinder *)sharedSingleton;

- (NSString*) guessIngredientIconFromString:(NSString*) text;
- (NSString*) guessRecipeStepIconFromString:(NSString*) text;

@end
