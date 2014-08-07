//
//  ToDoListItemTableCell.h
//  ToDo
//
//  Created by Ryan Hardt on 3/7/14.
//  Copyright (c) 2014 Ryan Hardt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ToDoListItem;

@interface ToDoListItemTableViewCell : UITableViewCell<UITextFieldDelegate>

@property(nonatomic, weak) IBOutlet UITextField* titleTextField;
@property(nonatomic, weak) ToDoListItem* item;

@end
