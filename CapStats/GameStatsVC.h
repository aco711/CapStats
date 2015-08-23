//
//  GameStatsVC.h
//  CapStats
//
//  Created by Alex Cohen on 8/19/15.
//  Copyright (c) 2015 Alex Cohen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Realm/Realm.h>
#import "FinalGameStats.h"
#import "LCZoomTransition.h"

@interface GameStatsVC : UIViewController


@property (strong, nonatomic) FinalGameStats * finalGameStats;

@property (nonatomic, strong) id<LCZoomTransitionGestureTarget> gestureTarget;

@end
