//
//  RecipeService.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "RecipeService.h"
#import "Recipe.h"
#import "Step.h"
#import "Ingredient.h"
#import "DatabaseService.h"
#define FAVORITES @"favorites"

@implementation RecipeService


//get recipes and parse them
+(void)getRecipesWithSuccessBlock:(RecipesSuccessBlock)success
                  andFailureBlock:(RecipesFailureBlock)failure {
    NSMutableArray *recipes = [NSMutableArray array];
    NSSet *favs = [NSSet setWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:FAVORITES]];
    
    [DatabaseService performSelectOnTable:@"recipe" withParameters:nil withResultBlock:^(FMResultSet *resultSet) {
        Recipe *item = [Recipe new];
        item._id  = [resultSet intForColumn:@"_id"];
        item.category = [resultSet stringForColumn:@"category"];
        item.name = [resultSet stringForColumn:@"name"];
        item.icon = [resultSet stringForColumn:@"icon"];
        item.favorite = [favs containsObject:[NSNumber numberWithInt:item._id]];
        [recipes addObject:item];
    } completionBlock:^{
       success(recipes);
    }];
    
}

+ (void)getRecipesForCategory:(NSString*)category
             withSuccessBlock:(RecipesSuccessBlock)success
              andFailureBlock:(RecipesFailureBlock)failure
{
    NSMutableArray *recipes = [NSMutableArray array];
    NSSet *favs = [NSSet setWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:FAVORITES]];

    NSString *filter;
    if ([category isEqualToString:FAVORITAS])
        filter = nil;
    else
        filter = [NSString stringWithFormat:@"category = '%@'", category];


    [DatabaseService performSelectOnTable:@"recipe" withParameters:filter withResultBlock:^(FMResultSet *resultSet) {
        BOOL isFavorite = [favs containsObject:[NSNumber numberWithInt:[resultSet intForColumn:@"_id"]]];
        if (filter == nil && isFavorite == NO)
            return;
        
        Recipe *item = [Recipe new];
        item._id  = [resultSet intForColumn:@"_id"];
        item.category = [resultSet stringForColumn:@"category"];
        item.name = [resultSet stringForColumn:@"name"];
        item.icon = [resultSet stringForColumn:@"icon"];
        item.favorite = isFavorite;
        [recipes addObject:item];
    } completionBlock:^{
        success(recipes);
    }];
}
+ (void)getStepsForRecipe:(Recipe*) recipe
         withSuccessBlock:(RecipesSuccessBlock)success
          andFailureBlock:(RecipesFailureBlock)failure
{
    NSMutableArray *steps = [NSMutableArray array];
    [DatabaseService performSelectOnTable:@"step" withParameters:[NSString stringWithFormat:@"recipe_id = %i", recipe._id] withResultBlock:^(FMResultSet *resultSet) {
        Step *item = [[Step alloc] init];
        item._id  = [resultSet intForColumn:@"_id"];
        item.recipe_id  = [resultSet intForColumn:@"recipe_id"];
        item.icon = [resultSet stringForColumn:@"icon"];
        item.seq = [resultSet intForColumn:@"seq"];
        item.content = [resultSet stringForColumn:@"content"];
        [steps addObject:item];
    } completionBlock:^{
        success(steps);
    }];

}

+ (void)getIngredientsForRecipe:(Recipe*) recipe
               withSuccessBlock:(RecipesSuccessBlock)success
                andFailureBlock:(RecipesFailureBlock)failure
{
    NSMutableArray *ingredients = [NSMutableArray array];
    [DatabaseService performSelectOnTable:@"ingredient" withParameters:[NSString stringWithFormat:@"recipe_id = %i", recipe._id] withResultBlock:^(FMResultSet *resultSet) {
        Ingredient *item = [[Ingredient alloc] init];
        item._id  = [resultSet intForColumn:@"_id"];
        item.recipe_id  = [resultSet intForColumn:@"recipe_id"];
        item.icon = [resultSet stringForColumn:@"icon"];
        item.amount = [resultSet stringForColumn:@"amount"];
        item.name = [resultSet stringForColumn:@"name"];
        [ingredients addObject:item];
    } completionBlock:^{
        success(ingredients);
    }];

}

+ (void)updateRecipe:(Recipe*) recipe
    withSuccessBlock:(RecipesSuccessBlock)success
     andFailureBlock:(RecipesFailureBlock)failure
{
    NSMutableSet *favs = [NSMutableSet setWithArray:[[NSUserDefaults standardUserDefaults]objectForKey:FAVORITES]];
    if (recipe.favorite) {
        [favs addObject:[NSNumber numberWithInt:recipe._id]];
    } else {
        [favs removeObject:[NSNumber numberWithInt:recipe._id]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[favs allObjects] forKey:FAVORITES];
    [[NSUserDefaults standardUserDefaults] synchronize];

    success(recipe);
}
     
@end
