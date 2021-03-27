//
//  EditTaskInProgressDelegate.h
//  To Do List Project
//
//  Created by Macbook on 06/03/2021.
//

#import <Foundation/Foundation.h>



@protocol EditTaskInProgressDelegate <NSObject>

-(void)editTaskInProgress:(NSMutableDictionary *)task : (int )index;
-(void)editTaskDone:(NSMutableDictionary *)task : (int )index;

@end


