//
//  ToDoListItemDetailViewController.h
//  ToDo
//
//  Created by Eric L Eisner on 3/23/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class  ToDoListItem;

@interface ToDoListItemDetailViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate>

@property(nonatomic, weak) IBOutlet UITextField* titleTextField;
@property(nonatomic, weak) IBOutlet UITextView* textTextView;
@property(nonatomic, weak) IBOutlet UISwitch* completedSwitch;
@property(nonatomic, weak) IBOutlet UIDatePicker* datePicker;
@property(nonatomic, weak) IBOutlet UILabel* dateLabel;
@property(nonatomic, weak) IBOutlet UIButton* clearDateButton;
@property(nonatomic, weak) ToDoListItem* item;

-(IBAction)screenTapped;
-(IBAction)dateLabelTapped;
-(IBAction)clearDate;

@end
