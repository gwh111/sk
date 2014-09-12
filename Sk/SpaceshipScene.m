//
//  SpaceshipScene.m
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import "SpaceshipScene.h"

static const uint32_t hullCategory     =  0x1 << 0;
static const uint32_t rockCategory        =  0x1 << 1;

@implementation SpaceshipScene

SKSpriteNode *hull;

-(id)initWithSize:(CGSize)size

{
    
    if (self = [super initWithSize:size])
        
    {
        
        self.physicsWorld.contactDelegate = self;
        NSLog(@"iii");
    }
    
    return self;
    
}

- (void)didMoveToView:(SKView *)view{
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated=YES;
        self.physicsWorld.contactDelegate=self;
        self.physicsWorld.gravity = CGVectorMake(0,-1);
    }
}

- (void)createSceneContents{
    
    self.backgroundColor=[SKColor blackColor];
    self.scaleMode=SKSceneScaleModeAspectFit;
    
    SKSpriteNode *spaceship=[self newSpaceship];
    spaceship.position=CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150);
    [self addChild:spaceship];

    SKAction *makeRocks=[SKAction sequence:@[
                                             [SKAction performSelector:@selector(addRock) onTarget:self],
                                             [SKAction waitForDuration:0.5 withRange:0.15]]];
    [self runAction:[SKAction repeatActionForever:makeRocks]];
    
}

- (SKSpriteNode*)newSpaceship{
    hull=[[SKSpriteNode alloc]initWithColor:[SKColor grayColor] size:CGSizeMake(64, 32)];
    
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
    return rand() / (CGFloat) RAND_MAX;
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

- (void)didSimulatePhysics{
    [self enumerateChildNodesWithName:@"rock" usingBlock:^(SKNode *node, BOOL *stop){
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
        [secondBody.node removeFromParent];
        SKAction *pluseRed=[SKAction sequence:@[
                                                [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.5 duration:0.2],
                                                [SKAction waitForDuration:0.1],
                                                [SKAction colorizeWithColor:[SKColor grayColor] colorBlendFactor:0.5 duration:0.2],
                                                [SKAction colorizeWithColorBlendFactor:0.0 duration:0.2]]];
        [hull runAction:pluseRed];
        NSLog(@"0");
    }
                        
}
- (void)didEndContact:(SKPhysicsContact *)contact{
    NSLog(@"end");
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKAction *moveto = [SKAction moveTo:location duration:1];
        [hull runAction:moveto];
    }
}

@end
