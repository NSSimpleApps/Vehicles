//
//  ContainerViewCell.m
//  Vehicles
//
//  Created by NSSimpleApps on 10.07.16.
//  Copyright © 2016 NSSimpleApps. All rights reserved.
//

#import "ContainerViewCell.h"

@implementation ContainerViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.textLabel.numberOfLines = 1;
        self.textLabel.adjustsFontSizeToFitWidth = YES;
        self.textLabel.minimumScaleFactor = 0.25;
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    return self;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect textLabelFrame = self.textLabel.frame;
    self.textLabel.frame = CGRectMake(textLabelFrame.origin.x,
                                      textLabelFrame.origin.y,
                                      self.bounds.size.width * 0.25,
                                      textLabelFrame.size.height);
        
    self.accessoryView.frame = CGRectMake(CGRectGetMaxX(self.textLabel.frame) + 8,
                                          4,
                                          CGRectGetMaxX(self.bounds) - 8 - (CGRectGetMaxX(self.textLabel.frame) + 8),
                                          self.bounds.size.height - 4 - 4);
}

@end
