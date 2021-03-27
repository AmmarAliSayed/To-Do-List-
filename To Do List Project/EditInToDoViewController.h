//
//  EditViewController.h
//  To Do List Project
//
//  Created by Macbook on 27/02/2021.
//

#import <UIKit/UIKit.h>

#import "Task.h"
#import "EditTaskInToDoDelegate.h"
@interface EditInToDoViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property id <EditTaskInToDoDelegate> editTaskInToDoDelegateRef;
@property int CellInedex;
@property  NSString* edName;
@property NSString* edDis;
@property NSString* edPriorty;
@property NSString* edDeadline;
@property NSString* edState;
@property NSString* labelCreatedin;
@end


