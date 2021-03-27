//
//  Task.h
//  To Do List Project
//
//  Created by Macbook on 25/02/2021.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
//@interface Task : NSObject <NSCoding>
@interface Task : NSObject 
@property NSString* name;
@property NSString* desc;
@property NSString* priorty;//high-mid-low
//@property NSString* img;
@property NSString* CreateDate;
@property NSString* deadLine;
@property NSString* state; //todo-inProgress-done

@end


