//
//  ViewController.m
//  Sk
//
//  Created by apple on 11/9/14.
//  Copyright (c) 2014 ___GWH___. All rights reserved.
//

#import "ViewController.h"
#import "MyScene.h"

@implementation ViewController

UILabel *nameLabel;

- (BOOL)prefersStatusBarHidden{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    nameLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, 30, 300, 80)];
    nameLabel.font=[UIFont fontWithName:@"DFGirlKelvin" size:40];
    [self.view addSubview:nameLabel];
    nameLabel.numberOfLines=2;
    nameLabel.textAlignment=NSTextAlignmentCenter;//直到我膝盖\n中了一箭
    [nameLabel setText:NSLocalizedString(@"Run! Soul", ok)];
    nameLabel.backgroundColor=[UIColor clearColor];
    nameLabel.textColor=[UIColor brownColor];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(nameHide:) name:@"nameHide" object:nil];
}
- (void)nameHide:(NSNotification*)notification{
    id obj = [notification object];
    if ([obj isEqualToString:@"Hide"]){
        nameLabel.hidden=YES;
    }else if ([obj isEqualToString:@"HideNo"]){
        nameLabel.hidden=NO;
    }
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
