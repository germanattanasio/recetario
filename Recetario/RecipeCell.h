//
//  RecipeCell.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *name_lbl;
@property (weak, nonatomic) IBOutlet UIImageView *favorite_img;

- (void) setRecipe:(Recipe*)recipe;

@end
