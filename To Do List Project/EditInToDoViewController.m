//
//  EditViewController.m
//  To Do List Project
//
//  Created by Macbook on 27/02/2021.
//

#import "EditInToDoViewController.h"

@interface EditInToDoViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label_createdIn;

@property (weak, nonatomic) IBOutlet UITextField *tf_name;

@property (weak, nonatomic) IBOutlet UITextField *tf_desc;
@property (weak, nonatomic) IBOutlet UITextField *tf_priorty;
@property (weak, nonatomic) IBOutlet UITextField *tf_deadline;
@property (weak, nonatomic) IBOutlet UITextField *tf_state;
@end

@implementation EditInToDoViewController{
    NSArray *priortyArr;
    NSArray* stateArr;
    UIDatePicker *datePicker;
    Task* task;
    NSMutableDictionary *dict;
    int pickerIndex;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    dict=[NSMutableDictionary new];
    
    [self createEditBtn];
    [self buildPriortyPicker];
    [self buildStatePicker];
    [self createDatePicker];
    [self createToolBarAbovePriortypickerView];
    [self createToolBarAboveStatepickerView];
    _tf_name.text=_edName;
    _tf_desc.text=_edDis;
    _tf_priorty.text=_edPriorty;
    _tf_state.text=_edState;
    _tf_deadline.text=_edDeadline;
    _label_createdIn.text=_labelCreatedin;
    _tf_state.text=_edState;
}





-(void)createEditBtn{
    //create btn save in the toolbar in runtime after ui is loaded
    //and put it in the right of the screen
    UIBarButtonItem* saveBarBtn=[[ UIBarButtonItem alloc] initWithTitle:(@"Edit") style:UIBarButtonItemStylePlain target:self action:@selector(showAlert)];
    
    [self.navigationItem setRightBarButtonItem:saveBarBtn];
    
}


-(void)showAlert{
    //create Obj Alert Controller
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Edit" message:@"Are  you want to save?" preferredStyle:UIAlertControllerStyleAlert];
    
    // create buttons  AlertAction
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        
        [self editFun];
        
      }];

      
      //add buttons on alert
          [alert addAction:no];
          [alert addAction:yes];
    // show Alert
    [self presentViewController:alert animated:YES completion:nil ];
}

//edit task
-(void)editFun{
    task=[Task new];
    task.name=[_tf_name text];
    task.desc=_tf_desc.text;
    //task.CreateDate=[self formatDate:[NSDate date]];
    task.deadLine=_tf_deadline.text;
    task.priorty=_tf_priorty.text;
    task.state=_tf_state.text;
    task.CreateDate=_label_createdIn.text;
    dict = @{@"name_k" : task.name, @"desc_k": task.desc,@"deadLine_k": task.deadLine,@"priorty_k": task.priorty,@"CreateDate_k": task.CreateDate};
    if([task.state  isEqual: @"to do"]){
        [_editTaskInToDoDelegateRef editTaskToDo:dict:_CellInedex];
    }else if ([task.state  isEqual: @"in progress"]){
        [_editTaskInToDoDelegateRef editTaskInProgress:dict:_CellInedex];
    }
        
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
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
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}






  - (void)createToolBarAbovePriortypickerView{
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
