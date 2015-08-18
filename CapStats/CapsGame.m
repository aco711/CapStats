//
//  CapsGame.m
//  CapStats
//
//  Created by Alex Cohen on 8/16/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import "CapsGame.h"
@interface CapsGame()
@property (nonatomic) NSUInteger hits;
@property (nonatomic) NSUInteger regularMisses;
@property (nonatomic) NSUInteger glassMisses;
@property (nonatomic) NSUInteger shotsTaken;


@end
@implementation CapsGame


-(instancetype)init
{
    if (!self)
    {
        self = [super init];
        self.hits = 0;
        self.regularMisses = 0;
        self.glassMisses = 0;
        self.shotsTaken = 0;
    }
    return self;
}
-(NSUInteger)numberOfHits
{
    return self.hits;
}
-(NSUInteger)numberOfRegularMisses
{
    return self.regularMisses;
}
-(NSUInteger)numberOfGlassMisses
{
    return self.glassMisses;
}

-(NSUInteger)totalShots
{
    return self.hits + self.regularMisses;
}

-(float)hitPercentage
{
    float f = (float)self.hits / (float)self.shotsTaken;
    if (isnan(f))
    {
        return 0;
    }
    return f;
}
-(float)glassPercentage
{
    float f = (float)self.glassMisses / (float)self.shotsTaken;
    if (isnan(f))
    {
        return 0;
    }
    return f;}
-(float)missPercentage
{
    float f = (float)self.regularMisses / (float)self.shotsTaken;
    if (isnan(f))
    {
        return 0;
    }
    return f;
}

-(void)makeShot
{
    self.shotsTaken++;
    self.hits++;
}
-(void)missRegular
{
    self.shotsTaken++;
    self.regularMisses++;
}
-(void)missGlass
{
    self.glassMisses++;
    self.regularMisses++;
    self.shotsTaken++;
}
@end
