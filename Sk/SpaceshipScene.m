//
//  SpaceshipScene.m
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import "SpaceshipScene.h"
#import "GameOverScene.h"
#import "MyScene.h"

static const uint32_t hullCategory     =  0x1 << 0;
static const uint32_t rockCategory        =  0x1 << 1;
static const uint32_t enemyCategory        =  0x1 << 2;

@implementation SpaceshipScene

SKSpriteNode *hull;
SKLabelNode *timeLabel;
SKLabelNode *bestLabel;
bool isBegain=0;
bool isEnd=0;
int gameTime=0;
float gameStartTime;
int gameCombo=0;
SKSpriteNode *gameOverView;
UIButton *retryButton;
UIButton *backButton;

SKAction *heroAction;
SKAction *heroMoveRightAction;
SKAction *heroMoveLeftAction;
SKAction *heroHappyAction;

float lastLocationX;
bool isHappyMark=0;
bool isPaused=0;

int adCount=0;
AVAudioPlayer *audioPlayer;
AVAudioPlayer *audioPlayer1;

- (void)didMoveToView:(SKView *)view{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated=YES;
        self.physicsWorld.contactDelegate=self;
        self.physicsWorld.gravity = CGVectorMake(0,-0.8);
        self.scaleMode=SKSceneScaleModeAspectFit;
        
    }
}

- (void)createSceneContents{
    
    self.backgroundColor=[SKColor colorWithRed:1 green:243/255.f blue:146/255.f alpha:1];
    self.scaleMode=SKSceneScaleModeAspectFit;
    lastLocationX=self.view.frame.size.width/2;
    
    SKSpriteNode *spaceship=[self newSpaceship];
    spaceship.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];

    SKAction *makeRocks=    [SKAction sequence:@[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:1 withRange:0.15]]];
    SKAction *makeRocks_2=  [SKAction sequence:@[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.8 withRange:0.15]]];
    SKAction *makeRocks_3=  [SKAction sequence:@[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.6 withRange:0.15]]];
    SKAction *makeRocks_4=  [SKAction sequence:@[
                                                [SKAction performSelector:@selector(addRock) onTarget:self],
                                                [SKAction waitForDuration:0.4 withRange:0.15]]];
    SKAction *makeBigRocks= [SKAction sequence:@[
                                                [SKAction waitForDuration:2],
                                                [SKAction performSelector:@selector(addBigRock) onTarget:self]]];
    SKAction *makeEnemy=    [SKAction sequence:@[
                                                [SKAction waitForDuration:1.5],
                                                [SKAction performSelector:@selector(addEnemy) onTarget:self]]];
    
    SKAction *makeGroup=    [SKAction group:@[
                                                [SKAction repeatAction:makeRocks_3 count:30],
                                                [SKAction repeatAction:makeBigRocks count:9]]];
    SKAction *makeGroup_2=  [SKAction group:@[
                                                [SKAction repeatAction:makeRocks_4 count:60],
                                                [SKAction repeatAction:makeBigRocks count:12],
                                                [SKAction repeatAction:makeEnemy count:5]]];
    
    SKAction *rocksAllAction=[SKAction sequence:@[
                                                [SKAction repeatAction:makeRocks count:6],
                                                [SKAction repeatAction:makeRocks_2 count:10],
                                                makeGroup,
                                                [SKAction repeatActionForever:makeGroup_2]]];
    [self runAction:rocksAllAction];
    
    timeLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    timeLabel.text=@"Score:0";
    timeLabel.fontSize=18;
    timeLabel.position=CGPointMake(20,self.frame.size.height-30);
    timeLabel.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeLeft;
    timeLabel.fontColor=[SKColor blackColor];
    [self addChild:timeLabel];
    
    bestLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    bestLabel.text=[NSString stringWithFormat:@"Best:%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"BEST"]intValue]];
    bestLabel.fontSize=18;
    bestLabel.position=CGPointMake(self.frame.size.width-100,self.frame.size.height-30);
    bestLabel.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeLeft;
    bestLabel.fontColor=[SKColor blackColor];
    [self addChild:bestLabel];
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"mm_right"];
    SKTexture *temp1 = [atlas textureNamed:@"mm_right1.png"];
    SKTexture *temp2 = [atlas textureNamed:@"mm_right2.png"];
    SKTexture *temp3 = [atlas textureNamed:@"mm_right3.png"];
    SKTexture *temp4 = [atlas textureNamed:@"mm_right4.png"];
    SKTexture *temp5 = [atlas textureNamed:@"mm_right5.png"];
    SKTexture *temp6 = [atlas textureNamed:@"mm_right6.png"];
    SKTexture *temp7 = [atlas textureNamed:@"mm_right7.png"];
    SKTexture *temp8 = [atlas textureNamed:@"mm_right8.png"];
    SKTexture *temp9 = [atlas textureNamed:@"mm_right9.png"];
    SKTexture *temp10 = [atlas textureNamed:@"mm_right10.png"];
    SKTexture *temp11 = [atlas textureNamed:@"mm_right11.png"];
    SKTexture *temp12;
    SKTexture *temp13;
    SKTexture *temp14;
    SKTexture *temp15;
    SKTexture *temp16;
    SKTexture *temp17;
    SKTexture *temp18;
    SKTexture *temp19;
    SKTexture *temp20;
    SKTexture *temp21;
    SKTexture *temp22;
    SKTexture *temp23;
    SKTexture *temp24;
    SKTexture *temp25;
    SKTexture *temp26;
    SKTexture *temp27;
    SKTexture *temp28;
    SKTexture *temp29;
    SKTexture *temp30;
    SKTexture *temp31;
    SKTexture *temp32;
    SKTexture *temp33;
    SKTexture *temp34;
    SKTexture *temp35;
    SKTexture *temp36;
    SKTexture *temp37;
    NSArray *heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11];
    heroMoveRightAction=[SKAction animateWithTextures:heroArray timePerFrame:0.07];
    
    atlas = [SKTextureAtlas atlasNamed:@"mm_left"];
    temp1 = [atlas textureNamed:@"mm_left1.png"];
    temp2 = [atlas textureNamed:@"mm_left2.png"];
    temp3 = [atlas textureNamed:@"mm_left3.png"];
    temp4 = [atlas textureNamed:@"mm_left4.png"];
    temp5 = [atlas textureNamed:@"mm_left5.png"];
    temp6 = [atlas textureNamed:@"mm_left6.png"];
    temp7 = [atlas textureNamed:@"mm_left7.png"];
    temp8 = [atlas textureNamed:@"mm_left8.png"];
    temp9 = [atlas textureNamed:@"mm_left9.png"];
    temp10 = [atlas textureNamed:@"mm_left10.png"];
    temp11 = [atlas textureNamed:@"mm_left11.png"];
    heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11];
    heroMoveLeftAction=[SKAction animateWithTextures:heroArray timePerFrame:0.07];
    
    atlas = [SKTextureAtlas atlasNamed:@"mm_happy"];
    temp1 = [atlas textureNamed:@"mm_happy1.png"];
    temp2 = [atlas textureNamed:@"mm_happy2.png"];
    temp3 = [atlas textureNamed:@"mm_happy3.png"];
    temp4 = [atlas textureNamed:@"mm_happy4.png"];
    temp5 = [atlas textureNamed:@"mm_happy5.png"];
    temp6 = [atlas textureNamed:@"mm_happy6.png"];
    temp7 = [atlas textureNamed:@"mm_happy7.png"];
    temp8 = [atlas textureNamed:@"mm_happy8.png"];
    temp9 = [atlas textureNamed:@"mm_happy9.png"];
    temp10 = [atlas textureNamed:@"mm_happy10.png"];
    temp11 = [atlas textureNamed:@"mm_happy11.png"];
    temp12 = [atlas textureNamed:@"mm_happy12.png"];
    temp13 = [atlas textureNamed:@"mm_happy13.png"];
    temp14 = [atlas textureNamed:@"mm_happy14.png"];
    temp15 = [atlas textureNamed:@"mm_happy15.png"];
    temp16 = [atlas textureNamed:@"mm_happy16.png"];
    temp17 = [atlas textureNamed:@"mm_happy17.png"];
    temp18 = [atlas textureNamed:@"mm_happy18.png"];
    temp19 = [atlas textureNamed:@"mm_happy19.png"];
    temp20 = [atlas textureNamed:@"mm_happy20.png"];
    temp21 = [atlas textureNamed:@"mm_happy21.png"];
    temp22 = [atlas textureNamed:@"mm_happy22.png"];
    temp23 = [atlas textureNamed:@"mm_happy23.png"];
    temp24 = [atlas textureNamed:@"mm_happy24.png"];
    temp25 = [atlas textureNamed:@"mm_happy25.png"];
    temp26 = [atlas textureNamed:@"mm_happy26.png"];
    temp27 = [atlas textureNamed:@"mm_happy27.png"];
    temp28 = [atlas textureNamed:@"mm_happy28.png"];
    temp29 = [atlas textureNamed:@"mm_happy29.png"];
    temp30 = [atlas textureNamed:@"mm_happy30.png"];
    temp31 = [atlas textureNamed:@"mm_happy31.png"];
    temp32 = [atlas textureNamed:@"mm_happy32.png"];
    temp33 = [atlas textureNamed:@"mm_happy33.png"];
    temp34 = [atlas textureNamed:@"mm_happy34.png"];
    temp35 = [atlas textureNamed:@"mm_happy35.png"];
    temp36 = [atlas textureNamed:@"mm_happy36.png"];
    temp37 = [atlas textureNamed:@"mm_happy37.png"];
    heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20,temp21,temp22,temp23,temp24,temp25,temp26,temp27,temp28,temp29,temp30,temp31,temp32,temp33,temp34,temp35,temp36,temp37];
    heroHappyAction=[SKAction animateWithTextures:heroArray timePerFrame:0.04];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pause:) name:@"pause" object:nil];
    
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bgm_06"
                                                          ofType:@"MP3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                         error:nil];
    [audioPlayer setDelegate:self];
    [audioPlayer play];
}

- (SKSpriteNode*)newSpaceship{
    hull=[[SKSpriteNode alloc]initWithColor:[SKColor grayColor] size:CGSizeMake(50, 50)];
    hull.name=@"hero";
    
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"mm"];
    SKTexture *temp1 = [atlas textureNamed:@"mm1.png"];
    SKTexture *temp2 = [atlas textureNamed:@"mm2.png"];
    SKTexture *temp3 = [atlas textureNamed:@"mm3.png"];
    SKTexture *temp4 = [atlas textureNamed:@"mm4.png"];
    SKTexture *temp5 = [atlas textureNamed:@"mm5.png"];
    SKTexture *temp6 = [atlas textureNamed:@"mm6.png"];
    SKTexture *temp7 = [atlas textureNamed:@"mm7.png"];
    SKTexture *temp8 = [atlas textureNamed:@"mm8.png"];
    SKTexture *temp9 = [atlas textureNamed:@"mm9.png"];
    SKTexture *temp10 = [atlas textureNamed:@"mm10.png"];
    SKTexture *temp11 = [atlas textureNamed:@"mm11.png"];
    SKTexture *temp12 = [atlas textureNamed:@"mm12.png"];
    SKTexture *temp13 = [atlas textureNamed:@"mm13.png"];
    SKTexture *temp14 = [atlas textureNamed:@"mm14.png"];
    SKTexture *temp15 = [atlas textureNamed:@"mm15.png"];
    SKTexture *temp16 = [atlas textureNamed:@"mm16.png"];
    SKTexture *temp17 = [atlas textureNamed:@"mm17.png"];
    SKTexture *temp18 = [atlas textureNamed:@"mm18.png"];
    SKTexture *temp19 = [atlas textureNamed:@"mm19.png"];
    SKTexture *temp20 = [atlas textureNamed:@"mm20.png"];
    SKTexture *temp21 = [atlas textureNamed:@"mm21.png"];
    SKTexture *temp22 = [atlas textureNamed:@"mm22.png"];
    SKTexture *temp23 = [atlas textureNamed:@"mm23.png"];
    SKTexture *temp24 = [atlas textureNamed:@"mm24.png"];
    NSArray *heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8,temp9,temp10,temp11,temp12,temp13,temp14,temp15,temp16,temp17,temp18,temp19,temp20,temp21,temp22,temp23,temp24];
    heroAction=[SKAction animateWithTextures:heroArray timePerFrame:0.1];
    [hull runAction:[SKAction repeatActionForever:heroAction]];
    
    SKAction *hover=[SKAction sequence:@[
                                         [SKAction waitForDuration:1.0],
                                         [SKAction moveByX:0 y:5 duration:1.0],
                                         [SKAction waitForDuration:1.0],
                                         [SKAction moveByX:0.0 y:-5 duration:1.0]]];
    [hull runAction:[SKAction repeatActionForever:hover]];
    
    SKSpriteNode *light1=[self newLight];
    light1.position=CGPointMake(-28, 6);
    [hull addChild:light1];
    
    SKSpriteNode *light2=[self newLight];
    light2.position=CGPointMake(28, 6);
    [hull addChild:light2];
    
    hull.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:hull.size];
    hull.physicsBody.dynamic=NO;
    hull.physicsBody.categoryBitMask = hullCategory;
    hull.physicsBody.contactTestBitMask = rockCategory;
    
    return hull;
}

- (SKSpriteNode*)newLight{
    SKSpriteNode *light=[[SKSpriteNode alloc]initWithColor:[SKColor yellowColor] size:CGSizeMake(8, 8)];
    SKAction *blink=[SKAction sequence:@[
                                         [SKAction fadeOutWithDuration:0.25],
                                         [SKAction fadeInWithDuration:0.25]]];
    SKAction *blinkForever=[SKAction repeatActionForever:blink];
    [light runAction:blinkForever];
    
    return light;
}

static inline CGFloat skRandf() {
    return arc4random()/2 / (CGFloat) RAND_MAX;
}

static inline CGFloat skRand(CGFloat low, CGFloat high) {
    return skRandf() * (high - low) + low;
}

- (void)addRock{
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor brownColor] size:CGSizeMake(12, 30)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"rock";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = rockCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
    rock.texture=[SKTexture textureWithImageNamed:@"arrow.png"];
}
- (void)addBigRock{
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor darkGrayColor] size:CGSizeMake(35, 35)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"bigRock";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = rockCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
    rock.texture=[SKTexture textureWithImageNamed:@"bomb.png"];
}
- (void)addEnemy{
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor greenColor] size:CGSizeMake(30, 30)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"enemy";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = enemyCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
    rock.texture=[SKTexture textureWithImageNamed:@"apple.png"];
}
- (void)didSimulatePhysics{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y<0) {
            [node removeFromParent];
        }
    }];
    [self enumerateChildNodesWithName:@"bigRock" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y<0) {
            [node removeFromParent];
        }
    }];
    [self enumerateChildNodesWithName:@"enemy" usingBlock:^(SKNode *node, BOOL *stop){
        if (node.position.y<0) {
            [node removeFromParent];
        }
    }];
}
- (void)didBeginContact:(SKPhysicsContact *)contact{

    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
    {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else
    {
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    if (firstBody.categoryBitMask==hullCategory&secondBody.categoryBitMask==rockCategory) {
        
        if (isEnd==1) {
            SKAction *pluseRed=[SKAction sequence:@[
                                                    [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.5 duration:0.2],
                                                    [SKAction waitForDuration:0.1]]];
            [hull runAction:pluseRed];
        }else{
            [secondBody.node removeFromParent];
            SKAction *pluseRed=[SKAction sequence:@[
                                                    [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.5 duration:0.2],
                                                    [SKAction waitForDuration:0.1]]];
            [hull runAction:pluseRed];
            isEnd=1;
            hull.size=CGSizeMake(50, 50);
            
            [audioPlayer stop];
            
            NSString *musicPath1 = [[NSBundle mainBundle] pathForResource:@"sound1"
                                                                  ofType:@"MP3"];
            NSURL *musicURL1 = [NSURL fileURLWithPath:musicPath1];
            audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL1
                                                                 error:nil];
            [audioPlayer1 play];

            NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bgm_09"
                                                                  ofType:@"MP3"];
            NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
            audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                                 error:nil];
            [audioPlayer setDelegate:self];
            [audioPlayer play];
            
            [self gameOver];
            
            adCount++;
            if (adCount==5) {
                adCount=0;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"adShow"object:@"adLarge"];
            }else{
                [[NSNotificationCenter defaultCenter] postNotificationName:@"adShow"object:@"adShow"];
            }
            
        }
        
    }else if (firstBody.categoryBitMask==hullCategory&secondBody.categoryBitMask==enemyCategory){
        
        if (isEnd==1) {
            
        }else{
            NSString *musicPath1 = [[NSBundle mainBundle] pathForResource:@"sound3"
                                                                   ofType:@"MP3"];
            NSURL *musicURL1 = [NSURL fileURLWithPath:musicPath1];
            audioPlayer1 = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL1
                                                                                 error:nil];
            [audioPlayer1 play];
            
            [secondBody.node removeFromParent];
            gameCombo++;
            SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            myLabel.text = [NSString stringWithFormat:@"%d Combo!",gameCombo];
            myLabel.fontSize = 30;
            myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame));
            myLabel.fontColor=[SKColor blackColor];
            
            [self addChild:myLabel];
            
            SKAction *fadeAction=[SKAction fadeAlphaTo:0 duration:1];
            [myLabel runAction:fadeAction];
            
            isHappyMark=1;
            [hull removeAllActions];
            hull.size=CGSizeMake(50, 66);
            [hull runAction:heroHappyAction completion:^{
                NSLog(@"hullcom");
                hull.size=CGSizeMake(50, 50);
                [hull runAction:heroAction];
                isHappyMark=0;
            }];
        }

        if (gameCombo==5) {
            gameCombo=0;
        }
    }
    
}
- (void)didEndContact:(SKPhysicsContact *)contact{
//    NSLog(@"end");
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isEnd==1) {
        lastLocationX=self.view.frame.size.width/2;
    }else if (isHappyMark==1){
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            SKAction *moveto = [SKAction moveTo:location duration:0.8];
            [hull runAction:moveto withKey:@"touchMove"];
        }
    }else{
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            SKAction *moveto = [SKAction moveTo:location duration:0.8];
            [hull removeAllActions];
            [hull runAction:moveto withKey:@"touchMove"];
            
            if (location.x>lastLocationX) {
                [hull runAction:heroMoveRightAction completion:^{
                    [hull runAction:[SKAction repeatActionForever:heroAction]];
                }];
            }else{
                [hull runAction:heroMoveLeftAction completion:^{
                    [hull runAction:[SKAction repeatActionForever:heroAction]];
                }];
            }
            lastLocationX=location.x;
            NSLog(@"%f",location.x);
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    if (isEnd==1) {
//        
//    }else{
//        for (UITouch *touch in touches) {
//            CGPoint location = [touch locationInNode:self];
//            SKAction *moveto = [SKAction moveTo:location duration:0.6];
//            [hull runAction:moveto withKey:@"touchMove"];
//        }
//    }
}

-(void)update:(CFTimeInterval)currentTime{
//    NSLog(@"%d",adCount);
    if (isEnd==1) {
        
    }else if (isPaused==1){
        isPaused=0;
        gameStartTime=currentTime-gameTime;
        
//        [retryButton removeFromSuperview];
//        [backButton removeFromSuperview];
//        
//        SKScene *spaceshipScene=[[MyScene alloc]initWithSize:self.size];
//        SKTransition *doors=[SKTransition doorsCloseVerticalWithDuration:0.5];
//        [self.view presentScene:spaceshipScene transition:doors];
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"nameHide"object:@"HideNo"];
        
    }else{
        if (isBegain==0) {
            isBegain=1;
            gameStartTime=currentTime;
            
        }else{
            gameTime=currentTime-gameStartTime;
            timeLabel.text=[NSString stringWithFormat:@"Score:%d",gameTime];
            
            if (gameTime>10&gameTime<30) {
                self.physicsWorld.gravity = CGVectorMake(0,-1.5);
            }else if (gameTime>30&gameTime<60){
                self.physicsWorld.gravity = CGVectorMake(0,-2);
            }else if (gameTime>60&gameTime<80){
                self.physicsWorld.gravity = CGVectorMake(0,-2.5);
            }else{
                self.physicsWorld.gravity = CGVectorMake(0,-3);
            }
        }
    }
}

- (void)gameOver{
    
    [self removeAllActions];
    
    [hull removeAllActions];
    SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"mm_d"];
    SKTexture *temp1 = [atlas textureNamed:@"mm_d1.png"];
    SKTexture *temp2 = [atlas textureNamed:@"mm_d2.png"];
    SKTexture *temp3 = [atlas textureNamed:@"mm_d3.png"];
    SKTexture *temp4 = [atlas textureNamed:@"mm_d4.png"];
    SKTexture *temp5 = [atlas textureNamed:@"mm_d5.png"];
    SKTexture *temp6 = [atlas textureNamed:@"mm_d6.png"];
    SKTexture *temp7 = [atlas textureNamed:@"mm_d7.png"];
    SKTexture *temp8 = [atlas textureNamed:@"mm_d8.png"];
    NSArray *heroArray=@[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8];
    SKAction *tempAction=[SKAction animateWithTextures:heroArray timePerFrame:0.1];
    
    SKTextureAtlas *atlas_2 = [SKTextureAtlas atlasNamed:@"death"];
    SKTexture *temp1_2 = [atlas_2 textureNamed:@"death1.png"];
    SKTexture *temp2_2 = [atlas_2 textureNamed:@"death2.png"];
    SKTexture *temp3_2 = [atlas_2 textureNamed:@"death3.png"];
    SKTexture *temp4_2 = [atlas_2 textureNamed:@"death4.png"];
    SKTexture *temp5_2 = [atlas_2 textureNamed:@"death5.png"];
    SKTexture *temp6_2 = [atlas_2 textureNamed:@"death6.png"];
    SKTexture *temp7_2 = [atlas_2 textureNamed:@"death7.png"];
    SKTexture *temp8_2 = [atlas_2 textureNamed:@"death8.png"];
    SKTexture *temp9_2 = [atlas_2 textureNamed:@"death1.png"];
    SKTexture *temp10_2 = [atlas_2 textureNamed:@"death2.png"];
    SKTexture *temp11_2 = [atlas_2 textureNamed:@"death3.png"];
    SKTexture *temp12_2 = [atlas_2 textureNamed:@"death4.png"];
    SKTexture *temp13_2 = [atlas_2 textureNamed:@"death5.png"];
    SKTexture *temp14_2 = [atlas_2 textureNamed:@"death6.png"];
    SKTexture *temp15_2 = [atlas_2 textureNamed:@"death7.png"];
    SKTexture *temp16_2 = [atlas_2 textureNamed:@"death8.png"];
    SKTexture *temp17_2 = [atlas_2 textureNamed:@"death1.png"];
    SKTexture *temp18_2 = [atlas_2 textureNamed:@"death2.png"];
    SKTexture *temp19_2 = [atlas_2 textureNamed:@"death3.png"];
    SKTexture *temp20_2 = [atlas_2 textureNamed:@"death4.png"];
    SKTexture *temp21_2 = [atlas_2 textureNamed:@"death5.png"];
    SKTexture *temp22_2 = [atlas_2 textureNamed:@"death6.png"];
    SKTexture *temp23_2 = [atlas_2 textureNamed:@"death7.png"];
    SKTexture *temp24_2 = [atlas_2 textureNamed:@"death8.png"];
    SKTexture *temp25_2 = [atlas_2 textureNamed:@"death1.png"];
    SKTexture *temp26_2 = [atlas_2 textureNamed:@"death2.png"];
    SKTexture *temp27_2 = [atlas_2 textureNamed:@"death3.png"];
    SKTexture *temp28_2 = [atlas_2 textureNamed:@"death4.png"];
    NSArray *heroArray_2=@[temp1_2,temp2_2,temp3_2,temp4_2,temp5_2,temp6_2,temp7_2,temp8_2,temp9_2,temp10_2,temp11_2,temp12_2,temp13_2,temp14_2,temp15_2,temp16_2,temp17_2,temp18_2,temp19_2,temp20_2,temp21_2,temp22_2,temp23_2,temp24_2,temp25_2,temp26_2,temp27_2,temp28_2];
    SKAction *tempAction_2=[SKAction animateWithTextures:heroArray_2 timePerFrame:0.1];
    int x = arc4random() % 10;
    if (x<4) {
        [hull runAction:[SKAction repeatActionForever:tempAction_2]];
    }else{
        [hull runAction:[SKAction repeatActionForever:tempAction]];
    }
    
    gameOverView=[[SKSpriteNode alloc]initWithColor:[SKColor colorWithRed:0 green:0 blue:0 alpha:0.8] size:CGSizeMake(320, 320)];
    gameOverView.texture=[SKTexture textureWithImageNamed:@"gameover.png"];
    gameOverView.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:gameOverView];
    SKAction *gameOverViewAction=[SKAction fadeAlphaBy:0 duration:1];
    [gameOverView runAction:gameOverViewAction];
    SKAction *gameOverViewAction2=[SKAction fadeAlphaBy:0 duration:1.5];
    
    SKLabelNode *gameOverLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOverLabel.text=@"Your Score";
    gameOverLabel.fontSize=20;
    gameOverLabel.position=CGPointMake(0, 50);
    gameOverLabel.fontColor=[SKColor blackColor];
    [gameOverView addChild:gameOverLabel];
    [gameOverLabel runAction:gameOverViewAction];
    
    SKLabelNode *scoreLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    scoreLabel.text=[NSString stringWithFormat:@"%d",gameTime];
    scoreLabel.fontSize=20;
    scoreLabel.position=CGPointMake(0, 0);
    scoreLabel.fontColor=[SKColor blackColor];
    [gameOverView addChild:scoreLabel];
    [scoreLabel runAction:gameOverViewAction];
    
    SKLabelNode *rewardLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    rewardLabel.text=[NSString stringWithFormat:@"Combo Reward: %d",gameCombo*5];
    rewardLabel.fontSize=14;
    rewardLabel.position=CGPointMake(0, -50);
    rewardLabel.fontColor=[SKColor purpleColor];
    [gameOverView addChild:rewardLabel];
    rewardLabel.alpha=0;
    [gameOverView runAction:gameOverViewAction2 completion:^{
        rewardLabel.alpha=1;
        SKAction *fadeOutAction=[SKAction fadeOutWithDuration:0.3];
        SKAction *fadeInAction=[SKAction fadeInWithDuration:0.3];
        [scoreLabel runAction:fadeOutAction completion:^{
          scoreLabel.text=[NSString stringWithFormat:@"%d",gameTime+gameCombo*5];
            scoreLabel.fontColor=[SKColor redColor];
            scoreLabel.fontSize=30;
            [scoreLabel runAction:fadeInAction];
        }];
    }];
    
    if (gameTime+5*gameCombo>[[[NSUserDefaults standardUserDefaults] objectForKey:@"BEST"]intValue]) {
        NSLog(@"newRecord");
        
        SKLabelNode *newLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        newLabel.text = @"New Record~";
        newLabel.fontSize = 15;
        newLabel.position = CGPointMake(0,75);
        newLabel.fontColor=[SKColor redColor];
        
        SKAction *fadeAction=[SKAction sequence:@[
                                                  [SKAction fadeOutWithDuration:0.5],
                                                  [SKAction fadeInWithDuration:0.5]]];
        [newLabel runAction:[SKAction repeatActionForever:fadeAction]];
        [gameOverView addChild:newLabel];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",gameTime+5*gameCombo] forKey:@"BEST"];
    }
    
    
    retryButton=[UIButton buttonWithType:UIButtonTypeCustom];
    retryButton.frame=CGRectMake(135, 300, 50, 50);
    [retryButton setBackgroundImage:[UIImage imageNamed:@"button.png"] forState:UIControlStateNormal];
    [retryButton setBackgroundImage:[UIImage imageNamed:@"button_h.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:retryButton];
    [retryButton addTarget:self action:@selector(retryButton) forControlEvents:UIControlEventTouchUpInside];
    if (self.view.bounds.size.height>500) {
        retryButton.frame=CGRectMake(135, 340, 50, 50);
    }
}

- (void)retryButton{
    [retryButton removeFromSuperview];
    [gameOverView removeFromParent];
    
    [self removeAllActions];
    isEnd=0;
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"bigRock" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"enemy" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    [self enumerateChildNodesWithName:@"hero" usingBlock:^(SKNode *node, BOOL *stop){
        [node removeFromParent];
    }];
    [timeLabel removeFromParent];
    [bestLabel removeFromParent];
    isBegain=0;
    gameCombo=0;
    self.physicsWorld.gravity = CGVectorMake(0,-1);
    [self createSceneContents];
    
    [retryButton removeFromSuperview];
    [backButton removeFromSuperview];
    SKScene *spaceshipScene=[[MyScene alloc]initWithSize:self.size];
    SKTransition *doors=[SKTransition doorsCloseVerticalWithDuration:0.5];
    [self.view presentScene:spaceshipScene transition:doors];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nameHide"object:@"HideNo"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"adShow"object:@"adHide"];
    
    [audioPlayer stop];
    NSString *musicPath = [[NSBundle mainBundle] pathForResource:@"bgm_04"
                                                          ofType:@"MP3"];
    NSURL *musicURL = [NSURL fileURLWithPath:musicPath];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:musicURL
                                                         error:nil];
    [audioPlayer setDelegate:self];
    [audioPlayer play];
}
//- (void)backButton{
//    [retryButton removeFromSuperview];
//    [backButton removeFromSuperview];
//    SKScene *spaceshipScene=[[MyScene alloc]initWithSize:self.size];
//    SKTransition *doors=[SKTransition doorsCloseVerticalWithDuration:0.5];
//    [self.view presentScene:spaceshipScene transition:doors];
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"nameHide"object:@"HideNo"];
//}

- (void)pause:(NSNotification*)notification{
    id obj = [notification object];
    if ([obj isEqualToString:@"out"]){
        NSLog(@"out");
    }else if([obj isEqualToString:@"in"]){
        NSLog(@"in");
        isPaused=1;
    }
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
