//
//  PropertyInfoCell.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "PropertyInfoCell.h"

@interface PropertyInfoCell ()

@property (strong, readwrite) UILabel *label;

@end

@implementation PropertyInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(8, 11, 42, 21)];
        self.label.translatesAutoresizingMaskIntoConstraints = NO;
        self.label.numberOfLines = 1;
        self.label.adjustsFontSizeToFitWidth = YES;
        self.label.minimumScaleFactor = 0.25;
        self.label.textAlignment = NSTextAlignmentLeft;
        self.label.lineBreakMode = NSLineBreakByClipping;
        
        [self.contentView addSubview:self.label];
        
        NSLayoutConstraint *c1 =
        [NSLayoutConstraint constraintWithItem:self.contentView
                                     attribute:NSLayoutAttributeLeadingMargin
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.label
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:0];
        NSLayoutConstraint *c2 =
        [NSLayoutConstraint constraintWithItem:self.label
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1
                                      constant:0];
        NSLayoutConstraint *c3 =
        [NSLayoutConstraint constraintWithItem:self.label
                                     attribute:NSLayoutAttributeWidth
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:self.contentView
                                     attribute:NSLayoutAttributeWidth
                                    multiplier:0.25
                                      constant:0];
        
        [NSLayoutConstraint activateConstraints:@[c1, c2, c3]];
    }
    
    return self;
}

- (void)updateConstraintsForRightView:(UIView *)rightView {
    
    rightView.translatesAutoresizingMaskIntoConstraints = NO;
    
    //[self.contentView addSubview:rightView];
    
    NSLayoutConstraint *c1 =
    [NSLayoutConstraint constraintWithItem:rightView
                                 attribute:NSLayoutAttributeLeading
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.label
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:8];
    NSLayoutConstraint *c2 =
    [NSLayoutConstraint constraintWithItem:rightView
                                 attribute:NSLayoutAttributeCenterY
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:self.contentView
                                 attribute:NSLayoutAttributeCenterY
                                multiplier:1
                                  constant:0];
    NSLayoutConstraint *c3 =
    [NSLayoutConstraint constraintWithItem:self.contentView
                                 attribute:NSLayoutAttributeTrailingMargin
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:rightView
                                 attribute:NSLayoutAttributeTrailing
                                multiplier:1
                                  constant:0];
    
    [NSLayoutConstraint activateConstraints:@[c1, c2, c3]];
}

- (void)setRightView:(UIView *)rightView {
    
    if (![rightView isEqual:_rightView]) {
        
        if (rightView == nil) {
            
            [self.contentView removeConstraints:_rightView.constraints];
            
            [_rightView removeFromSuperview];
            _rightView = nil;
            
        } else {
            
            _rightView = rightView;
            
            [self.contentView addSubview:rightView];
            [self updateConstraintsForRightView:rightView];
            
            [self updateConstraints];
        }
    }
}

@end
