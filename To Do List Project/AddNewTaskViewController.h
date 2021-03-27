//
//  ViewController.h
//  To Do List Project
//
//  Created by Macbook on 24/02/2021.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Task.h"
#import "InProgressTableViewController.h"
#import "AddTaskDelegate.h"
//#import "AddTaskInProgressDelegate.h"
@interface AddNewTaskViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>

@property id <AddTaskDelegate> addDelegateRef;
//@property id <AddTaskInProgressDelegate> inProgressDelegateRef;
@property NSMutableArray *tasks;
@end

