//
//  HDInputView.h
//  NBAppKeyboard
//
//  Created by Sujan Reddy on 14/02/18.
//  Copyright © 2018 Innovation Makers. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDInputView : UIView
@property UIView *inputView;
@property (strong, nonatomic) IBOutlet UILabel *numLbl1;
@property (strong, nonatomic) IBOutlet UILabel *numLbl2;
@property (strong, nonatomic) IBOutlet UILabel *numLbl3;
@property (strong, nonatomic) IBOutlet UILabel *numLbl4;

@property (strong, nonatomic) IBOutlet UIImageView *dotImg1;
@property (strong, nonatomic) IBOutlet UIImageView *dotImg2;
@property (strong, nonatomic) IBOutlet UIImageView *dotImg3;
@property (strong, nonatomic) IBOutlet UIImageView *dotImg4;
@property (strong, nonatomic) IBOutlet UILabel *showErrorLbl;


- (void)inputAuthDidAcceptCandidate:(NSString *)candidate isPinEnable:(BOOL)pinEnable;
- (void)inputAuthDidInputDelete;
@end
