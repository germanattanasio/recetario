//
//  RecetaViewController.h
//  Recetario
//
//  Created by germana on 9/15/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeViewController : UIViewController {

        NSMutableArray *ingredients; //will be storing all the ingredient
        NSMutableArray *steps; //will be storing all the steps
}

@property (weak, nonatomic) IBOutlet UITableView *izquierdaTableView;
@property (weak, nonatomic) IBOutlet UITableView *derechaTableView;
@property (weak, nonatomic) IBOutlet UILabel *recipeNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addToFavoritesLabel;

@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property(nonatomic,strong) Recipe* recipe;
@end
