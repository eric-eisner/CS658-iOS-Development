//
//  ToDoViewController.m
//  ToDo
//
//  Created by Ryan Hardt on 3/7/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import "ToDoListViewController.h"
#import "ToDoListItem.h"
#import "ToDoListItemDetailViewController.h"
#import "ToDoListItemTableViewCell.h"
#import "ToDoListSettingsTableViewController.h"
#import "AppDelegate.h"

@interface ToDoListViewController ()
@property(nonatomic, strong) NSMutableArray* toDoList;
@end

@implementation ToDoListViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
    
    self.toDoList = [NSMutableArray arrayWithArray:[self getToDoList]];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.deleteOnComplete = [NSMutableString stringWithString:[[NSUserDefaults standardUserDefaults] objectForKey:DeleteOnCompleteKey]];

    UIBarButtonItem* settingsButton = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStyleBordered target:self action:@selector(showSettings)];
    self.toolbarItems = @[settingsButton];
    self.navigationController.toolbarHidden = NO;
}

-(void)viewDidAppear:(BOOL)animated
{
    [self reorderList];
    [self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    if([self.deleteOnComplete isEqualToString:@"YES"]) {
        ToDoListItem* item;
        for(int i=0; i<self.toDoList.count; ++i) {
            item = [self.toDoList objectAtIndex:i];
            if(item.isCompleted.boolValue) {
                [self.toDoList removeObject:item];
                --i;
            }
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)addToDoListItem
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
    
    ToDoListItem* item;
    item = [NSEntityDescription insertNewObjectForEntityForName:@"ToDoListItem" inManagedObjectContext:moc];
    
    [self.toDoList insertObject:item atIndex:0];
    
    // Create an index path for the new item
    NSIndexPath* indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    // Update the tableview with cool animations
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
}

-(void)showSettings
{
    [self performSegueWithIdentifier:@"ShowSettingsSegue" sender:self];
}

-(NSMutableArray*)getToDoList
{
    AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext* moc = [appDelegate managedObjectContext];
        
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription* entity = [NSEntityDescription entityForName:@"ToDoListItem" inManagedObjectContext:moc];
    [fetchRequest setEntity:entity];
        
    NSSortDescriptor* sortByDate = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
    NSSortDescriptor* sortByTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByDate,sortByTitle]];
        
    NSError* error = nil;
    NSMutableArray* fetchResults = [NSMutableArray arrayWithArray:[moc executeFetchRequest:fetchRequest error:&error]];
        
    if(!fetchResults) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }

    return fetchResults;
}

-(void)reorderList
{
    NSSortDescriptor* sortByDate = [[NSSortDescriptor alloc] initWithKey:@"dueDate" ascending:YES];
    NSSortDescriptor* sortByTitle = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
    self.toDoList = [NSMutableArray arrayWithArray:[self.toDoList sortedArrayUsingDescriptors:@[sortByDate,sortByTitle]]];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.toDoList.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ListItemCell";
    ToDoListItemTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    ToDoListItem* item = [self.toDoList objectAtIndex:indexPath.row];
    cell.item = item;
    cell.titleTextField.text = item.title;
    if(item.isCompleted.boolValue == YES) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    } else {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    return cell;
}

#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    //always check to see which segue it is
    if([segue.identifier isEqualToString:@"ShowDetailView"]) {
        ToDoListItemDetailViewController* dest = [segue destinationViewController];
        NSIndexPath* indexPath = [self.tableView indexPathForSelectedRow];
        ToDoListItem* item;
        item = [self.toDoList objectAtIndex:indexPath.row];
        dest.item = item;
    } else if([segue.identifier isEqualToString:@"ShowSettingsSegue"]) {
        ToDoListSettingsTableViewController* dest = [segue destinationViewController];
        dest.deleteOnComplete = self.deleteOnComplete;
    }
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        ToDoListItem* toDoItem = [self.toDoList objectAtIndex:indexPath.row];
        [self.toDoList removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        AppDelegate* appDelegate = [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext* moc = [appDelegate managedObjectContext];
        [moc deleteObject:toDoItem];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


// Override to support rearranging the table view.
/*- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    ToDoListItem* item = [self.toDoList objectAtIndex:fromIndexPath.row];
    [self.toDoList removeObjectAtIndex:fromIndexPath.row];
    [self.toDoList insertObject:item atIndex:toIndexPath.row];
}*/


// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

@end
