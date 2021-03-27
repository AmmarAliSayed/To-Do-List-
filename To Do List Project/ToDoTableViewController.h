//
//  ToDoTableViewController.h
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import <UIKit/UIKit.h>

#import "AddTaskDelegate.h"
#import "EditTaskInToDoDelegate.h"
#import "InProgressTableViewController.h"
#import "DoneTableViewController.h"
#import <UserNotifications/UserNotifications.h>
@interface ToDoTableViewController : UITableViewController <AddTaskDelegate,EditTaskInToDoDelegate,UISearchBarDelegate>
@property NSMutableArray <NSMutableDictionary *>*toDoTasks;
@property NSMutableArray <NSMutableDictionary *>*ProgressTasks;
@end


