//
//  InProgressTableViewController.m
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import "InProgressTableViewController.h"
#import "Task.h"
#import "AddNewTaskViewController.h"
@interface InProgressTableViewController ()

@end

@implementation InProgressTableViewController{
   NSUserDefaults *defaults;
   NSString* tmpStr;
}

//NSMutableArray *namesArr;
//NSMutableArray *descArr;
//NSMutableArray *currentDateArr;
//NSMutableArray *deadLineArr;
//NSMutableArray *prorityImagArr;
- (void)viewDidLoad {
    [super viewDidLoad];
   defaults = [NSUserDefaults standardUserDefaults];
    //_inProgressTasks = [NSMutableArray new];
//
    if ([[defaults objectForKey:@"PROGTASKS_KEY"] mutableCopy] == nil) {
        _inProgressTasks = [NSMutableArray new];
        } else {
            _inProgressTasks = [[defaults objectForKey:@"PROGTASKS_KEY"] mutableCopy];
        }
   
    
    //_inProgressDictionary=[NSMutableDictionary new];
//  for(NSString *key in [_inProgressDictionary allKeys]) {
//    NSLog(@"%@",[_inProgressDictionary objectForKey:key]);
//      
//  }
    //_inProgressTasks=[NSMutableArray new];
  // printf("%lu",(unsigned long)_inProgressTasks.count);
   
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:true];
    if (_inProgressDictionary != nil) {
        [_inProgressTasks addObject:_inProgressDictionary];
        [defaults setObject:_inProgressTasks forKey:@"PROGTASKS_KEY"];
        [defaults synchronize];
        _inProgressDictionary = nil;//beacuse if you click in progress twice will repeate the last cell
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
    return[_inProgressTasks count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    
    // Configure the cell...
   // cell.textLabel.text=@"ahmed";
    
    UIImageView*  priortyImg=[cell viewWithTag:1];
    UILabel*  nameLabel=[cell viewWithTag:2];
    UILabel* descLabel=[cell viewWithTag:3];
    UILabel* createdDateLabel=[cell viewWithTag:4];
    UILabel* createdDateLabelValue=[cell viewWithTag:5];
    UILabel* deadlineDateLabel=[cell viewWithTag:6];
    UILabel*  deadlineDateLabelValue=[cell viewWithTag:7];
    
    
    nameLabel.text=[[_inProgressTasks objectAtIndex:indexPath.row] valueForKey:@"name_k"];
    descLabel.text=[[_inProgressTasks objectAtIndex:indexPath.row] valueForKey:@"desc_k"];
    createdDateLabel.text=@"created in:";
    createdDateLabelValue.text=[[_inProgressTasks objectAtIndex:indexPath.row] valueForKey:@"CreateDate_k"];
   deadlineDateLabel.text= @"deadLine:";
deadlineDateLabelValue.text=[[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"deadLine_k"];
    
    //change tintcolor of image
    priortyImg.image = [priortyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tmpStr = [[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"priorty_k"];
    if ([tmpStr  isEqual:@"High"]) {
        [priortyImg setTintColor:[UIColor redColor]];
    }else if([tmpStr  isEqual:@"Low"]){
        [priortyImg setTintColor:[UIColor grayColor]];
    }
    
    
//    nameLabel.text=[namesArr objectAtIndex:indexPath.row];
//    descLabel.text=[descArr objectAtIndex:indexPath.row];
//    createdDateLabel.text=@"created in:";
//    createdDateLabelValue.text=[currentDateArr objectAtIndex:indexPath.row];
//   deadlineDateLabel.text= @"deadLine:";
//   deadlineDateLabelValue.text=[deadLineArr objectAtIndex:indexPath.row];
   // priortyImg.image=[prorityImagArr objectAtIndex:indexPath.row];
    
    
    //printf("%li",(long)indexPath.row);
//  nameLabel.text=[[_inProgressTasks objectAtIndex:indexPath.row] name];
//     descLabel.text=[[_inProgressTasks objectAtIndex:indexPath.row] desc];
//     createdDateLabel.text=@"created in:";
//     createdDateLabelValue.text=[[_inProgressTasks objectAtIndex:indexPath.row] CreateDate];
//     deadlineDateLabel.text= @"deadLine:";
//     deadlineDateLabelValue.text=[[_inProgressTasks objectAtIndex:indexPath.row] deadLine];
//
//    priortyImg.image=[[_inProgressTasks objectAtIndex:indexPath.row] img];
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}
/*
- (void)addNewTaskToInProgress:(NSMutableDictionary *)task {
    printf("hi");
    [_inProgressTasks addObject:task];
    [defaults setObject:_inProgressTasks forKey:@"PROGTASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
}
*/


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
        [_inProgressTasks removeObjectAtIndex:indexPath.row];
        [defaults setObject:_inProgressTasks forKey:@"PROGTASKS_KEY"];
        [defaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}



//handling click in cells
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //go to next screen by push it to stack of navigation controller
    EditInProgressViewController* EDVc=[self.storyboard instantiateViewControllerWithIdentifier:@"edit2_id"];
    //7
   [ EDVc setEditTaskInProgressDelegateRef:self];
    
    EDVc.edName=[[_inProgressTasks objectAtIndex:indexPath.row] valueForKey:@"name_k"];
    EDVc.edDis=[[_inProgressTasks objectAtIndex:indexPath.row] valueForKey:@"desc_k"];
    EDVc.edPriorty=[[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"priorty_k"];
    EDVc.edDeadline=[[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"deadLine_k"];
    EDVc.CellInedex=indexPath.row;
    EDVc.labelCreatedin=[[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"CreateDate_k"];
    EDVc.edState=[[_inProgressTasks objectAtIndex:indexPath.row]  valueForKey:@"state_k"];
  //  EDVc.edState
    [ self.navigationController pushViewController:EDVc animated:(YES)];
}

-(void)editTaskInProgress:(NSMutableDictionary *)task :(int)index{
    [_inProgressTasks insertObject:task atIndex:index ];
    [defaults setObject:_inProgressTasks forKey:@"PROGTASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
}

-(void)editTaskDone:(NSMutableDictionary *)task : (int )index{
    //add it to done
    NSArray *viewControllers = [self.tabBarController viewControllers];
            UINavigationController *myNavController = (UINavigationController *)viewControllers[1];
            DoneTableViewController *doneVc = [[myNavController childViewControllers] firstObject];
    doneVc.doneDictionary=task;
    //remove it from inprogress
    [_inProgressTasks removeObjectAtIndex:index];
    [defaults setObject:_inProgressTasks forKey:@"PROGTASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


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
//- (void)viewWillAppear:(BOOL)animated{
//
//    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
//           NSString *documentsPath = [paths objectAtIndex:0];
//           NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Property List.plist"];
//
//    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithContentsOfFile:(NSString *)plistPath];
//
//    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath])
//        {
//            plistPath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
//        }
//
//        NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:plistPath];
//        namesArr = [dict objectForKey:@"names"];
//        descArr = [dict objectForKey:@"description"];
//   currentDateArr = [dict objectForKey:@"created date"];
//   deadLineArr = [dict objectForKey:@"deadline"];
//   // prorityImagArr = [dict objectForKey:@"images"];
//        [self.tableView reloadData ];
//
// //   AddNewTaskViewController* addNewTaskVc=[self.storyboard instantiateViewControllerWithIdentifier:@"addNewTaskVcId"];
//    //7
//   // [ addNewTaskVc setInProgressDelegateRef:self];
//}


@end
