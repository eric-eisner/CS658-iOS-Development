//
//  RostersEditPlayerViewController.m
//  Rosters
//
//  Created by Eric L Eisner on 3/30/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "RostersAddEditPlayerViewController.h"
#import "BaseballPlayer.h"
#define PORTRAIT_KEYBOARD_HEIGHT (216)

@interface RostersAddEditPlayerViewController ()

@end

@implementation RostersAddEditPlayerViewController

@synthesize delegate;

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
	// Do any additional setup after loading the view.
    self.firstNameTextField.text = self.player.firstName;
    self.lastNameTextField.text = self.player.lastName;
    self.positionLabel.text = self.player.position;
    self.urlTextField.text = self.player.url;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel
{
    [[self delegate] cancelAddPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)done;
{
    
    self.player.firstName = self.firstNameTextField.text;
    self.player.lastName = self.lastNameTextField.text;
    self.player.url = self.urlTextField.text;
    [[self delegate] doneAddPlayer];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)screenTapped
{
    [self.view endEditing:YES];
}

-(void)moveView:(BOOL)moveUp
{
    int movement = moveUp?-100:100;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

#pragma mark - TextField Delegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.center.y > (self.view.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT - 8)) {
        [self moveView:YES];
    } else {
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.center.y > (self.view.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT - 8)) {
        [self moveView:NO];
    } else {
        
    }
}

@end
