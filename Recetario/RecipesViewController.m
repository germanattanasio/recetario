//
//  RecipesViewController
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "RecipesViewController.h"
#import "RecipeService.h"
#import "RecipeCell.h"
#import "RecipeViewController.h"

@interface RecipesViewController ()

@end

@implementation RecipesViewController
{
    NSString *category;
    NSString *background;
    NSString *title;
}
@synthesize selectedButton,recipesArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = nil;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    switch (self.selectedButton) {
        case 0:
            category =  PANADERIA;
            background = @"mantel_lila_tile.png";
            title = [NSString stringWithFormat:@"Recetas de %@",PANADERIA];
            break;
            
        case 1:
            category = PASTELERIA;
            background = @"mantel_celeste_tile.png";
            title = [NSString stringWithFormat:@"Recetas de %@",PASTELERIA];
            break;
            
        case 2:
            category = FAVORITAS;
            background = @"mantel_amarillo_tile.png";
            title = [NSString stringWithFormat:@"Recetas %@",FAVORITAS];
            break;
            
        default:
            break;
    }
    self.recipesLabel.text = title;
    [[self view] setBackgroundColor: [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: background]]];

    //initialize the array
    recipesArray = [[NSMutableArray alloc] init];
}

- (void) viewWillAppear:(BOOL)animated
{
    [self makeRecipeRequests];
}

- (void) makeRecipeRequests {
    [RecipeService getRecipesForCategory:category withSuccessBlock:^(NSMutableArray * recipes) {
        [recipesArray removeAllObjects];
        [recipesArray addObjectsFromArray:recipes];
        [self.tableView reloadData];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"Error loading the recipes");
    } ];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [recipesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"RecipeCell";
    RecipeCell *cell = (RecipeCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[RecipeCell alloc]
                initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier ];
    }
    
    [cell setRecipe: [recipesArray objectAtIndex:indexPath.row]];
    return cell;
}
- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}
- (IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
    Recipe * selectedRecipe = [recipesArray objectAtIndex:indexPath.row];
    
    if([segue.identifier isEqualToString:@"viewRecipeSiege"])
    {
        RecipeViewController *recipeViewController = segue.destinationViewController;
        recipeViewController.recipe = selectedRecipe;
    }
}

@end
