//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 22/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"


@implementation BNRItemsViewController

// override init to make the style of the label laways plain
- (instancetype)init
{
    // call the designated initilizer
    self = [super initWithStyle:UITableViewStylePlain];
    
    if (self) {
        
        // create 5 itemes and put them in the store
        for (int i = 0; i < 15; i++) {
            [[BNRItemStore sharedStore] createItem];
        }
    }
    
    return self;
}

// override initWithStyle (designated)
// let it call init which configer the style of the table
- (instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

- (void)viewDidLoad
{
    // call super view did load
    [super viewDidLoad];
    
    // set the table view identifier to be reused
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *allItems = BNRItemStore.sharedStore.allItems;
    NSArray *expensive = allItems[0];
    NSArray *cheap = allItems[1];
    NSInteger numberOFRowInSection = 0;
    if (section == 0) {
        numberOFRowInSection = [expensive count];
    } else {
        numberOFRowInSection = [cheap count] + 1;
    }
    
    return numberOFRowInSection;
}

// return a cell and the parameter give an index of the currnet item in the data array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // create a cell or reuse one that is ready
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    // get expensive items
    NSArray *expensive = BNRItemStore.sharedStore.allItems[0];
    
    // get cheap items
    NSArray *cheap = BNRItemStore.sharedStore.allItems[1];
    
    // create the current item
    BNRItem *item;
    
    // get the current item
    if (indexPath.section == 0) {
        item = expensive[indexPath.row];
    } else if (indexPath.section == 1) {
        
        if (indexPath.row == cheap.count) {
            cell.textLabel.text = @"No more Items";
            return cell;
        }
        
        item = cheap[indexPath.row];
    }
    

    // set the description of the item to the cell textLabel
    cell.textLabel.text = item.description;
    
    // return the cell
    return cell;
}

// set the number of section in the tableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

// set the title for each sectoin
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *sectionHeader = @"- $50";
    
    if (section == 0) {
        sectionHeader = @"+ $50";
    }
    
    return sectionHeader;
}
@end
