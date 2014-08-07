//
//  main.m
//  Assignment 2
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BlankFiller.h"
#import "BurnGenerator.h"
#import "MadLibGenerator.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        BurnGenerator* bg = [[BurnGenerator alloc] init];
        NSString* line = [bg generate];
        NSLog(@"%@\n\n", line);
        
        line = [bg generate];
        NSLog(@"%@\n\n", line);
        
        line = [bg generate];
        NSLog(@"%@\n\n", line);
        
        MadLibGenerator* mlg = [[MadLibGenerator alloc] init];
        line = [mlg generate];
        NSLog(@"%@\n\n", line);
        
        line = [mlg generate];
        NSLog(@"%@\n\n", line);
        
        line = [mlg generate];
        NSLog(@"%@\n\n", line);
    }
    return 0;
}

