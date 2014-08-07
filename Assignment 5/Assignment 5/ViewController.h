//
//  ViewController.h
//  Assignment 5
//
//  Created by Eric L Eisner on 2/25/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate>

@property(nonatomic, weak) IBOutlet UIImageView* imageView;
@property(nonatomic, weak) IBOutlet UITextView* topText;
@property(nonatomic, weak) IBOutlet UITextView* bottomText;
@property(nonatomic) BOOL isEditing;

@end
