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
@property (strong, nonatomic) NSMutableArray* history;


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
        self.gameNumber = 50;
    }
    return self;
}
-(NSMutableArray*)history
{
    if (!_history)
    {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
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
    [self.history addObject:@"HIT"];
}
-(void)missRegular
{
    self.shotsTaken++;
    self.regularMisses++;
    [self.history addObject:@"MISS"];
}
-(void)missGlass
{
    self.glassMisses++;
    self.regularMisses++;
    self.shotsTaken++;
    [self.history addObject:@"GLASS"];
}
-(void)redoShot
{
    if ([[self.history lastObject] isEqualToString:@"HIT"])
    {
        self.hits--;
        self.shotsTaken--;
        [self.history removeLastObject];
        
    }
    else if ([[self.history lastObject] isEqualToString:@"MISS"])
    {
        self.regularMisses--;
        self.shotsTaken--;
        [self.history removeLastObject];
    }
    else if ([[self.history lastObject] isEqualToString:@"GLASS"])
    {
        self.glassMisses--;
        self.regularMisses--;
        self.shotsTaken--;
        [self.history removeLastObject];
    }
}
-(void)endGame
{
    
    self.hits = 0;
    self.regularMisses = 0;
    self.glassMisses = 0;
    self.shotsTaken = 0;
    self.history = nil;
}
@end
