//
//  MyScene.h
//  Sk
//

//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MyScene : SKScene<SKPhysicsContactDelegate,AVAudioPlayerDelegate>

@property BOOL contentCreated;

@end
