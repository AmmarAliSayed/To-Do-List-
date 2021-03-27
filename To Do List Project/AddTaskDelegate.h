//
//  AddTaskDelegate.h
//  To Do List Project
//
//  Created by Macbook on 28/02/2021.
//

#import <Foundation/Foundation.h>

#import "Task.h"

@protocol AddTaskDelegate <NSObject>

-(void)addNewTaskToDo:(NSMutableDictionary *)task;
-(void)addNewTaskToInProgress:(NSMutableDictionary *)task;
@end

