//
//  ToDoListItemDetailViewController.m
//  ToDo
//
//  Created by Eric L Eisner on 3/23/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "ToDoListItemDetailViewController.h"
#import "ToDoListItem.h"

@interface ToDoListItemDetailViewController ()
@property(nonatomic, strong) NSDateFormatter* dateFormat;
@end

@implementation ToDoListItemDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.dateFormat = [[NSDateFormatter alloc] init];
    [self.dateFormat setDateFormat:@"MMMM d 'at' h:mm a"];
	UIView* topBar = [[UIView alloc] initWithFrame:CGRectMake(self.textTextView.frame.origin.x, self.textTextView.frame.origin.y, self.textTextView.frame.size.width, 1)];
    topBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:topBar];
    UIView* middleBar = [[UIView alloc] initWithFrame:CGRectMake(self.textTextView.frame.origin.x, self.textTextView.frame.origin.y + self.textTextView.frame.size.height,
                                                                 self.textTextView.frame.size.width, 1)];
    middleBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:middleBar];
    UIView* bottomBar = [[UIView alloc] initWithFrame:CGRectMake(self.textTextView.frame.origin.x, self.dateLabel.frame.origin.y + self.dateLabel.frame.size.height + 10,
                                                                 self.textTextView.frame.size.width, 1)];
    bottomBar.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:bottomBar];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationItem.title = self.item.title;
    self.titleTextField.text = self.item.title;
    
    if(self.item.text != nil) {
        self.textTextView.text = self.item.text;
        self.textTextView.textColor = [UIColor blackColor];
    }
    if(self.item.date != nil) {
        self.dateLabel.text = [self.dateFormat stringFromDate:self.item.date];
        self.dateLabel.textColor = [UIColor blackColor];
    }
        
    if(self.item.isCompleted) {
        self.completedSwitch.on = YES;
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    self.item.title = [NSMutableString stringWithString:self.titleTextField.text];
    
    if(![self.textTextView.text isEqualToString:@"Notes"]) {
        self.item.text = [NSMutableString stringWithString:self.textTextView.text];
    } else {
        self.item.text = nil;
    }
    
    if(![self.dateLabel.text isEqualToString:@"None"]) {
        self.item.date = [self.dateFormat dateFromString:self.dateLabel.text];
    } else {
        self.item.date = nil;
    }
    
    self.item.isCompleted = self.completedSwitch.isOn;
}

-(IBAction)screenTapped
{
    [self.view endEditing:YES];
    [self.clearDateButton setHidden:YES];
    [self setDateLabel];
}

-(IBAction)dateLabelTapped
{
    [self.view endEditing:YES];
    [self.clearDateButton setHidden:NO];
    [self.datePicker setHidden:NO];
    [self.dateLabel setTextColor:[UIColor blackColor]];
    [self.dateLabel setText:@""];
    
}

-(IBAction)clearDate
{
    [self.clearDateButton setHidden:YES];
    [self.datePicker setHidden:YES];
    [self.dateLabel setText:@"None"];
    [self.dateLabel setTextColor:[UIColor lightGrayColor]];
}

-(void)setDateLabel
{
    if([self.datePicker isHidden] == NO) {
        [self.clearDateButton setHidden:YES];
        [self.dateLabel setText:[self.dateFormat stringFromDate:self.datePicker.date]];
        [self.datePicker setHidden:YES];
    }
}

// UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self setDateLabel];
}

//UITextViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"Notes"]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    [self setDateLabel];
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@""]) {
        textView.text = @"Notes";
        textView.textColor = [UIColor lightGrayColor];
    }
}

@end
