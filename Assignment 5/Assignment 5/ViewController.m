//
//  ViewController.m
//  Assignment 5
//
//  Created by Eric L Eisner on 2/25/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_topText setHidden:true];
    [_bottomText setHidden:true];
    
    UIFont* font = [UIFont fontWithName:@"impact" size:18];
    
    self.topText.font = font;
    self.topText.textColor = [UIColor whiteColor];
    self.topText.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.topText.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.topText.layer.shadowOpacity = 1.0f;
    self.topText.layer.shadowRadius = 2.0f;
    self.bottomText.font = font;
    self.bottomText.textColor = [UIColor whiteColor];
    self.bottomText.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.bottomText.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
    self.bottomText.layer.shadowOpacity = 1.0f;
    self.bottomText.layer.shadowRadius = 2.0f;
    
    self.topText.delegate = self;
    self.bottomText.delegate = self;

}

-(void)viewDidAppear:(BOOL)animated
{
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Respond to gestures
-(IBAction)imageTapped:(id)sender
{
    if(_isEditing) {
        [self.view endEditing:true];
    } else {
        UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
        imagePicker.delegate = self;
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
        } else {
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        
        [self presentViewController:imagePicker animated:YES completion:nil];
    }
}

-(IBAction)textDragged:(id)sender
{
    CGPoint amount = [(UIPanGestureRecognizer*) sender translationInView:self.view];
    if(_topText == [sender view]) {
        [_topText setCenter:CGPointMake(_topText.center.x, _topText.center.y + amount.y)];
    } else {
        [_bottomText setCenter:CGPointMake(_bottomText.center.x, _bottomText.center.y + amount.y)];
    }
    [(UIPanGestureRecognizer*) sender setTranslation:CGPointZero inView:[sender view]];
}

// ImagePicker Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage* image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.topText.hidden = false;
    self.bottomText.hidden = false;
    self.imageView.image = image;
    [self dismissViewControllerAnimated:YES completion:nil];
}

// UITextView Delegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    _isEditing = true;
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
        if(textView.center.y >= self.view.bounds.size.height - 216) {
            [UIView beginAnimations:nil context: nil];
            [UIView setAnimationDuration: 0.3];
            self.view.frame = CGRectOffset(self.view.frame,0,-216);
            [UIView commitAnimations];
        }
    } else {
        if(textView.center.y >= 162) {
            [UIView beginAnimations:nil context: nil];
            [UIView setAnimationDuration: 0.3];
            self.view.frame = CGRectOffset(self.view.frame,+162,0);
            [UIView commitAnimations];
        }
    }
}

-(void)textViewDidEndEditing:(UITextView *)textView
{
    _isEditing = false;
    if([[UIApplication sharedApplication] statusBarOrientation] == UIInterfaceOrientationPortrait) {
        if(textView.center.y >= self.view.bounds.size.height - 216) {
            [UIView beginAnimations:nil context: nil];
            [UIView setAnimationDuration: 0.3];
            self.view.frame = CGRectOffset(self.view.frame,0,+216);
            [UIView commitAnimations];
        }
    } else {
        if(textView.center.y >= 162) {
            [UIView beginAnimations:nil context: nil];
            [UIView setAnimationDuration: 0.3];
            self.view.frame = CGRectOffset(self.view.frame,-162,0);
            [UIView commitAnimations];
        }
    }
    [textView autoresizesSubviews];
    [textView updateConstraints];
}

@end
