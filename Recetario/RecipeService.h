//
//  RecipeService.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Recipe.h"

@interface RecipeService : NSObject

typedef void(^RecipesSuccessBlock)(id responseObject);
typedef void(^RecipesFailureBlock)(NSError* error);

+ (void)getRecipesWithSuccessBlock:(RecipesSuccessBlock)success
                   andFailureBlock:(RecipesFailureBlock)failure;

+ (void)getRecipesForCategory:(NSString*)category
             withSuccessBlock:(RecipesSuccessBlock)success
              andFailureBlock:(RecipesFailureBlock)failure;

+ (void)getStepsForRecipe:(Recipe*) recipe
               withSuccessBlock:(RecipesSuccessBlock)success
                andFailureBlock:(RecipesFailureBlock)failure;

+ (void)getIngredientsForRecipe:(Recipe*) recipe
               withSuccessBlock:(RecipesSuccessBlock)success
                andFailureBlock:(RecipesFailureBlock)failure;

+ (void)updateRecipe:(Recipe*) recipe
         withSuccessBlock:(RecipesSuccessBlock)success
          andFailureBlock:(RecipesFailureBlock)failure;
@end
