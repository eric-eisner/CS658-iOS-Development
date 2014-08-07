//
//  MultDivViewController.m
//  Assignment 6
//
//  Created by Eric L Eisner on 3/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "MultDivViewController.h"

@interface MultDivViewController ()
@property(nonatomic, strong) NSString* answer;
@property(nonatomic) BOOL isDivision;
@property(nonatomic) BOOL isQuestionDisplayed;
@property(nonatomic, strong) UIView* underlineDivView1;
@property(nonatomic, strong) UIView* underlineDivView2;
@property(nonatomic, strong) UIView* underlineMultView;
@end

@implementation MultDivViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	   
    // Division lines
    self.underlineDivView1 = [[UIView alloc] init];
    CGFloat xCoordinate = self.operand1Label.frame.origin.x + self.operatorLabel.frame.size.width;
    CGFloat yCoordinate = self.operand1Label.frame.origin.y + self.operand1Label.frame.size.height;
    CGFloat width = self.operand2Label.frame.size.width;
    self.underlineDivView1.frame = CGRectMake(xCoordinate, yCoordinate, width, 5);
    self.underlineDivView1.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.underlineDivView1];
    self.underlineDivView2 = [[UIView alloc] init];
    xCoordinate = self.operatorLabel.frame.origin.x + self.operatorLabel.frame.size.width;
    yCoordinate = self.operand1Label.frame.origin.y + self.operand1Label.frame.size.height;
    CGFloat height = self.operand2Label.frame.size.height;
    self.underlineDivView2.frame = CGRectMake(xCoordinate, yCoordinate, 5, height);
    self.underlineDivView2.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.underlineDivView2];
    self.underlineDivView1.hidden = YES;
    self.underlineDivView2.hidden = YES;
    
    // Multiplication Equals Line
    self.underlineMultView = [[UIView alloc] init];
    xCoordinate = self.operatorLabel.frame.origin.x;
    yCoordinate = self.operatorLabel.frame.origin.y + self.operatorLabel.frame.size.height;
    width = self.operatorLabel.frame.size.width + self.operand2Label.frame.size.width;
    self.underlineMultView.frame = CGRectMake(xCoordinate, yCoordinate, width, 5);
    self.underlineMultView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.underlineMultView];
    self.underlineMultView.hidden = YES;
    
    [self generateEquation];
    self.isQuestionDisplayed = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)screenTapped
{
    if(self.isQuestionDisplayed) {
        if(self.isDivision) {
            [self.operand1Label setText:self.answer];
        } else {
            [self.answerLabel setText:self.answer];
        }
        self.isQuestionDisplayed = NO;
    } else {
        if(self.isDivision) {
            self.underlineDivView1.hidden = YES;
            self.underlineDivView2.hidden = YES;
        } else {
            self.underlineMultView.hidden = YES;
        }
        [self generateEquation];
        self.isQuestionDisplayed = YES;
    }
}

-(void)generateEquation
{
    // Randomize the operator
    int operation = arc4random_uniform(2);
    (operation==0)?[self generateMult]:[self generateDiv];
}

-(void)generateMult
{
    self.isDivision = NO;
    int operand1 = arc4random_uniform(9) + 1;
    int operand2 = arc4random_uniform(9) + 1;
    
    self.answer = [NSString stringWithFormat:@"%i", (operand1*operand2)];
    
    [self.operand1Label setText:[NSString stringWithFormat:@"%i", operand1]];
    [self.operand2Label setText:[NSString stringWithFormat:@"%i", operand2]];
    [self.operatorLabel setText:@"x"];
    [self.answerLabel setText:@""];
    self.underlineMultView.hidden = NO;
}

-(void)generateDiv
{
    self.isDivision = YES;
    int divisor;
    int dividend;
    do {
        divisor = arc4random_uniform(9) + 1;
        dividend = arc4random_uniform(99) + 1;
    } while ((dividend%divisor)!=0);
    
    self.answer = [NSString stringWithFormat:@"%i", (dividend/divisor)];
    
    [self.operand1Label setText:@""];
    [self.operand2Label setText:[NSString stringWithFormat:@"%i", dividend]];
    [self.operatorLabel setText:[NSString stringWithFormat:@"%i", divisor]];
    [self.answerLabel setText:@""];
    self.underlineDivView1.hidden = NO;
    self.underlineDivView2.hidden = NO;
}

@end
