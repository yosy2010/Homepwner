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

// override init to make the style of the label laways grouped and to change the bg image of the table
- (instancetype)init
{
    // call the designated initilizer
    self = [super initWithStyle:UITableViewStyleGrouped];
    
    if (self) {
        
        // put a UIImage to the background of the table
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg2"]];
        imageView.frame = self.tableView.frame;
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        self.tableView.backgroundView = imageView;
        
        
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



// what do you want to do ater the view loads
- (void)viewDidLoad
{
    // call super view did load
    [super viewDidLoad];
    
    // set the table view identifier to be reused
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:@"UITableViewCell"];
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


// change the size of the font and the text alignment for the header
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *) view;
    header.textLabel.font = [UIFont boldSystemFontOfSize:24];
    
    header.textLabel.textAlignment = NSTextAlignmentCenter;
}

// set how many rows in each section
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

// set the height of rwos
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        if (indexPath.row == [BNRItemStore.sharedStore.allItems[1] count]) {
            return 44;
        }
    }
    
    return 60;
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
            cell.textLabel.font = [UIFont systemFontOfSize:17];
            return cell;
        }
        
        item = cheap[indexPath.row];
    }
    

    // set the description of the item to the cell textLabel
    cell.textLabel.text = item.description;
    
    // change font size to 20
    cell.textLabel.font = [UIFont systemFontOfSize:20];
    // return the cell
    return cell;
}

// to tweak the cell, Here we will make the cells transparent so we can see the image
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = UIColor.clearColor;
}

@end
