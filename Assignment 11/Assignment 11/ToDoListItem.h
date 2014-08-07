//
//  ToDoListItem.h
//  Assignment 11
//
//  Created by Eric L Eisner on 4/15/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ToDoListItem : NSManagedObject

@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * isCompleted;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * title;

@end
