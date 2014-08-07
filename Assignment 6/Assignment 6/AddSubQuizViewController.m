//
//  SecondViewController.m
//  Assignment 6
//
//  Created by Eric L Eisner on 3/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "AddSubQuizViewController.h"
#define PORTRAIT_KEYBOARD_HEIGHT (216)

@interface AddSubQuizViewController ()
@property(nonatomic, strong) NSMutableArray* answers;
@property(nonatomic, strong) UIImage* correctImage;
@property(nonatomic, strong) UIImage* incorrectImage;
@end

@implementation AddSubQuizViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.answers = [[NSMutableArray alloc] init];
    
    NSString* correctImagePath = [[NSBundle mainBundle] pathForResource:@"correct" ofType:@"jpg"];
	NSString* incorrectImagePath = [[NSBundle mainBundle] pathForResource:@"incorrect" ofType:@"jpg"];
    self.correctImage = [[UIImage alloc] initWithContentsOfFile:correctImagePath];
    self.incorrectImage = [[UIImage alloc] initWithContentsOfFile:incorrectImagePath];
    
    [self generateQuiz];
    
    for(UITextField* textField in self.answerTextFields) {
        textField.delegate = self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)buttonPressed
{
    if([self.button.currentTitle isEqualToString:@"New Quiz"]) {
        [self.answers removeAllObjects];
        [self generateQuiz];
        //remove images
        for(UIImageView* correctnessImage in self.correctionImages) {
            [correctnessImage setImage:nil];
        }
        for(UITextField* answerTextField in self.answerTextFields) {
            [answerTextField setText:@""];
        }
        [self.button setTitle:@"Submit Answers" forState:UIControlStateNormal];
    } else {
        for(int i=0; i<self.answers.count; ++i) {
            if([[self.answerTextFields[i] text] isEqualToString:self.answers[i]]) {
                //correct
                [self.correctionImages[i] setImage:self.correctImage];
            } else {
                //incorrect
                [self.correctionImages[i] setImage:self.incorrectImage];
            }
        }
        [self.button setTitle:@"New Quiz" forState:UIControlStateNormal];
    }
}

-(IBAction)screenTapped
{
    [self.view endEditing:YES];
}

-(void)generateQuiz
{
    for(UILabel* questionLabel in self.questionLabels) {
        int operand1 = arc4random_uniform(99) + 1;
        int operand2 = arc4random_uniform(99) + 1;
        int operation = arc4random_uniform(2);
        NSString* operator = (operation==0)?@"+":@"-";
        [questionLabel setText:[NSString stringWithFormat:@"%i %@ %i\t=", operand1, operator, operand2]];
        [self.answers addObject:[NSString stringWithFormat:@"%i", (operation==0)?(operand1+operand2):(operand1-operand2)]];
    }
}

// TextFieldDelegate
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if(textField.center.y > (self.view.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT - 3)) {
        [self moveView:YES];
    } else {
        
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if(textField.center.y > (self.view.bounds.size.height - PORTRAIT_KEYBOARD_HEIGHT - 3)) {
        [self moveView:NO];
    } else {
        
    }
}

-(void)moveView:(BOOL)moveUp
{
    int movement = moveUp?-PORTRAIT_KEYBOARD_HEIGHT:PORTRAIT_KEYBOARD_HEIGHT;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3];
    self.view.frame = CGRectOffset(self.view.frame, 0, movement);
    [UIView commitAnimations];
}

@end

