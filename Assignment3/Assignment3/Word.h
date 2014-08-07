//
//  Word.h
//  Assignment 2
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{UNKNOWN, NOUN, VERB, ADJECTIVE, ADVERB, INTERJECTION} PartOfSpeech;

@interface Word : NSObject

@property(nonatomic, strong) NSString* word;
@property(nonatomic) PartOfSpeech partOfSpeech;

+(PartOfSpeech)convertStringToPartOfSpeech:(NSString*)string;

-(id)init;
-(id)initWithWord:(NSString*)word
     partOfSpeech:(PartOfSpeech)partOfSpeech;
-(id)initWithWord:(NSString*)word;
-(NSString*)description;

@end
