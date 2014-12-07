//
//  IngredientCell.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/2/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IngredientCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong,nonatomic) Ingredient* ingredient;
- (void) setIngredient:(Ingredient*)ingredient;
@end
