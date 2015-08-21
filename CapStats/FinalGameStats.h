//
//  FinalGameStats.h
//  CapStats
//
//  Created by Alex Cohen on 8/20/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Realm/Realm.h>
#import "CapsGame.h"

@interface FinalGameStats : RLMObject
@property (nonatomic) float glassPercentage;
@property (nonatomic) NSInteger numberOfHits;
@property (nonatomic) NSInteger regularMisses;
@property (nonatomic) NSInteger glassMisses;
@property (nonatomic) float hitPercentage;
@property (nonatomic) float missPercentage;

@property (nonatomic) NSInteger gameNumber;

+(FinalGameStats*)createFinalGameWithCapsGame:(CapsGame*)game withGameNumber:(NSUInteger)gameNumber;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<FinalGameStats>
RLM_ARRAY_TYPE(FinalGameStats)
