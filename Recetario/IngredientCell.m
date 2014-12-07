//
//  IngredientCell.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/2/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "IngredientCell.h"
#include "IconFinder.h"

@implementation IngredientCell
@synthesize ingredient;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) setIngredient:(Ingredient*)ingre
{
    ingredient = ingre;
    NSString *ingredientWithoutInfo = [[ingredient.name componentsSeparatedByString:@"("] objectAtIndex:0];
    self.name.text = [NSString stringWithFormat:@"%@ %@",ingredient.amount,ingredientWithoutInfo];
    
    NSString *ingredientImage = nil;
    
    //check if the icon exists otherwise try to guess it
    if (ingredient.icon != nil && [ingredient.icon length] > 0)
        ingredientImage = [NSString stringWithFormat:@"ingr_%@.png",ingredient.icon];
    else
        ingredientImage = [[IconFinder sharedSingleton] guessIngredientIconFromString:ingredientWithoutInfo];
    
    if (ingredientImage != nil)
        self.image.image = [UIImage imageNamed:ingredientImage];

    
    
}

@end
