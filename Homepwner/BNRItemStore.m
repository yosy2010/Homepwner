//
//  BNRItemStore.m
//  Homepwner
//
//  Created by YASSER ALTAMIMI on 22/09/2018.
//  Copyright © 2018 YASSER ALTAMIMI. All rights reserved.
//

#import "BNRItemStore.h"
#import "BNRItem.h"

@interface BNRItemStore ()

@property (nonatomic) NSMutableArray *privatExpensiveItems; // this is private because we don't want other object to change any thing except through our methods
@property (nonatomic) NSMutableArray *privateCheapItems;

@end

@implementation BNRItemStore

// when this class method is called, the class will check if it already exists, if yes: return it, if not: create one then return it
+ (instancetype)sharedStore
{
    // make it static so there only be on of it
    static BNRItemStore *sharedStore = nil;
    
    // does it exists?
    if (!sharedStore) {
        // no? then create one using the initPrivate
        sharedStore = [[self alloc] initPrivate];
    }
    // then return it
    return sharedStore;
}

// override the init method and show an error
- (instancetype)init
{
    @throw [NSException exceptionWithName:@"singleton"
                                   reason:@"use +[BNRItemStore sharedStore]"
                                 userInfo:nil];
    
    return nil;
}

// private initializer used only the first time to initialize the shared store
- (instancetype)initPrivate
{
    // call the super to initialize for the first time
    self = [super init];
    
    // no error in creating the store?
    if (self) {
        // create the two arrays that will hold the items internally
        _privatExpensiveItems = [[NSMutableArray alloc] init];
        _privateCheapItems = [[NSMutableArray alloc]init];
    }
    
    return self;
}

// since NSMutableArray is a sub class of NSArray then we can return our mutable array as an inmutable one
- (NSArray *)allItems
{
    return @[self.privatExpensiveItems, self.privateCheapItems];
}

// this will call the random item initializer in bnr item and create an item and store it in the store
- (BNRItem *)createItem
{
    BNRItem *item = [BNRItem randomItem];
    
    if (item.valueInDollars > 50) {
        [self.privatExpensiveItems addObject:item];
    } else {
        [self.privateCheapItems addObject:item];
    }
    
    return item;
}

@end
