//
//  ToDoListItem.m
//  ToDo
//
//  Created by Eric L Eisner on 3/23/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "ToDoListItem.h"

@implementation ToDoListItem

-(id)init
{
    self = [super init];
    if(self) {
        _title = [NSMutableString stringWithString:@"New ToDo Item"];
        _isCompleted = NO;
    }
    return self;
}

@end
