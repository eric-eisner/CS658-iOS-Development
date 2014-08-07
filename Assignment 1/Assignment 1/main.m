//
//  main.m
//  Assignment 1
//
//  Copyright (c) 2014 Eric L Eisner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Deck.h"
#import "Table.h"
#import "Card.h"

int main(int argc, const char* argv[])
{
    @autoreleasepool {
        BOOL endgame = false;
        
        Player* computer = [[Player alloc] init];
        Player* user = [[Player alloc] init];
        Deck* deck = [[Deck alloc] init];
        Table* table = [[Table alloc] init];
        
        [computer setName:@"Computer"];
        [user setName:@"Eric"];
        
        while([deck hasCards]) {
            Card* card = [[Card alloc] init];
            card = [deck dealCard];
            [computer addCard:card];
            card = [deck dealCard];
            [user addCard:card];
        }
        
        NSLog(@"----- Welcome to WAR ------\n\n");
        
        while(endgame == false) {
            if(![user hasCards] || ![computer hasCards]) {
                endgame = true;
                break;
            }
            Card* card1 = [[Card alloc] init];
            Card* card2 = [[Card alloc] init];
            NSLog(@"%@ has %d cards.", [user name], [user numCards]);
            NSLog(@"%@ has %d cards.", [computer name], [computer numCards]);
            
            card1 = [computer getNextCard];
            NSLog(@"Computer has played %@", card1);
            [table addCard:card1];
            card2 = [user getNextCard];
            NSLog(@"Eric has played %@", card2);
            [table addCard:card2];
            //[table logTable];
            
            if([card1 value] > [card2 value]) {
                [computer addCards:[table removeCards]];
                NSLog(@"Computer wins this round.\n\n");
            } else if([card1 value] < [card2 value]) {
                [user addCards:[table removeCards]];
                NSLog(@"Eric wins this round.\n\n");
            } else {
                BOOL war = true;
                while(war == true && [user hasCards] && [computer hasCards]) {
                    NSLog(@"-- WAR!!! --");
                    for(int i = 0; i < 3; ++i) {
                        if(![user hasCards] || ![computer hasCards]) {
                            war = false;
                            endgame = true;
                            break;
                        }
                        NSLog(@"Computer is discarding");
                        card1 = [computer getNextCard];
                        [table addCard:card1];
                        NSLog(@"User is discarding");
                        card2 = [user getNextCard];
                        [table addCard:card2];
                    }
                    
                    if(![user hasCards] || ![computer hasCards]) {
                        war = false;
                        endgame = true;
                        break;
                    }
                    card1 = [computer getNextCard];
                    NSLog(@"Computer has played %@", card1);
                    [table addCard:card1];
                    card2 = [user getNextCard];
                    NSLog(@"Eric has played %@", card2);
                    [table addCard:card2];
                    
                    if([card1 value] > [card2 value]) {
                        war = false;
                        [computer addCards:[table removeCards]];
                        NSLog(@"Computer wins this round.\n\n");
                    } else if([card1 value] < [card2 value]) {
                        war = false;
                        [user addCards:[table removeCards]];
                        NSLog(@"Eric wins this round.\n\n");
                    }
                }
            }
            
            // Debugging
            /*endgame = true;
             NSLog(@"%@ has %d cards.", [user name], [user numCards]);
             NSLog(@"%@ has %d cards.", [computer name], [computer numCards]);
             card1 = [computer getNextCard];
             NSLog(@"Computer has played %@", card1);
             [table addCard:card1];
             card2 = [user getNextCard];
             NSLog(@"Eric has played %@", card2);
             [table addCard:card2];*/
        }
        
        if(endgame) {
            if(![user hasCards]) {
                NSLog(@" ");
                NSLog(@"Computer WINS!!");
            } else if(![computer hasCards]) {
                NSLog(@" ");
                NSLog(@"Eric WINS!!");
            }
        }
    
    }
    
    return 0;
}