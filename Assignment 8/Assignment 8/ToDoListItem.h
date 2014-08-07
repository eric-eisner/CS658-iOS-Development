//
//  ToDoListItem.h
//  ToDo
//
//  Created by Eric L Eisner on 3/23/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoListItem : NSObject

@property(nonatomic, strong) NSMutableString* title;
@property(nonatomic, strong) NSMutableString* text;
@property(nonatomic) BOOL isCompleted;
@property(nonatomic, strong) NSDate* date;

-(id)init;

@end
