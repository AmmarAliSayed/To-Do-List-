//
//  EditTaskToDoDelegate.h
//  To Do List Project
//
//  Created by Macbook on 02/03/2021.
//

#import <Foundation/Foundation.h>



@protocol EditTaskInToDoDelegate <NSObject>
-(void)editTaskToDo:(NSMutableDictionary *)task : (int )index;
-(void)editTaskInProgress:(NSMutableDictionary *)task : (int )index;
//-(void)editTaskDone:(NSMutableDictionary *)task : (int )index;
@end


