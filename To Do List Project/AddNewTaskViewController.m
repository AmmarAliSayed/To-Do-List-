//
//  ViewController.m
//  To Do List Project
//
//  Created by Macbook on 24/02/2021.
//

#import "AddNewTaskViewController.h"

@interface AddNewTaskViewController ()

@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@property (weak, nonatomic) IBOutlet UITextField *tf_desc;
@property (weak, nonatomic) IBOutlet UITextField *tf_priorty;
@property (weak, nonatomic) IBOutlet UITextField *tf_deadline;
@property (weak, nonatomic) IBOutlet UITextField *tf_state;

@end

@implementation AddNewTaskViewController{
    NSArray *priortyArr;
    NSArray* stateArr;
    int pickerIndex;
   // InProgressTableViewController* inProgVC;
   // NSMutableArray *namesArr;
  //  NSMutableArray *descArr;
  //  NSMutableArray *currentDateArr;
  //  NSMutableArray *deadLineArr;
  //  NSMutableArray *prorityImagArr;
    UIDatePicker *datePicker;
    Task* task;
    //int counter;
    
  //  NSUserDefaults *defaults ;
   NSMutableDictionary *dict;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  //  defaults = [NSUserDefaults standardUserDefaults];
  //  _tasks=[NSMutableArray new];
   dict=[NSMutableDictionary new];
    // _tasks = [[defaults arrayForKey:@"TASKS_KEY"] mutableCopy];
    
    [self createSaveBtn];
    [self buildPriortyPicker];
    [self buildStatePicker];
    [self createDatePicker];
    [self createToolBarAboveStatepickerView];
    [self createToolBarAbovePriortypickerView];
     // inProgVC=[self.storyboard instantiateViewControllerWithIdentifier:@"addNewTaskVcId"];
       //7
   // [ inProgVC setInProgressDelegateRef:self];
    
    
   // _tasks=[NSMutableArray new];
    // Do any additional setup after loading the view.
   // task=[Task new];
  
    
    
   
    /*
     //get the path
     NSString *filePath = [[NSBundle mainBundle] pathForResource:@"Property List" ofType:@"plist"];
     //get the content of file and save it in dictionary
    NSMutableDictionary *plistdict = [NSMutableDictionary dictionaryWithContentsOfFile:filePath];
     
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
     NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
     NSString *docfilePath = [basePath stringByAppendingPathComponent:@"Property List.plist"];
     
     [plistdict setObject:task.name forKey:@"names"];
     
     [plistdict writeToFile:docfilePath atomically:YES];
     */
   
  
    
    
    
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)saveFun {
    task=[Task new];
    task.name=[_tf_name text];
    task.desc=_tf_desc.text;
    task.CreateDate=[self formatDate:[NSDate date]];
    task.deadLine=_tf_deadline.text;
    task.priorty=_tf_priorty.text;
    task.state=_tf_state.text;
    
    dict = @{@"name_k" : task.name, @"desc_k": task.desc,@"CreateDate_k": task.CreateDate,@"deadLine_k": task.deadLine,@"priorty_k": task.priorty,@"state_k": task.state};
    
    
     if ([task.state  isEqual: @"to do"]) {
         [_addDelegateRef addNewTaskToDo:dict];
         
     } else if ([task.state  isEqual: @"in progress"]) {
         [_addDelegateRef addNewTaskToInProgress:dict];
         //[self.navigationController poo];
     }
     
    [self.navigationController popViewControllerAnimated:YES];
   
    
  
   
    
    
    
//    [defaults setObject:_tasks forKey:@"TASKS_KEY"];
   // [_tasks addObject:dict];
   // [defaults synchronize];
    
   // [tasks addObject:@{@"name_key": task.name ,
    //                           @"desc_key": task.desc,
    //                           }];
    //
    //    [defaults setObject:tasks forKey:@"TASKS_KEY"];
    //    [defaults synchronize];
          //  [defaults setObject: task.name forKey:@"name_key"];
          //  [defaults setObject: task.desc forKey:@"desc_key"];
          //  [defaults setObject: task.priorty forKey:@"priorty_key"];
           // [defaults setObject: task.CreateDate forKey:@"CreateDate_key"];
           // [defaults setObject: task.deadLine forKey:@"deadLine_key"];
          //  [defaults setObject: task.state forKey:@"state_key"];
        //img
    
    
    
    
    
    
    
    
    
    
    
    /*
     NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
            NSString *documentsPath = [paths objectAtIndex:0];
            NSString *plistPath = [documentsPath stringByAppendingPathComponent:@"Property List.plist"];

            [namesArr addObject:[task name]];
          [descArr addObject:[task desc]];
          [currentDateArr addObject:[task CreateDate]];
          [deadLineArr addObject:[task deadLine]];
          [prorityImagArr addObject:[task img]];
      
      //[namesArr insertObject:_tf_name.text atIndex:counter];
         //[descArr insertObject:_tf_desc.text atIndex:counter];
      
           // NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: namesArr, descArr,currentDateArr,deadLineArr,prorityImagArr, nil] forKeys:[NSArray arrayWithObjects: @"names", @"description",@"created date" ,@"deadline" ,@"images" ,nil]];
      NSDictionary *plistDict = [[NSDictionary alloc] initWithObjects: [NSArray arrayWithObjects: namesArr, descArr,currentDateArr, deadLineArr,nil] forKeys:[NSArray arrayWithObjects: @"names", @"description",@"created date",@"deadline",nil]];
            NSError *error = nil;
           NSData *plistData = [NSPropertyListSerialization dataFromPropertyList:plistDict format:NSPropertyListXMLFormat_v1_0 errorDescription:&error];

             if(plistData)
             {
                 [plistData writeToFile:plistPath atomically:YES];
                 printf("Data saved sucessfully");
                 //counter++;
                 //printf("%i",counter);
             }
             else
             {
                 printf("error !!!!!!");
             }
     */
  
       
    
    
    
    
    
 //   [_tasks addObject:task];
  //  if ([task.state  isEqual: @"to do"]) {
      //  [_toDoDelegateRef addNewTaskToDo:task];
   // }else if ([task.state  isEqual: @"in progress"]) {
       //[_inProgressDelegateRef addNewTaskToInProgress:task];
  //  }
   
    
    
    //printf("%s",[task.deadLine UTF8String]);
    
   
//
//    [tasks addObject:@{@"name_key": task.name ,
//                           @"desc_key": task.desc,
//                           }];
//
//    [defaults setObject:tasks forKey:@"TASKS_KEY"];
//    [defaults synchronize];
      //  [defaults setObject: task.name forKey:@"name_key"];
      //  [defaults setObject: task.desc forKey:@"desc_key"];
      //  [defaults setObject: task.priorty forKey:@"priorty_key"];
       // [defaults setObject: task.CreateDate forKey:@"CreateDate_key"];
       // [defaults setObject: task.deadLine forKey:@"deadLine_key"];
      //  [defaults setObject: task.state forKey:@"state_key"];
    //img
       
    //go to frist screen by pop second scrren from stack
   
}
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return  1;
}

- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if(pickerView.tag == 1){
        return  [priortyArr count];
    }else{
        return  [stateArr count];
    }
   
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if(pickerView.tag == 1){
        return  [priortyArr objectAtIndex:row];
    }else{
        return  [stateArr objectAtIndex:row];
    }
   
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(pickerView.tag == 1){
        _tf_priorty.text=[priortyArr objectAtIndex:row];
        pickerIndex=row;
    }else{
        _tf_state.text=[stateArr objectAtIndex:row];
        pickerIndex=row;
    }
    
}
- (void) buildPriortyPicker{
    priortyArr = @[@"High", @"Mid", @"Low"];
    UIPickerView* priortyPicker = [UIPickerView new] ;
        [priortyPicker  setDataSource: self];
        [priortyPicker  setDelegate: self];
        self.tf_priorty.inputView = priortyPicker ;
    priortyPicker.tag=1;
    
}

- (void) buildStatePicker{
    stateArr = @[ @"to do", @"in progress"];
    UIPickerView* statePicker = [UIPickerView new] ;
        [statePicker  setDataSource: self];
        [statePicker  setDelegate: self];
        self.tf_state.inputView = statePicker ;
    statePicker.tag=2;
    
}

-(void)createSaveBtn{
    //create btn save in the toolbar in runtime after ui is loaded
    //and put it in the right of the screen
    UIBarButtonItem* saveBarBtn=[[ UIBarButtonItem alloc] initWithTitle:(@"Save") style:UIBarButtonItemStylePlain target:self action:@selector(saveFun)];
    
    [self.navigationItem setRightBarButtonItem:saveBarBtn];
    
}
-(void)createDatePicker{
    
   datePicker=[UIDatePicker new];
   
    // make the textfield its own delegate
    self.tf_deadline.delegate = self;

    // set the mode
    [datePicker setDatePickerMode:UIDatePickerModeDate];
    
    // update the textfield with the date everytime it changes with selector defined below
   [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];

    // and finally set the datePicker as the input mode of your textfield
    [self.tf_deadline setInputView:datePicker];

    
}

-(void)updateTextField:(id)sender {
    UIDatePicker *picker = (UIDatePicker*)self.tf_deadline.inputView;
    self.tf_deadline.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}
-(void)createToolBarAbovePriortypickerView{
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
        style:UIBarButtonItemStylePlain target:self action:@selector(closePriortyPicker)];
    toolBar.items = @[barButtonDone];
    //barButtonDone.tintColor=[UIColor blackColor];
   // [pickerView addSubview:toolBar];
    _tf_priorty.inputAccessoryView = toolBar;
}

-(void)closePriortyPicker{
    _tf_priorty.text=[priortyArr objectAtIndex:pickerIndex ];
    [self.view endEditing:YES];
   
}


-(void)createToolBarAboveStatepickerView{
    UIToolbar *toolBar= [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    [toolBar setBarStyle:UIBarStyleDefault];
    UIBarButtonItem *barButtonDone = [[UIBarButtonItem alloc] initWithTitle:@"Done"
        style:UIBarButtonItemStylePlain target:self action:@selector(closeStatePicker)];
    toolBar.items = @[barButtonDone];
    //barButtonDone.tintColor=[UIColor blackColor];
   // [pickerView addSubview:toolBar];
    _tf_state.inputAccessoryView = toolBar;
}

-(void)closeStatePicker{
    _tf_state.text=[stateArr objectAtIndex:pickerIndex ];
    [self.view endEditing:YES];
   
}

@end
