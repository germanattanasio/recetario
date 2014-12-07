//
//  ViewController.m
//  Recetario
//
//  Created by germana on 9/15/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "ViewController.h"
#import "RecipesViewController.h"

@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [[self view] setBackgroundColor: [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: @"mantel_violeta_tile.png"]]];
    
    //clear clear nav bar
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
                                                  forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.view.backgroundColor = [UIColor clearColor];
}

- (IBAction)buttonPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"recetasSiege" sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"recetasSiege"]) {
        
        // Get destination view
        RecipesViewController *vc = [segue destinationViewController];
        
        // Get button tag
        NSInteger tagIndex = [(UIButton *)sender tag];
        
        // Set the selected button in the new view
        [vc setSelectedButton:tagIndex];
    }
}
- (IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
@end
