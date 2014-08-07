//
//  BlankFiller.h
//  Assignment 2
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Word.h"
#import "WordTemplate.h"

@interface BlankFiller : NSObject

@property(nonatomic, strong) NSMutableArray* nouns;
@property(nonatomic, strong) NSMutableArray* verbs;
@property(nonatomic, strong) NSMutableArray* adjectives;
@property(nonatomic, strong) NSMutableArray* adverbs;
@property(nonatomic, strong) NSMutableArray* interjections;
@property(nonatomic, strong) NSMutableArray* templates;

-(id)init;
-(void)readWords;
-(void)addWord:(Word*)word;
-(Word*)getWordWithPartOfSpeech:(PartOfSpeech)partOfSpeech;
-(NSString*)generate;

@end
