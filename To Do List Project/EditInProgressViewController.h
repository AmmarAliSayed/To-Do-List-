//
//  EditInProgressViewController.h
//  To Do List Project
//
//  Created by Macbook on 06/03/2021.
//

#import <UIKit/UIKit.h>


#import "Task.h"
#import "EditTaskInProgressDelegate.h"

@interface EditInProgressViewController : UIViewController <UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate>
@property id <EditTaskInProgressDelegate> editTaskInProgressDelegateRef;
@property int CellInedex;
@property  NSString* edName;
@property NSString* edDis;
@property NSString* edPriorty;
@property NSString* edDeadline;
@property NSString* edState;
@property NSString* labelCreatedin;
@end


