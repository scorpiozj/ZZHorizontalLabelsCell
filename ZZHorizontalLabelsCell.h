//
//  ZZHorizontalLabelCell.h
//  CellLabelsLayoutCollection
//
//  Created by ZhuJiang on 15/8/2.
//  Copyright (c) 2015年 Charles Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

//iOS system
#define IOS7_OR_LATER               ([[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define IOS8_OR_LATER               ([[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )

/**
 ZZHorizonLayout : layout(mainly aliment of 2 labels) type of text alignments
 
 */

typedef enum : NSUInteger {
    ZZHorizonLayoutTop,/*align 2 text top */
    ZZHorizonLayoutCenter,/*align 2 text center */
    ZZHorizonLayoutBottom,/*align 2 text bottom */
} ZZHorizonLayout;


/**
 ZZHorizontalLabelsCell:
 1. layout
 leftLabel rightLabel
 2. both label can be multiline
 3. cell automatic adjust height
 */

@interface ZZHorizontalLabelsCell : UITableViewCell

@property (weak, nonatomic) UILabel *labelLeft;
@property (weak, nonatomic) UILabel *labelRight;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier horozonLayout:(ZZHorizonLayout)layout;
@end
