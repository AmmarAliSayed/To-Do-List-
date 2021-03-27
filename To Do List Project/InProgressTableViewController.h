//
//  InProgressTableViewController.h
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import <UIKit/UIKit.h>
#import "EditInProgressViewController.h"
//#import "EditTaskInToDoDelegate.h"
#import "DoneTableViewController.h"
@interface InProgressTableViewController : UITableViewController <EditTaskInProgressDelegate>
@property NSMutableArray <NSMutableDictionary *>*inProgressTasks;
@property NSMutableDictionary* inProgressDictionary;

@end


