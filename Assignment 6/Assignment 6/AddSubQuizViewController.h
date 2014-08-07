//
//  SecondViewController.h
//  Assignment 6
//
//  Created by Eric L Eisner on 3/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddSubQuizViewController : UIViewController <UITextFieldDelegate>

@property(nonatomic, strong) IBOutletCollection(UILabel) NSArray* questionLabels;
@property(nonatomic, strong) IBOutletCollection(UITextField) NSArray* answerTextFields;
@property(nonatomic, strong) IBOutletCollection(UIImageView) NSArray* correctionImages;
@property(nonatomic, weak) IBOutlet UIButton* button;

-(IBAction)buttonPressed;
-(IBAction)screenTapped;

@end
