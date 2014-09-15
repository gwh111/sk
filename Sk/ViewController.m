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
GADBannerView *banner;
GADInterstitial *bigBanner;

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
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(ad:) name:@"adShow" object:nil];
    
    banner = [[GADBannerView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - GAD_SIZE_320x50.height, GAD_SIZE_320x50.width, GAD_SIZE_320x50.height)];
    banner.adUnitID = @"ca-app-pub-5564518885724507/6465984870";
    banner.rootViewController = self;
    [self.view addSubview:banner];
    [banner loadRequest:[GADRequest request]];
//    GADRequest *request;
//    request.testDevices = @[ GAD_SIMULATOR_ID, @"MY_TEST_DEVICE_ID" ];
    banner.delegate=self;
    banner.hidden=YES;
}
- (void)interstitialDidReceiveAd:(GADInterstitial *)interstitial {
    [interstitial presentFromRootViewController:self];
}
- (void)nameHide:(NSNotification*)notification{
    id obj = [notification object];
    if ([obj isEqualToString:@"Hide"]){
        nameLabel.hidden=YES;
    }else if ([obj isEqualToString:@"HideNo"]){
        nameLabel.hidden=NO;
    }
}

- (void)ad:(NSNotification*)notification{
    id obj = [notification object];
    if ([obj isEqualToString:@"adShow"]){
        banner.hidden=NO;
    }else if ([obj isEqualToString:@"adHide"]){
        banner.hidden=YES;
    }else if ([obj isEqualToString:@"adLarge"]){
        NSLog(@"large");
        bigBanner=[[GADInterstitial alloc]init];
        bigBanner.adUnitID=@"ca-app-pub-5564518885724507/7663516475";
        [bigBanner loadRequest:[GADRequest request]];
        bigBanner.delegate=self;
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
