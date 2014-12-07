//
//  RecipesViewController
//  Recetario
//
//  Created by German Attanasio Ruiz on 10/29/13.
//  Copyright (c) 2013 IBM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecipesViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    NSInteger selectedButton;
    NSMutableArray *recipesArray; //will be storing all the recipes
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *recipesArray;
@property (nonatomic) NSInteger selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *recipesLabel;

@end
