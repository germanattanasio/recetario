//
//  StepCell.h
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/2/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Step.h"

@interface StepCell : UITableViewCell

@property(strong,nonatomic) Step* step;

@property (weak, nonatomic) IBOutlet UILabel *stepContent;
@property (weak, nonatomic) IBOutlet UIImageView *stepImage;
- (void) setStep:(Step*) step;

@end
