//
//  MainMenuViewController.m
//  Recetario
//
//  Created by German Attanasio Ruiz on 11/10/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "MainMenuViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.view setBackgroundColor: [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: @"wood_tile.jpg"]]];
    
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(gestureRecognizerAction)];
    [self.view addGestureRecognizer:gestureRecognizer];
    
    self.aboutView.layer.borderColor = [UIColor grayColor].CGColor;
    self.aboutView.layer.borderWidth = 3.0f;
    self.aboutView.layer.cornerRadius = 10;
    self.aboutView.layer.masksToBounds = YES;

    //Get the application version
    NSDictionary *info = [[NSBundle mainBundle] infoDictionary];
    NSString *version = [info objectForKey:@"CFBundleShortVersionString"];
    self.versionLabel.text = [NSString stringWithFormat:@"Version: %@",version ];
}

- (void) gestureRecognizerAction {
    [self.aboutView setAlpha:1.0];
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.aboutView setAlpha:0.0];
                     }
                     completion:^(BOOL completed){
                         [self.aboutView setHidden:YES];
                     }];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)clickAbout:(id)sender {
    [self.aboutView setHidden:NO];
    [self.aboutView setAlpha:0.0];
    [UIView animateWithDuration:0.8
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         [self.aboutView setAlpha:1.0];
                     }
                     completion:^(BOOL completed){
                     }];}

@end
