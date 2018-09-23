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
        for (int i = 0; i < 5; i++) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    BNRItemStore *store = [BNRItemStore sharedStore];
//    NSArray *items = store.allItems;
//    return items.count;
    // above is the same as:
    return [[[BNRItemStore sharedStore] allItems] count];
}

// return a cell and the parameter give an index of the currnet item in the data array
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // create a cell
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:@"UITableViewCell"];
    
    // get all the items
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    
    // get the current item
    BNRItem *item = items[indexPath.row];
    
    // set the description of the item to the cell textLabel
    cell.textLabel.text = item.description;
    
    // return the cell
    return cell;
}


@end
