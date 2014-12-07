//
//  RecipeCell.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "RecipeCell.h"

@implementation RecipeCell

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

- (void) setRecipe:(Recipe*)recipe
{
    [self.name_lbl setText:recipe.name];
    
    if (recipe.favorite)
        self.favorite_img.image = [UIImage imageNamed:@"estrella.png"];
    else
        self.favorite_img.image = [UIImage imageNamed:@"estrella_bw.png"];
}

@end
