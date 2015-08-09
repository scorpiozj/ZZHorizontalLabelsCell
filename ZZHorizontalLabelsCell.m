//
//  ZZHorizontalLabelCell.m
//  CellLabelsLayoutCollection
//
//  Created by ZhuJiang on 15/8/2.
//  Copyright (c) 2015年 Charles Zhu. All rights reserved.
//

#import "ZZHorizontalLabelsCell.h"

// layout parameters
#define     kEdgeInsetTop           (5.0)
#define     kEdgeInsetLeft          (10.0)
#define     kEdgeInsetBottom        (5.0)
#define     kEdgeInsetRight         (5.0)
#define     kLabelPadding           (5.0)

#define     kLeftLabelWidth         (110.0)



@interface ZZHorizontalLabelsCell ()
{
    ZZHorizonLayout horizonLayout;
    UIEdgeInsets edgeInstets;
    CGFloat leftWidth;
    CGFloat padding;
}
@end


@implementation ZZHorizontalLabelsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier horozonLayout:(ZZHorizonLayout)layout
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        horizonLayout = layout;
        edgeInstets = UIEdgeInsetsMake(kEdgeInsetTop, kEdgeInsetLeft, kEdgeInsetBottom, kEdgeInsetRight);
        leftWidth = kLeftLabelWidth;
        padding = kLabelPadding;
        
        [self p_addSubviews];
        [self p_addConstraints];
    }
    return self;
}
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier layoutType:(ZZHorizonLayout)layout contentInset:(UIEdgeInsets)inset padding:(CGFloat)paddingLen leftPreferredWidth:(CGFloat)lWidth
{
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier])
    {
        horizonLayout = layout;
        edgeInstets = inset;
        leftWidth = lWidth;
        padding = paddingLen;
    
        [self p_addSubviews];
        [self p_addConstraints];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        
    }
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.labelLeft.preferredMaxLayoutWidth = leftWidth;
    self.labelRight.preferredMaxLayoutWidth = CGRectGetWidth(self.bounds) - edgeInstets.left - leftWidth - padding - edgeInstets.right ;
}

#pragma mark - Private
- (void)p_addSubviews
{
    UILabel *lLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelLeft = lLabel;
    [self.contentView addSubview:lLabel];
    self.labelLeft.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelLeft.numberOfLines = 0;
    
    UILabel *rLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.labelRight = rLabel;
    [self.contentView addSubview:rLabel];
    self.labelRight.translatesAutoresizingMaskIntoConstraints = NO;
    self.labelRight.numberOfLines = 0;
    
#ifdef DEBUG
    self.labelLeft.backgroundColor = [UIColor redColor];
    self.labelRight.backgroundColor = [UIColor blueColor];
#endif
}
- (void)p_addConstraints
{
    switch (horizonLayout)
    {
        case ZZHorizonLayoutCenter:
        {
            NSLayoutConstraint *leftLabelLeading = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:edgeInstets.left];
            NSLayoutConstraint *leftLabelTop = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *leftLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            NSLayoutConstraint *leftLabelWidth = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0 constant:leftWidth];
            
            NSLayoutConstraint *labelPadding = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:padding];
            
            NSLayoutConstraint *rightLabelTop = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *rightLabelTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:edgeInstets.right];
            NSLayoutConstraint *rightLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow  forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow  forAxis:UILayoutConstraintAxisVertical];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow forAxis:UILayoutConstraintAxisVertical];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            [self.contentView addConstraints:@[leftLabelLeading, leftLabelTop, leftLabelBottom, leftLabelWidth, labelPadding, rightLabelTop, rightLabelTrailing, rightLabelBottom]];

           break;
        }
        case ZZHorizonLayoutBottom:
        {
            NSLayoutConstraint *leftLabelLeading = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:edgeInstets.left];
            NSLayoutConstraint *leftLabelTop = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *leftLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            NSLayoutConstraint *leftLabelWidth = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0 constant:leftWidth];
            
            NSLayoutConstraint *labelPadding = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:padding];
            
            NSLayoutConstraint *rightLabelTop = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *rightLabelTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:edgeInstets.right];
            NSLayoutConstraint *rightLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow +1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow + 1  forAxis:UILayoutConstraintAxisVertical];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow + 1  forAxis:UILayoutConstraintAxisVertical];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            [self.contentView addConstraints:@[leftLabelLeading, leftLabelTop, leftLabelBottom, leftLabelWidth, labelPadding, rightLabelTop, rightLabelTrailing, rightLabelBottom]];

            break;
        }
        case ZZHorizonLayoutTop:
        {
            NSLayoutConstraint *leftLabelLeading = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeLeading multiplier:1.0 constant:edgeInstets.left];
            NSLayoutConstraint *leftLabelTop = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *leftLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationGreaterThanOrEqual toItem:self.labelLeft attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            NSLayoutConstraint *leftLabelWidth = [NSLayoutConstraint constraintWithItem:self.labelLeft attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:.0 constant:leftWidth];
            
            NSLayoutConstraint *labelPadding = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.labelLeft attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:padding];
            
            NSLayoutConstraint *rightLabelTop = [NSLayoutConstraint constraintWithItem:self.labelRight attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.contentView attribute:NSLayoutAttributeTop multiplier:1.0 constant:edgeInstets.top];
            NSLayoutConstraint *rightLabelTrailing = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeTrailing multiplier:1.0 constant:edgeInstets.right];
            NSLayoutConstraint *rightLabelBottom = [NSLayoutConstraint constraintWithItem:self.contentView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.labelRight attribute:NSLayoutAttributeBottom multiplier:1.0 constant:edgeInstets.bottom];
            rightLabelBottom.priority = UILayoutPriorityDefaultLow - 1;
            
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow  forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentHuggingPriority:UILayoutPriorityDefaultLow + 1  forAxis:UILayoutConstraintAxisVertical];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelLeft setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentHuggingPriority:UILayoutPriorityDefaultLow + 1 forAxis:UILayoutConstraintAxisVertical];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisHorizontal];
            [self.labelRight setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh + 1 forAxis:UILayoutConstraintAxisVertical];
            [self.contentView addConstraints:@[leftLabelLeading, leftLabelTop, leftLabelBottom, leftLabelWidth, labelPadding, rightLabelTop, rightLabelTrailing, rightLabelBottom]];
            break;
        }
        default:
            break;
    }
}
@end
