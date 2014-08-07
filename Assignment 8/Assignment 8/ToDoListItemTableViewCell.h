//
//  ToDoListItemTableViewCell.h
//  ToDo
//
//  Created by Eric L Eisner on 3/23/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToDoListItem;

@interface ToDoListItemTableViewCell : UITableViewCell <UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField* titleTextField;
@property(nonatomic, weak) ToDoListItem* item;

@end
