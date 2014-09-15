//
//  SpaceshipScene.h
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface SpaceshipScene : SKScene<SKPhysicsContactDelegate,AVAudioPlayerDelegate>

@property BOOL contentCreated;

@end
