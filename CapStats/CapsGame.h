//
//  CapsGame.h
//  CapStats
//
//  Created by Alex Cohen on 8/16/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CapsGame : NSObject


-(NSUInteger)numberOfHits;
-(NSUInteger)numberOfRegularMisses;
-(NSUInteger)numberOfGlassMisses;
-(NSUInteger)totalShots;
-(float)hitPercentage;
-(float)missPercentage;
-(float)glassPercentage;


-(void)makeShot;
-(void)missRegular;
-(void)missGlass;

@end
