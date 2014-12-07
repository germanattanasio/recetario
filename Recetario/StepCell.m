//
//  StepCell.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/2/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "StepCell.h"
#import "IconFinder.h"

@implementation StepCell 

@synthesize step;


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void) setStep:(Step*)recipeStep
{
    step = recipeStep;
    self.stepContent.text = [NSString stringWithFormat:@"%@",step.content ];

    NSString *stepImage = nil;
    
    //check if the icon exists otherwise try to guess it
    if (step.icon != nil && [step.icon length] >0)
        stepImage = [NSString stringWithFormat:@"accion_%@.png",step.icon];
    else {
        stepImage = [[IconFinder sharedSingleton] guessRecipeStepIconFromString:step.content];
    }
    if (stepImage != nil)
        self.stepImage.image = [UIImage imageNamed:stepImage];

}


@end
