//
//  SpaceshipScene.m
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import "SpaceshipScene.h"
#import "GameOverScene.h"

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
    
    self.backgroundColor=[SKColor blackColor];
    self.scaleMode=SKSceneScaleModeAspectFit;
    
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
                                                [SKAction repeatAction:makeBigRocks count:10]]];
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
    [self addChild:timeLabel];
    
    bestLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    bestLabel.text=[NSString stringWithFormat:@"Best:%d",[[[NSUserDefaults standardUserDefaults] objectForKey:@"BEST"]intValue]];
    bestLabel.fontSize=18;
    bestLabel.position=CGPointMake(self.frame.size.width-100,self.frame.size.height-30);
    bestLabel.horizontalAlignmentMode=SKLabelHorizontalAlignmentModeLeft;
    [self addChild:bestLabel];
}

- (SKSpriteNode*)newSpaceship{
    hull=[[SKSpriteNode alloc]initWithColor:[SKColor grayColor] size:CGSizeMake(40, 32)];
    hull.name=@"hero";
    
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
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor brownColor] size:CGSizeMake(8, 8)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"rock";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = rockCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
}
- (void)addBigRock{
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor darkGrayColor] size:CGSizeMake(20, 20)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"bigRock";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = rockCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
}
- (void)addEnemy{
    self.physicsWorld.contactDelegate=self;
    SKSpriteNode *rock=[[SKSpriteNode alloc]initWithColor:[SKColor greenColor] size:CGSizeMake(10, 10)];
    rock.position=CGPointMake(skRand(0, self.size.width), self.size.height-50);
    rock.name=@"enemy";
    rock.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:rock.size];
    rock.physicsBody.usesPreciseCollisionDetection=YES;
    rock.physicsBody.categoryBitMask = enemyCategory;
    rock.physicsBody.contactTestBitMask = hullCategory;
    [self addChild:rock];
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
            
        }else{
            [secondBody.node removeFromParent];
            SKAction *pluseRed=[SKAction sequence:@[
                                                    [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.5 duration:0.2],
                                                    [SKAction waitForDuration:0.1],
                                                    [SKAction colorizeWithColor:[SKColor grayColor] colorBlendFactor:0.5 duration:0.2],
                                                    [SKAction colorizeWithColorBlendFactor:0.0 duration:0.2]]];
            [hull runAction:pluseRed];
            isEnd=1;
            
            [self gameOver];
        }
        
    }else if (firstBody.categoryBitMask==hullCategory&secondBody.categoryBitMask==enemyCategory){
        
        if (isEnd==1) {
            
        }else{
            [secondBody.node removeFromParent];
            gameCombo++;
            SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            myLabel.text = [NSString stringWithFormat:@"%d Combo!",gameCombo];
            myLabel.fontSize = 30;
            myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                           CGRectGetMidY(self.frame));
            
            [self addChild:myLabel];
            
            SKAction *fadeAction=[SKAction fadeAlphaTo:0 duration:1];
            [myLabel runAction:fadeAction];
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
        
    }else{
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            SKAction *moveto = [SKAction moveTo:location duration:0.5];
            [hull runAction:moveto withKey:@"touchMove"];
        }
    }
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (isEnd==1) {
        
    }else{
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            SKAction *moveto = [SKAction moveTo:location duration:0.6];
            [hull runAction:moveto withKey:@"touchMove"];
        }
    }
}

-(void)update:(CFTimeInterval)currentTime{
    if (isEnd==1) {
        
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
    
    gameOverView=[[SKSpriteNode alloc]initWithColor:[SKColor colorWithRed:0 green:0 blue:0 alpha:0.8] size:CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height)];
    gameOverView.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    [self addChild:gameOverView];
    
    SKLabelNode *gameOverLabel=[SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    gameOverLabel.text=@"Your Score";
    gameOverLabel.fontSize=30;
    gameOverLabel.position=CGPointMake(0, 100);
    [gameOverView addChild:gameOverLabel];
    
    if (gameTime>[[[NSUserDefaults standardUserDefaults] objectForKey:@"BEST"]intValue]) {
        NSLog(@"newRecord");
        
        SKLabelNode *newLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        newLabel.text = @"New Record~";
        newLabel.fontSize = 20;
        newLabel.position = CGPointMake(0,150);
        newLabel.color=[SKColor redColor];
        
        SKAction *fadeAction=[SKAction sequence:@[
                                                  [SKAction fadeOutWithDuration:0.5],
                                                  [SKAction fadeInWithDuration:0.5]]];
        [newLabel runAction:[SKAction repeatActionForever:fadeAction]];
        [gameOverView addChild:newLabel];
        
        [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%d",gameTime] forKey:@"BEST"];
    }
    
    
    retryButton=[UIButton buttonWithType:UIButtonTypeCustom];
    retryButton.frame=CGRectMake(100, 400, 120, 50);
    retryButton.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:retryButton];
    [retryButton addTarget:self action:@selector(retryButton) forControlEvents:UIControlEventTouchUpInside];

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
}

@end
