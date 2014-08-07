//
//  MadLibGenerator.m
//  Assignment 2
//
//  Created by Eric L Eisner on 2/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "MadLibGenerator.h"

@implementation MadLibGenerator

-(id)init
{
    self = [super init];
    if(self) {
        [self readMadLibTemplates];
    }
    return self;
}

-(void)readMadLibTemplates
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"madLibTemplateList" ofType:@"txt"];
    NSError* error;
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"%@", [error localizedFailureReason]);
        return;
    }
    
    NSArray* fileLines = [fileContents componentsSeparatedByString:@"\n\n"];
    WordTemplate* temp;
    NSString* newFileLine;
    for(NSString* fileLine in fileLines) {
        newFileLine = [fileLine stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
        temp = [[WordTemplate alloc] initWithTemplate:newFileLine];
        [[self templates] addObject:temp];
    }
}

@end
