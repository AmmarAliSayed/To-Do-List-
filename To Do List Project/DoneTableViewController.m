//
//  DoneTableViewController.m
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import "DoneTableViewController.h"

@interface DoneTableViewController (){
    NSUserDefaults *defaults;
    NSString* tmpStr;
}

@end

@implementation DoneTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    defaults = [NSUserDefaults standardUserDefaults];
     //_inProgressTasks = [NSMutableArray new];
 //
     if ([[defaults objectForKey:@"DONETASKS_KEY"] mutableCopy] == nil) {
         _doneTasks = [NSMutableArray new];
         } else {
             _doneTasks = [[defaults objectForKey:@"DONETASKS_KEY"] mutableCopy];
         }
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    if (_doneDictionary != nil) {
        [_doneTasks addObject:_doneDictionary];
        [defaults setObject:_doneTasks forKey:@"DONETASKS_KEY"];
        [defaults synchronize];
        _doneDictionary = nil;//beacuse if you click in done twice will repeate the last cell
        [self.tableView reloadData];
    }
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [_doneTasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID" forIndexPath:indexPath];
    
    // Configure the cell...
  //  cell.textLabel.text=@"sayed";
    
    
    UIImageView*  priortyImg=[cell viewWithTag:1];
    UILabel*  nameLabel=[cell viewWithTag:2];
    UILabel* descLabel=[cell viewWithTag:3];
    UILabel* createdDateLabel=[cell viewWithTag:4];
    UILabel* createdDateLabelValue=[cell viewWithTag:5];
    UILabel* deadlineDateLabel=[cell viewWithTag:6];
    UILabel*  deadlineDateLabelValue=[cell viewWithTag:7];
    
    
    nameLabel.text=[[_doneTasks objectAtIndex:indexPath.row] valueForKey:@"name_k"];
    descLabel.text=[[_doneTasks objectAtIndex:indexPath.row] valueForKey:@"desc_k"];
    createdDateLabel.text=@"created in:";
    createdDateLabelValue.text=[[_doneTasks objectAtIndex:indexPath.row] valueForKey:@"CreateDate_k"];
   deadlineDateLabel.text= @"deadLine:";
deadlineDateLabelValue.text=[[_doneTasks objectAtIndex:indexPath.row]  valueForKey:@"deadLine_k"];
    
    //change tintcolor of image
    priortyImg.image = [priortyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tmpStr = [[_doneTasks objectAtIndex:indexPath.row]  valueForKey:@"priorty_k"];
    if ([tmpStr  isEqual:@"High"]) {
        [priortyImg setTintColor:[UIColor redColor]];
    }else if([tmpStr  isEqual:@"Low"]){
        [priortyImg setTintColor:[UIColor grayColor]];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [_doneTasks removeObjectAtIndex:indexPath.row];
        [defaults setObject:_doneTasks forKey:@"DONETASKS_KEY"];
        [defaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
