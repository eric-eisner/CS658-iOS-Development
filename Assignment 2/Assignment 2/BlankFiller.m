//
//  BlankFiller.m
//  Assignment 2
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import "BlankFiller.h"

@implementation BlankFiller

-(id)init
{
    self = [super init];
    if(self) {
        _nouns = [[NSMutableArray alloc] init];
        _verbs = [[NSMutableArray alloc] init];
        _adjectives = [[NSMutableArray alloc] init];
        _adverbs = [[NSMutableArray alloc] init];
        _interjections = [[NSMutableArray alloc] init];
        _templates = [[NSMutableArray alloc] init];
        [self readWords];
    }
    return self;
}

-(void)readWords
{
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"wordList" ofType:@"txt"];
    NSError* error;
    NSString* fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
    
    if(error) {
        NSLog(@"%@", [error localizedFailureReason]);
        return;
    }
    
    NSArray* fileLines = [fileContents componentsSeparatedByString:@"\n"];
    NSArray* line;
    Word* wordEntry;
    for(NSString* fileLine in fileLines) {
        line = [fileLine componentsSeparatedByString:@":"];
        if([line count] == 2) {
            wordEntry = [[Word alloc] initWithWord:[line objectAtIndex:0] partOfSpeech:[Word convertStringToPartOfSpeech:[line objectAtIndex:1]]];
            [self addWord:wordEntry];
        }
    }
}

-(void)addWord:(Word*)word
{
    if([word partOfSpeech] == NOUN) {
        [_nouns addObject:word];
    } else if([word partOfSpeech] == VERB) {
        [_verbs addObject:word];
    } else if([word partOfSpeech] == ADJECTIVE) {
        [_adjectives addObject:word];
    } else if([word partOfSpeech] == ADVERB) {
        [_adverbs addObject:word];
    } else if([word partOfSpeech] == INTERJECTION) {
        [_interjections addObject:word];
    } else {
        
    }
}

-(Word*)getWordWithPartOfSpeech:(PartOfSpeech)partOfSpeech
{
    if(partOfSpeech == NOUN) {
        return [_nouns objectAtIndex:arc4random_uniform((int)[_nouns count])];
    } else if(partOfSpeech == VERB) {
        return [_verbs objectAtIndex:arc4random_uniform((int)[_verbs count])];
    } else if(partOfSpeech == ADJECTIVE) {
        return [_adjectives objectAtIndex:arc4random_uniform((int)[_adjectives count])];
    } else if(partOfSpeech == ADVERB) {
        return [_adverbs objectAtIndex:arc4random_uniform((int)[_adverbs count])];
    } else if(partOfSpeech == INTERJECTION) {
        return [_interjections objectAtIndex:arc4random_uniform((int)[_interjections count])];
    } else {
        return nil;
    }
}

-(NSString*)generate
{
    if([_templates count] == 0) {
        NSLog(@"No templates found.");
        return nil;
    }
    WordTemplate* template = [_templates objectAtIndex:arc4random_uniform((int)[_templates count])];
    [template clearFilledTemplate];
    PartOfSpeech pos = [template getNextBlankType];
    while(pos != UNKNOWN) {
        if(pos == NOUN) {
            [template replaceNextBlankWithWord:([self getWordWithPartOfSpeech:pos])];
        } else if(pos == VERB) {
            [template replaceNextBlankWithWord:([self getWordWithPartOfSpeech:pos])];
        } else if(pos == ADJECTIVE) {
            [template replaceNextBlankWithWord:([self getWordWithPartOfSpeech:pos])];
        } else if(pos == ADVERB) {
            [template replaceNextBlankWithWord:([self getWordWithPartOfSpeech:pos])];
        } else if(pos == INTERJECTION) {
            [template replaceNextBlankWithWord:([self getWordWithPartOfSpeech:pos])];
        }
        pos = [template getNextBlankType];
    }
    return [template filledTemplate];
}

@end