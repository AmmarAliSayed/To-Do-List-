//
//  ToDoTableViewController.m
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import "ToDoTableViewController.h"
#import "Task.h"
#import "AddNewTaskViewController.h"
#import "EditInToDoViewController.h"
@interface ToDoTableViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ToDoTableViewController{
    NSUserDefaults *defaults;
    NSString* tmpStr;
    int tmpInndex;
   NSArray*filteredData;
    NSMutableArray*myData;
    NSArray *data;
   BOOL isSearching;
    BOOL isGrantedNotificationAccess;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    isGrantedNotificationAccess=false;
    [self createNotification];
    
  
        defaults = [NSUserDefaults standardUserDefaults];
    _ProgressTasks= [NSMutableArray new];
    
    
    if ([[defaults objectForKey:@"TASKS_KEY"] mutableCopy] == nil) {
            _toDoTasks = [NSMutableArray new];
        } else {
            _toDoTasks = [[defaults objectForKey:@"TASKS_KEY"] mutableCopy];
        }
   
   isSearching=NO;
    [_searchBar setDelegate:self];
   // filteredList = [[NSMutableArray alloc] init];
 //  self.toDoTasks = [[defaults arrayForKey:@"TASKS_KEY"] mutableCopy];
    
   // printf("%s",[[_toDoTasks objectAtIndex:0] valueForKey:@"name_k"]);
}

-(void)viewWillAppear:(BOOL)animated{
  
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (isSearching) {
          return [filteredData count];
       }
       else {
            return [_toDoTasks count];

}

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_ID" forIndexPath:indexPath];
    
    
    // Configure the cell...
    //cell.textLabel.text=@"ammar";
    
    
    
    
    UIImageView*  priortyImg=[cell viewWithTag:1];
    UILabel*  nameLabel=[cell viewWithTag:2];
    UILabel* descLabel=[cell viewWithTag:3];
    UILabel* createdDateLabel=[cell viewWithTag:4];
    UILabel* createdDateLabelValue=[cell viewWithTag:5];
    UILabel* deadlineDateLabel=[cell viewWithTag:6];
    UILabel*  deadlineDateLabelValue=[cell viewWithTag:7];
    
    
    if(isSearching == YES){
        nameLabel.text=[filteredData objectAtIndex:indexPath.row] ;
    }else{
    nameLabel.text=[[_toDoTasks objectAtIndex:indexPath.row] valueForKey:@"name_k"];
    descLabel.text=[[_toDoTasks objectAtIndex:indexPath.row] valueForKey:@"desc_k"];
    createdDateLabel.text=@"created in:";
    createdDateLabelValue.text=[[_toDoTasks objectAtIndex:indexPath.row] valueForKey:@"CreateDate_k"];
   deadlineDateLabel.text= @"deadLine:";
deadlineDateLabelValue.text=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"deadLine_k"];
    
    //change tintcolor of image
    priortyImg.image = [priortyImg.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    tmpStr = [[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"priorty_k"];
    if ([tmpStr  isEqual:@"High"]) {
        [priortyImg setTintColor:[UIColor redColor]];
    }else if([tmpStr  isEqual:@"Low"]){
        [priortyImg setTintColor:[UIColor grayColor]];
    }
        tmpInndex=indexPath.row;
        [self showNotification] ;
        
    }
    
 // priortyImg.image=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"priortyImg_k"];
    
    /*
     priortyImg.image=[UIImage imageNamed:@"high"];
    // nameLabel.text=@"play";
     nameLabel.text=[defaults objectForKey:@"name_key"];
     descLabel.text=[defaults objectForKey:@"desc_key"];
     createdDateLabel.text=@"Description:";
     createdDateLabelValue.text=[defaults objectForKey:@"createdDate_key"];
     deadlineDateLabel.text=@"Deadline:";
     deadlineDateLabelValue.text=[defaults objectForKey:@"deadLine_key"];
     */
   // NSDictionary *itemDictionary = self.toDoTasks[indexPath.row];
   // NSString *name = itemDictionary[@"name_key"];
   // NSString *desc = itemDictionary[@"desc_key"];
    
   // priortyImg.image=[UIImage imageNamed:@"high"];
   // nameLabel.text=@"play";
  //  nameLabel.text=name;
   // descLabel.text=desc;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (IBAction)addNewTask:(id)sender {
    //go to next screen by push it to stack of navigation controller
    AddNewTaskViewController* addNewTaskVc=[self.storyboard instantiateViewControllerWithIdentifier:@"addNewTaskVcId"];
    
    //7
    [ addNewTaskVc setAddDelegateRef:self];
    
    [ self.navigationController pushViewController:addNewTaskVc animated:(YES)];
}


-(void)addNewTaskToDo:(NSMutableDictionary *)task{
   // [toDoTasks addObjectsFromArray:tasks];
   // _toDoTasks=tasks;
    [_toDoTasks addObject:task];
    [defaults setObject:_toDoTasks forKey:@"TASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
    //printf("%lu",(unsigned long)[_toDoTasks count]);
}
-(void)addNewTaskToInProgress:(NSMutableDictionary *)task{
    
// [_ProgressTasks addObject:task];
    
    NSArray *viewControllers = [self.tabBarController viewControllers];
            UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
            InProgressTableViewController *inProgressVc = [[myNavController childViewControllers] firstObject];
    //inProgressVc.inProgressTasks = _ProgressTasks;
    
   inProgressVc.inProgressDictionary=task;
    
   // inProgressVc.inProgressTasks=_ProgressTasks;
   // printf("%lu",(unsigned long)[_inProgressTasks count]);
}

-(void)editTaskToDo:(NSMutableDictionary *)task : (int )index{
    [_toDoTasks insertObject:task atIndex:index ];
    [defaults setObject:_toDoTasks forKey:@"TASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
}
-(void)editTaskInProgress:(NSMutableDictionary *)task :(int)index{
    //add it to inprogress
    NSArray *viewControllers = [self.tabBarController viewControllers];
            UINavigationController *myNavController = (UINavigationController *)viewControllers[2];
            InProgressTableViewController *inProgressVc = [[myNavController childViewControllers] firstObject];
   inProgressVc.inProgressDictionary=task;
    //remove it from to do
    [_toDoTasks removeObjectAtIndex:index];
    [defaults setObject:_toDoTasks forKey:@"TASKS_KEY"];
    [defaults synchronize];
    [self.tableView reloadData ];
}

//-(void)editTaskDone:(NSMutableDictionary *)task : (int )index{
//    //add it to done
//    NSArray *viewControllers = [self.tabBarController viewControllers];
//            UINavigationController *myNavController = (UINavigationController *)viewControllers[1];
//            DoneTableViewController *doneVc = [[myNavController childViewControllers] firstObject];
//    doneVc.doneDictionary=task;
//    //remove it from to do
//    [_toDoTasks removeObjectAtIndex:index];
//    [defaults setObject:_toDoTasks forKey:@"TASKS_KEY"];
//    [defaults synchronize];
//    [self.tableView reloadData ];
//}

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
        [_toDoTasks removeObjectAtIndex:indexPath.row];
        [defaults setObject:_toDoTasks forKey:@"TASKS_KEY"];
        [defaults synchronize];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
//handling click in cells
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //go to next screen by push it to stack of navigation controller
    EditInToDoViewController* EDVc=[self.storyboard instantiateViewControllerWithIdentifier:@"edit_id"];
    //7
    [ EDVc setEditTaskInToDoDelegateRef:self];
    
    EDVc.edName=[[_toDoTasks objectAtIndex:indexPath.row] valueForKey:@"name_k"];
    EDVc.edDis=[[_toDoTasks objectAtIndex:indexPath.row] valueForKey:@"desc_k"];
    EDVc.edPriorty=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"priorty_k"];
    EDVc.edDeadline=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"deadLine_k"];
    EDVc.CellInedex=indexPath.row;
    EDVc.labelCreatedin=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"CreateDate_k"];
    EDVc.edState=[[_toDoTasks objectAtIndex:indexPath.row]  valueForKey:@"state_k"];
  //  EDVc.edState
    [ self.navigationController pushViewController:EDVc animated:(YES)];
}

//searchBar

//- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
//
//    if (searchText.length == 0) {
//        isSearching = NO;
//            [self.searchBar endEditing:YES];
//    }else {
//            isSearching = YES;
//
//            filteredData = [[NSMutableArray alloc]init];
//
//         for (NSMutableDictionary *task in [defaults objectForKey:@"TASKS_KEY"]) {
//
//                NSRange range = [[task valueForKey:@"name_k"] rangeOfString:searchText options:NSCaseInsensitiveSearch];
//
//                if (range.location != NSNotFound) {
//
//                    [filteredData addObject:task];
//
//                }
//
//            }
//
//        }
//
//        [self.tableView reloadData];
//}

//
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {


       if (searchText.length != 0) {
           isSearching=YES;
           NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[cd] %@", searchText];


          // NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
           //    return [evaluatedObject containsString:searchText];
          // }];
        //   self->filteredData = [self->data filteredArrayUsingPredicate:predicate];
           
           self->filteredData = [[[[defaults objectForKey:@"TASKS_KEY"]mutableCopy]valueForKey:@"name_k"] filteredArrayUsingPredicate:predicate];
        //  NSString* str=[[filteredData objectAtIndex:0 ]valueForKey:@"name_k"];
          // NSLog(@"%@", self->filteredData);
        //   NSLog(@"%@", str);
       }
       else {
           isSearching=NO;
       //    self->filteredData = [[defaults objectForKey:@"TASKS_KEY"] mutableCopy] ;
       }

       [self.tableView reloadData];

}
-(void)createNotification{
    
    
    //You manage notifications through a shared UNUserNotificationCenter object
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    
    
    [center requestAuthorizationWithOptions:options
    completionHandler:^(BOOL granted, NSError * _Nullable error) {
   
        self->isGrantedNotificationAccess = granted;
    
    }];
    
    
    
    
    
}




-(void)showNotification{
    myData =[defaults objectForKey:@"TASKS_KEY"] ;
    NSString *dateString =[[myData objectAtIndex:tmpInndex]  valueForKey:@"deadLine_k"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
     [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
      NSDate *date = [dateFormatter dateFromString:dateString];
    
    if(isGrantedNotificationAccess){
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        content.title = @"Task Time";
        content.subtitle = @"do it now !!";
        content.body = @"This is Obj-C To Do App";
        content.sound = [UNNotificationSound defaultSound];
        
     
        
       // NSDate *date = [NSDate dateWithTimeIntervalSinceNow:10];
        
         NSDateComponents *triggerDate = [[NSCalendar currentCalendar]
                  components:NSCalendarUnitYear +
                  NSCalendarUnitMonth + NSCalendarUnitDay +
                  NSCalendarUnitHour + NSCalendarUnitMinute +
                  NSCalendarUnitSecond fromDate:date];
        
        
    //    UNTimeIntervalNotificationTrigger *trigger =        [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2                 repeats:NO];
        
        UNCalendarNotificationTrigger *trigger = [UNCalendarNotificationTrigger triggerWithDateMatchingComponents:triggerDate
                                             repeats:NO];
      UNNotificationRequest *request = [UNNotificationRequest                                                                                                    requestWithIdentifier:@"UYLLocalNotification" content:content trigger:trigger];

        // add notification for current notification centre
       [center addNotificationRequest:request withCompletionHandler:nil];
    }
}







/*
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
          if (searchBar.text.length != 0) {
             isSearching=YES;
             NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF contains[c] %@", searchBar.text];
    //
    //
    //          // NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
    //           //    return [evaluatedObject containsString:searchText];
    //          // }];
    //          self->filteredData = [self->data filteredArrayUsingPredicate:predicate];
          self->filteredData = [[[defaults objectForKey:@"TASKS_KEY"]mutableCopy] filteredArrayUsingPredicate:predicate];
    //        //  NSString* str=[[filteredData objectAtIndex:0 ]valueForKey:@"name_k"];
    //          // NSLog(@"%@", self->filteredData);
    //        //   NSLog(@"%@", str);
    //       }
          } else {
               isSearching=NO;
               self->filteredData = [[defaults objectForKey:@"TASKS_KEY"] mutableCopy] ;
           }
    //
          [self.tableView reloadData];
    //
    //}
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







@end
