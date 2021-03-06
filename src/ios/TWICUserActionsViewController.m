//
//  TWICUserActionsViewController.m
//  TWICDemoApp
//
//  Created by Emmanuel Castellani on 07/04/2017.
//
//

#import "TWICUserActionsViewController.h"
#import "TWICConstants.h"
#import "TWICTokClient.h"

@interface TWICUserActionsViewController ()
@property (weak, nonatomic) IBOutlet UIView *microphoneView;
@property (weak, nonatomic) IBOutlet UIImageView *microphoneImageView;
@property (weak, nonatomic) IBOutlet UILabel *microphoneTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *microphoneSubtitleLabel;

@property (weak, nonatomic) IBOutlet UIView *cameraView;
@property (weak, nonatomic) IBOutlet UIImageView *cameraImageView;
@property (weak, nonatomic) IBOutlet UILabel *cameraTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cameraSubtitleLabel;

@property (weak, nonatomic) IBOutlet UIView *rotateView;
@property (weak, nonatomic) IBOutlet UILabel *rotateTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotateSubtitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *rotateImageView;

@property (weak, nonatomic) IBOutlet UIView *stopView;
@property (weak, nonatomic) IBOutlet UIImageView *stopImageView;
@property (weak, nonatomic) IBOutlet UILabel *stopTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *stopSubtitleLabel;

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *actionViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *actionSubtitleLabels;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *actionImageViews;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *actionTitleLabels;


@end

@implementation TWICUserActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureSkin];
    [self configureLocalizable];
}

-(void)configureSkin{
    [self.actionTitleLabels enumerateObjectsUsingBlock:^(UILabel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.font = [UIFont boldSystemFontOfSize:13];
        obj.textColor = TWIC_COLOR_BLACK;
    }];
    [self.actionSubtitleLabels enumerateObjectsUsingBlock:^(UILabel * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.font = [UIFont systemFontOfSize:11];
        obj.textColor = TWIC_COLOR_BLACK;
    }];
}

-(void)configureLocalizable{
    self.microphoneTitleLabel.text = @"Microphone";
    self.microphoneSubtitleLabel.text = @"Turn Off";
    
    self.cameraTitleLabel.text = @"Camera";
    self.cameraSubtitleLabel.text = @"Turn On";
    
    self.rotateTitleLabel.text = @"Rotate";
    self.rotateSubtitleLabel.text = @"Front Camera";
    
    self.stopTitleLabel.text = @"Stop";
    self.stopSubtitleLabel.text = @"Your Stream";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.microphoneSubtitleLabel.text = [TWICTokClient sharedInstance].publisher.publishAudio ? @"Turn Off" : @"Turn On";
    self.cameraSubtitleLabel.text = [TWICTokClient sharedInstance].publisher.publishVideo ? @"Turn Off" : @"Turn On";
    if([TWICTokClient sharedInstance].publisher.cameraPosition == AVCaptureDevicePositionFront)
    {
        self.rotateSubtitleLabel.text = @"Back Camera";
    }else{
        self.rotateSubtitleLabel.text = @"Front Camera";
    }
}

- (IBAction)microphone:(id)sender {
    [self.delegate TWICUserActionsViewController:self didTouchAction:CurrentUserActionTypeMicrophone];
}
- (IBAction)camera:(id)sender {
    [self.delegate TWICUserActionsViewController:self didTouchAction:CurrentUserActionTypeCamera];
}
- (IBAction)rotate:(id)sender {
    [self.delegate TWICUserActionsViewController:self didTouchAction:CurrentUserActionTypeRotate];
}
- (IBAction)stop:(id)sender {
    [self.delegate TWICUserActionsViewController:self didTouchAction:CurrentUserActionTypeStop];
}

@end
