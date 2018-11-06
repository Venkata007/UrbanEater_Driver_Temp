//
//  HDInputView.m
//  NBAppKeyboard
//
//  Created by Sujan Reddy on 14/02/18.
//  Copyright © 2018 Innovation Makers. All rights reserved.
//

#import "HDInputView.h"

@interface HDInputView ()
{
    NSInteger selectedMatixIndex;
    NSString *matrix1;
    NSString *matrix2;
    NSString *matrix3;
    NSString *matrix4;
}
@end

@implementation HDInputView

- (id)init
{
    if(self = [super init]) {
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame])
    {
        [self setupXIB];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if(self = [super initWithCoder:aDecoder]) {
        [self setupXIB];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
}

- (void)setupXIB {
    
    self.inputView = [[[NSBundle bundleForClass:[self class]]loadNibNamed:@"HDInputView" owner:self options:nil]objectAtIndex:0];
    
    self.inputView.frame =  self.bounds;
    self.inputView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight ;
    [self addSubview:self.inputView];
}

- (void)inputAuthDidAcceptCandidate:(NSString *)candidate isPinEnable:(BOOL)pinEnable{
    
    if (matrix1.length && matrix2.length && matrix3.length &&  matrix4.length && selectedMatixIndex == 95)
        return;
    
    if (selectedMatixIndex == 0)
        selectedMatixIndex = 91;
    
     [self updateMartixInputLabelAndFoucsImagesWithString:candidate pinEnable:pinEnable];
}

- (void)inputAuthDidInputDelete {
    if (selectedMatixIndex == 0)
        return;
    
    switch (selectedMatixIndex) {
        case 92:
        {
            matrix1 = @"";
            self.numLbl1.text = matrix1;
            self.dotImg1.image = [UIImage imageNamed:@""];
            selectedMatixIndex = 91;
            
        }
            break;
        case 93:
        {
            matrix2 = @"";
            self.numLbl2.text = matrix2;
            self.dotImg2.image = [UIImage imageNamed:@""];
            selectedMatixIndex = 92;
        }
            break;
        case 94:
            matrix3 = @"";
            self.numLbl3.text = matrix3;
            self.dotImg3.image = [UIImage imageNamed:@""];
            selectedMatixIndex = 93;
            break;
        case 95:
            matrix4 = @"";
            self.numLbl4.text = matrix4;
            self.dotImg4.image = [UIImage imageNamed:@""];
            selectedMatixIndex = 94;
            break;
            
        default:
            break;
    }
}

-(void)updateMartixInputLabelAndFoucsImagesWithString:(NSString*)inputStr pinEnable:(BOOL)isPinEnabled{
    
    switch (selectedMatixIndex) {
        case 91:
        {
            matrix1 = inputStr;
            if (isPinEnabled) {
                self.numLbl1.text = matrix1;
            }else{
                self.dotImg1.image = [UIImage imageNamed:@"dot_HD"];
            }
            selectedMatixIndex = 92;
            
        }
            break;
        case 92:
        {
            matrix2 = inputStr;
            if (isPinEnabled) {
               self.numLbl2.text = matrix2;
            }else{
               self.dotImg2.image = [UIImage imageNamed:@"dot_HD"];
            }
            selectedMatixIndex = 93;
        }
            break;
        case 93:
        {
            matrix3 = inputStr;
            if (isPinEnabled) {
                self.numLbl3.text = matrix3;
            }else{
                self.dotImg3.image = [UIImage imageNamed:@"dot_HD"];
            }
            selectedMatixIndex = 94;

        }
            break;
        case 94:
        {
            matrix4 = inputStr;
            if (isPinEnabled) {
                self.numLbl4.text = matrix4;
            }else{
                self.dotImg4.image = [UIImage imageNamed:@"dot_HD"];
            }
            selectedMatixIndex = 95;
//                        [self.matrixAuthDelegate matrixAuthnticationDidCompleted:self
//                                                                         Matrix1:matrix1
//                                                                         Matrix2:matrix2
//                                                                         Matrix3:matrix3
//                                                                         Matrix3:matrix4];
        }
            break;
            
            
        default:
            break;
    }
    
}

@end
