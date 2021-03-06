//
//  BNRItemsViewController.m
//  Homepwner
//
//  Created by John Moon on 5/30/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import "BNRItemsViewController.h"
#import "BNRItemStore.h"
#import "BNRItem.h"
#import "BNRDetailViewController.h"

@interface BNRItemsViewController()

@end

@implementation BNRItemsViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BNRDetailViewController *detailViewController = [[BNRDetailViewController alloc] init];
    
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *selectedItem = items[indexPath.row];
    
    //Give detail view controller a pointer to the item object in row
    detailViewController.item = selectedItem;
    
    //Push it to the top of the navigation controller's stack
    [self.navigationController pushViewController:detailViewController animated:YES];
}


-(IBAction)addNewItem:(id)sender
{
    //Create a new BNRItem and add it to the store
    BNRItem *newItem = [[BNRItemStore sharedStore] createItem];
    NSInteger lastRow = [[[BNRItemStore sharedStore] allItems] indexOfObject:newItem];

    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:lastRow inSection:0];
    //insert this new row
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
    
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //If the table view is asking to commit a delete
    if (editingStyle == UITableViewCellEditingStyleDelete){
        NSArray *items = [[BNRItemStore sharedStore] allItems];
        BNRItem *item = items[indexPath.row];
        [[BNRItemStore sharedStore] removeItem:item];
        
        
        //Also remove the row from the table view with an animation
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath
     toIndexPath:(NSIndexPath *)destinationIndexPath
{
    [[BNRItemStore sharedStore] moveItemAtIndex:sourceIndexPath.row
                                        toIndex:destinationIndexPath.row];
}

-(instancetype)init
{
    //Call the superclass's designated initializer
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        UINavigationItem *navItem = self.navigationItem;
        navItem.title = @"Homepwner";
    
    
        //Create a new bar button item that will send addNewItem: to BNRItemViewController
        UIBarButtonItem *bbi =  [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewItem:)];
        
        //Set this bar button item as the rigth  item in the navigationItem
        navItem.rightBarButtonItem = bbi;
        navItem.leftBarButtonItem = self.editButtonItem;
    }
    
    return self;
}

-(instancetype)initWithStyle:(UITableViewStyle)style
{
    return [self init];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[BNRItemStore sharedStore] allItems] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    //Get a new or recycled cell - Reuse of cells so that iphone doesn't deminish it's memory
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    
    //Set the text on the cell with the description of the item
    NSArray *items = [[BNRItemStore sharedStore] allItems];
    BNRItem *item = items[indexPath.row];
    
    cell.textLabel.text = [item description];
    
    return cell;
}

//Overrdie viewDidLoad to tell the table view which kind of cell it should instantiate if there are no cells in the reuse pool
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    
    //Manually set HeaderView.xib
}

@end
