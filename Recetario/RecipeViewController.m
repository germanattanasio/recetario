//
//  RecipeViewController.m
//  Recetario
//
//  Created by germana on 9/15/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import "RecipeViewController.h"
#import "IngredientCell.h"
#import "StepCell.h"
#import "Step.h"
#import "Ingredient.h"
#import "RecipeService.h"

@interface RecipeViewController ()

@end

@implementation RecipeViewController

    @synthesize izquierdaTableView,recipe;

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
    [[self view] setBackgroundColor: [[UIColor alloc] initWithPatternImage: [UIImage imageNamed: @"mantel_crema_tile.png"]]];

    UILongPressGestureRecognizer *longPress_gr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(markAsFavorite:)];
    [longPress_gr setMinimumPressDuration:1]; // triggers the action after 2 seconds of press
    [self.favoriteButton addGestureRecognizer:longPress_gr];

    
    [self updateFavoriteImage];
    self.recipeNameLabel.text = recipe.name;
    //initialize the array
    ingredients = [[NSMutableArray alloc] init];
    steps = [[NSMutableArray alloc] init];
    [self makeIngredientsRequest];
    [self makeStepsRequest];

    
}
- (void)markAsFavorite:(UILongPressGestureRecognizer *)recognizer {
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        recipe.favorite = !recipe.favorite;
        [RecipeService updateRecipe:recipe withSuccessBlock:^(Recipe * updatedRecipe) {
            [self updateFavoriteImage];
        } andFailureBlock:^(NSError *error) {
            NSLog(@"Error updating the recipe");
        }];
    }
}


- (void) makeIngredientsRequest {
    [RecipeService getIngredientsForRecipe:self.recipe withSuccessBlock:^(NSMutableArray * recipeIngredients) {
        [ingredients removeAllObjects];
        [ingredients addObjectsFromArray:recipeIngredients];
        [self.izquierdaTableView reloadData];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"Error loading the ingredients for: %@",self.recipe);
    } ];
}

- (void) updateFavoriteImage
{
    NSString *imageName;
    if (recipe.favorite) {
        imageName = @"estrella.png";
        self.addToFavoritesLabel.text = @"Quitar de Favoritas";
    } else {
        imageName = @"estrella_bw.png";
        self.addToFavoritesLabel.text = @"Agregar a Favoritas";
    }
    
    [self.favoriteButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
}

- (void) makeStepsRequest {
    [RecipeService getStepsForRecipe:self.recipe withSuccessBlock:^(NSMutableArray * recipeSteps) {
        [steps removeAllObjects];
        [steps addObjectsFromArray:recipeSteps];
        [self.derechaTableView reloadData];
    } andFailureBlock:^(NSError *error) {
        NSLog(@"Error loading the steps for: %@",self.recipe);
    } ];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == izquierdaTableView )
        return [ingredients count];
    else
        return [steps count];
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self.izquierdaTableView reloadData];
    [self.derechaTableView reloadData];

}

//calculate the cell height with the string attributes, the text to display and the cell with
- (CGFloat)calculateCellHeight:(CGFloat)fontSize cellWidth:(CGFloat)cellWidth
                      withText:(NSString *)text {
    CGFloat height = 0.0f;
    
        height = [text sizeWithFont:[UIFont systemFontOfSize:fontSize]
                  constrainedToSize:CGSizeMake(cellWidth, CGFLOAT_MAX)
                      lineBreakMode:NSLineBreakByWordWrapping].height;
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat ingredientCellWidth;
    CGFloat ingredientCellHeight;
    CGFloat ingredientFont;
    CGFloat ingredientCellOffset = 0.0f;
    
    CGFloat stepFont;
    CGFloat stepCellWidth;
    CGFloat stepCellHeight;
    CGFloat stepCellOffset = 0.0f;
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        ingredientCellWidth = 228.0f;
        ingredientCellHeight = 40.0f;
        ingredientFont = 15.0f;
        
        stepCellWidth = UIInterfaceOrientationIsLandscape([[UIDevice currentDevice] orientation]) ? 540.0f : 290.0f;
        stepFont = 17.0f;
        stepCellHeight = 55.0f;
        stepCellOffset = 15.0f;
    }
    else
    {
        //GER: check this!!!
        ingredientCellWidth = 200.0f;
        ingredientCellHeight = 30.0f;
        ingredientFont = 13.0f;
        ingredientCellOffset = 4.0f;
        

        stepCellWidth = 190.0f;
        stepFont = 13.0f;
        stepCellHeight = 45.0f;
        stepCellOffset = 10.0f;
    }
    
    CGFloat labelHeight = 0.0f;
    
    if (tableView == izquierdaTableView) {
        Ingredient* ing = [ingredients objectAtIndex:indexPath.row];
        labelHeight = [self calculateCellHeight:ingredientFont cellWidth:ingredientCellWidth withText:ing.name];
        return MAX(ingredientCellHeight,labelHeight+ingredientCellOffset);
    } else {
        Step* st = [steps objectAtIndex:indexPath.row];
        labelHeight = [self calculateCellHeight:stepFont cellWidth:stepCellWidth withText:st.content];
        return MAX(stepCellHeight,labelHeight+stepCellOffset);
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *stepIdentifier = @"StepCell";
    static NSString *ingredientIdentifier = @"IngredientCell";
    
    if(tableView == izquierdaTableView )
    {
        IngredientCell *cell = cell = [tableView dequeueReusableCellWithIdentifier:ingredientIdentifier];
        if (cell == nil) {
            cell = [[IngredientCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ingredientIdentifier ];
        }
        Ingredient * ingredient =(Ingredient*)[ingredients objectAtIndex:indexPath.row];
        [cell setIngredient:ingredient];
        return cell;
    } else
    {
        StepCell *cell = cell = [tableView dequeueReusableCellWithIdentifier:stepIdentifier];
        if (cell == nil) {
            cell = [[StepCell alloc]
                    initWithStyle:UITableViewCellStyleDefault reuseIdentifier:stepIdentifier ];
        }

        Step * step =(Step*)[steps objectAtIndex:indexPath.row];
        [cell setStep:step];
        return cell;
    }
    
}


- (IBAction)popView:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)popToRoot:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}


@end
