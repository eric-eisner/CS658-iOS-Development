//
//  BurnGenerator.m
//  Assignment 2
//
//  Created by Eric L Eisner on 2/4/14.
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "BurnGenerator.h"

@implementation BurnGenerator

-(id)init
{
    self = [super init];
    if(self) {
        [self readBurnTemplates];
    }
    return self;
}

-(void)readBurnTemplates
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"burnTemplateList" ofType:@"txt"];
    NSError* error;
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"%@", [error localizedFailureReason]);
        return;
    }
    
    NSArray* fileLines = [fileContents componentsSeparatedByString:@"\n"];
    WordTemplate* temp;
    for(NSString* fileLine in fileLines) {
        temp = [[WordTemplate alloc] initWithTemplate:fileLine];
        [[self templates] addObject:temp];
    }
}

@end
