//
//  MyScene.m
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import "MyScene.h"
#import "SpaceshipScene.h"

@implementation MyScene

AVAudioPlayer *audioPlayer;

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:1 green:243/255.f blue:146/255.f alpha:1];
        self.physicsWorld.contactDelegate=self;
        self.physicsWorld.gravity = CGVectorMake(0,0);
        
//        SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:@"DFGirlKelvin"];
//        nameLabel.text = @"直到我膝盖\n中了一箭";//Run! Soul
//        nameLabel.fontSize = 40;
//        nameLabel.position = CGPointMake(CGRectGetMidX(self.frame),
//                                       CGRectGetMidY(self.frame)+150);
//        nameLabel.fontColor=[SKColor brownColor];
//        [self addChild:nameLabel];
        
        SKSpriteNode *deskSpriteNode=[SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(50, 50)];
        deskSpriteNode.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+50);
        [self addChild:deskSpriteNode];
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"desk"];
        SKTexture *temp1 = [atlas textureNamed:@"desk1.png"];
        SKTexture *temp2 = [atlas textureNamed:@"desk2.png"];
        SKTexture *temp3 = [atlas textureNamed:@"desk3.png"];
        SKTexture *temp4 = [atlas textureNamed:@"desk4.png"];
        SKTexture *temp5 = [atlas textureNamed:@"desk5.png"];
        SKTexture *temp6 = [atlas textureNamed:@"desk6.png"];
        SKTexture *temp7 = [atlas textureNamed:@"desk7.png"];
        SKTexture *temp8 = [atlas textureNamed:@"desk8.png"];
        SKTexture *temp9 = [atlas textureNamed:@"desk9.png"];
        SKTexture *temp10 = [atlas textureNamed:@"desk10.png"];
        SKTexture *temp11 = [atlas textureNamed:@"desk11.png"];
        NSArray *heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11];
        SKAction *runAction=[SKAction animateWithTextures:heroArray timePerFrame:0.2];
        [deskSpriteNode runAction:[SKAction repeatActionForever:runAction]];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        myLabel.text = [NSString stringWithFormat:@"Best:%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"BEST"]];
        myLabel.fontSize = 15;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame));
        myLabel.fontColor=[SKColor redColor];
        [self addChild:myLabel];

        SKLabelNode *startLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        startLabel.text = @"Start";
        startLabel.name=@"start";
        startLabel.fontSize = 30;
        startLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)-100);
        startLabel.fontColor=[SKColor blackColor];
        [self addChild:startLabel];
        startLabel.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(80, 50)];
        
        SKSpriteNode *rateSpriteNode=[SKSpriteNode spriteNodeWithColor:[SKColor redColor] size:CGSizeMake(58, 50)];
        rateSpriteNode.position=CGPointMake(29, 25);
        [self addChild:rateSpriteNode];
        atlas = [SKTextureAtlas atlasNamed:@"rate"];
        temp1 = [atlas textureNamed:@"rate1.png"];
        temp2 = [atlas textureNamed:@"rate2.png"];
        temp3 = [atlas textureNamed:@"rate3.png"];
        temp4 = [atlas textureNamed:@"rate4.png"];
        temp5 = [atlas textureNamed:@"rate5.png"];
        temp6 = [atlas textureNamed:@"rate6.png"];
        temp7 = [atlas textureNamed:@"rate7.png"];
        temp8 = [atlas textureNamed:@"rate8.png"];
        temp9 = [atlas textureNamed:@"rate9.png"];
        temp10 = [atlas textureNamed:@"rate10.png"];
        temp11 = [atlas textureNamed:@"rate11.png"];
        SKTexture *temp12 = [atlas textureNamed:@"rate12.png"];
        SKTexture *temp13 = [atlas textureNamed:@"rate13.png"];
        SKTexture *temp14 = [atlas textureNamed:@"rate14.png"];
        SKTexture *temp15 = [atlas textureNamed:@"rate15.png"];
        SKTexture *temp16 = [atlas textureNamed:@"rate16.png"];
        SKTexture *temp17 = [atlas textureNamed:@"rate17.png"];
        SKTexture *temp18 = [atlas textureNamed:@"rate18.png"];
        SKTexture *temp19 = [atlas textureNamed:@"rate19.png"];
        SKTexture *temp20 = [atlas textureNamed:@"rate20.png"];
        SKTexture *temp21 = [atlas textureNamed:@"rate21.png"];
        SKTexture *temp22 = [atlas textureNamed:@"rate22.png"];
        SKTexture *temp23 = [atlas textureNamed:@"rate23.png"];
        SKTexture *temp24 = [atlas textureNamed:@"rate24.png"];
        SKTexture *temp25 = [atlas textureNamed:@"rate25.png"];
        SKTexture *temp26 = [atlas textureNamed:@"rate26.png"];
        SKTexture *temp27 = [atlas textureNamed:@"rate27.png"];
        SKTexture *temp28 = [atlas textureNamed:@"rate28.png"];
        SKTexture *temp29 = [atlas textureNamed:@"rate29.png"];
        SKTexture *temp30 = [atlas textureNamed:@"rate30.png"];
        SKTexture *temp31 = [atlas textureNamed:@"rate31.png"];
        SKTexture *temp32 = [atlas textureNamed:@"rate32.png"];
        SKTexture *temp33 = [atlas textureNamed:@"rate33.png"];
        SKTexture *temp34 = [atlas textureNamed:@"rate34.png"];
        SKTexture *temp35 = [atlas textureNamed:@"rate35.png"];
        SKTexture *temp36 = [atlas textureNamed:@"rate36.png"];
        SKTexture *temp37 = [atlas textureNamed:@"rate37.png"];
        SKTexture *temp38 = [atlas textureNamed:@"rate38.png"];
        SKTexture *temp39 = [atlas textureNamed:@"rate39.png"];
        SKTexture *temp40 = [atlas textureNamed:@"rate40.png"];
        SKTexture *temp41 = [atlas textureNamed:@"rate41.png"];
        SKTexture *temp42 = [atlas textureNamed:@"rate42.png"];
        SKTexture *temp43 = [atlas textureNamed:@"rate43.png"];
        SKTexture *temp44 = [atlas textureNamed:@"rate44.png"];
        SKTexture *temp45 = [atlas textureNamed:@"rate45.png"];
        SKTexture *temp46 = [atlas textureNamed:@"rate46.png"];
        SKTexture *temp47 = [atlas textureNamed:@"rate47.png"];
        SKTexture *temp48 = [atlas textureNamed:@"rate48.png"];
        SKTexture *temp49 = [atlas textureNamed:@"rate49.png"];
        SKTexture *temp50 = [atlas textureNamed:@"rate50.png"];
        SKTexture *temp51 = [atlas textureNamed:@"rate51.png"];
        SKTexture *temp52 = [atlas textureNamed:@"rate52.png"];
        SKTexture *temp53 = [atlas textureNamed:@"rate53.png"];
        SKTexture *temp54 = [atlas textureNamed:@"rate54.png"];
        SKTexture *temp55 = [atlas textureNamed:@"rate55.png"];
        heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20,temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,temp29,temp30,temp31,temp32,temp33,temp34,temp35,temp36,temp37,temp38,temp39,temp40,temp41,temp42,temp43,temp44,temp45,temp46,temp47,temp48,temp49,temp50,temp51,temp51,temp52,temp53,temp54,temp55];
        runAction=[SKAction animateWithTextures:heroArray timePerFrame:0.05];
        [rateSpriteNode runAction:[SKAction repeatActionForever:runAction]];
        rateSpriteNode.name=@"rate";
        rateSpriteNode.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(58, 50)];
    }
    return self;
}

- (void)didMoveToView:(SKView *)view{
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bgm_04"
                                                          ofType:@"MP3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                        error:nil];
    [audioPlayer setDelegate:self];
    [audioPlayer play];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    for (UITouch *touch in touches) {
        CGPoint touchLocation = [touch locationInNode:self];
        SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:touchLocation];
        if ([body.node.name isEqualToString:@"start"]){
            NSLog(@"go");
            [audioPlayer stop];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"nameHide"object:@"Hide"];
            
            SKScene *spaceshipScene=[[SpaceshipScene alloc]initWithSize:self.size];
            SKTransition *doors=[SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:spaceshipScene transition:doors];
            
        }else if ([body.node.name isEqualToString:@"rate"]){
            NSLog(@"rate");
            UIAlertView *alt=[[UIAlertView alloc]initWithTitle:NSLocalizedString(@"Thank you", t) message:NSLocalizedString(@"alt1", alt1) delegate:self cancelButtonTitle:NSLocalizedString(@"alt3", alt3) otherButtonTitles:NSLocalizedString(@"alt2", alt2), nil];
            [alt show];
        }
    }
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    double version = [[UIDevice currentDevice].systemVersion doubleValue];
    if (buttonIndex==1) {
        if (version<7) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=918937096"]];
        }
        else{
            if (version>6) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"itms-apps://itunes.apple.com/app/id918937096"]];
            }
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

//播放完后
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player
                       successfully:(BOOL)flag{
    [audioPlayer play];
}

//打断后回到
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player{
    [audioPlayer stop];
    [audioPlayer play];
}



@end
