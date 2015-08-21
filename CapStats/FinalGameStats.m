//
//  FinalGameStats.m
//  CapStats
//
//  Created by Alex Cohen on 8/20/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "FinalGameStats.h"

@implementation FinalGameStats

+(FinalGameStats*)createFinalGameWithCapsGame:(CapsGame*)game withGameNumber:(NSUInteger)gameNumber
{
    FinalGameStats* finalGameStats = [[FinalGameStats alloc] init];
    finalGameStats.regularMisses = game.numberOfRegularMisses;
    finalGameStats.glassMisses = game.numberOfGlassMisses;
    finalGameStats.numberOfHits = [game numberOfHits];
    finalGameStats.missPercentage = game.missPercentage;
    finalGameStats.glassPercentage = game.glassPercentage;
    finalGameStats.hitPercentage = game.hitPercentage;
    finalGameStats.gameNumber = gameNumber;

    return finalGameStats;
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
