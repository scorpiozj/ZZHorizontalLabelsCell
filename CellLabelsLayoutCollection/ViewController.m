//
//  ViewController.m
//  CellLabelsLayoutCollection
//
//  Created by ZhuJiang on 15/8/2.
//  Copyright (c) 2015年 Charles Zhu. All rights reserved.
//

#import "ViewController.h"
#import "ZZHorizontalLabelsCell.h"

NSString *leftKey   = @"leftKey";
NSString *rightKey  = @"rightKey";
static NSString *kCellIdentifier = @"kCellIdentifier";
@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
{
    ZZHorizonLayout layoutCell;
}
@property (nonatomic, strong) NSMutableArray *mArray;
@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.mArray = [NSMutableArray arrayWithCapacity:3];
    [self.mArray addObject:@{leftKey:@"中文标题 测试类型",rightKey:@"很多内容很多内容 测试自适应"}];
    [self.mArray addObject:@{leftKey:@"Eng title time start",rightKey:@"2015-08-01 17:10:01"}];
    [self.mArray addObject:@{leftKey:@"Code number",rightKey:@"ECH0089375"}];
    [self.mArray addObject:@{leftKey:@"Code number ",rightKey:@"ECH0089375 2015 08 01 17:10"}];
    
    
#warning - Testing here
    layoutCell = ZZHorizonLayoutTop;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static ZZHorizontalLabelsCell *cell = nil;
    if (!cell)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
        if (!cell)
        {
            cell = [[ZZHorizontalLabelsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier horozonLayout:layoutCell];
        }
    }
    NSDictionary *dic = self.mArray[indexPath.row];
    cell.labelLeft.text = dic[leftKey];
    cell.labelRight.text = dic[rightKey];
    [cell updateConstraintsIfNeeded];
    [cell layoutIfNeeded];
    [cell setNeedsLayout];
    [cell layoutIfNeeded];
    
    CGSize heightSize = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return heightSize.height + 1.0f;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZZHorizontalLabelsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (!cell)
    {
        cell = [[ZZHorizontalLabelsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier horozonLayout:layoutCell];
    }
    NSDictionary *dic = self.mArray[indexPath.row];
    cell.labelLeft.text = dic[leftKey];
    cell.labelRight.text = dic[rightKey];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
