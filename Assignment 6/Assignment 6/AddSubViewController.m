//
//  FirstViewController.m
//  Assignment 6
//
//  Created by Eric L Eisner on 3/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "AddSubViewController.h"

@interface AddSubViewController ()
@property(nonatomic, strong) NSString* answer;
@property(nonatomic) BOOL isQuestionDisplayed;
@end

@implementation AddSubViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	[self generateEquation];
    self.isQuestionDisplayed = YES;
    
    UIView* underlineView = [[UIView alloc] init];
    CGFloat xCoordinate = self.operatorLabel.frame.origin.x;
    CGFloat yCoordinate = self.operatorLabel.frame.origin.y + self.operatorLabel.frame.size.height;
    CGFloat width = self.operatorLabel.frame.size.width + self.operand2Label.frame.size.width;
    underlineView.frame = CGRectMake(xCoordinate, yCoordinate, width, 5);
    underlineView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:underlineView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)screenTapped
{
    if(self.isQuestionDisplayed) {
        [self.answerLabel setText:self.answer];
        self.isQuestionDisplayed = NO;
    } else {
        [self generateEquation];
        self.isQuestionDisplayed = YES;
    }
}

-(void)generateEquation
{
    int operand1 = arc4random_uniform(99) + 1;
    int operand2 = arc4random_uniform(99) + 1;
    int operation = arc4random_uniform(2);
    NSString* operator = (operation==0)?@"+":@"-";
    self.answer = [NSString stringWithFormat:@"%i", (operation==0)?(operand1+operand2):(operand1-operand2)];
    
    [self.operand1Label setText:[NSString stringWithFormat:@"%i", operand1]];
    [self.operand2Label setText:[NSString stringWithFormat:@"%i", operand2]];
    [self.operatorLabel setText:operator];
    [self.answerLabel setText:@""];
}

@end
