//
//  CollectionCell1.m
//  tianleilnl
//
//  Created by 磊 田 on 15/10/11.
//  Copyright © 2015年 tianLei. All rights reserved.
//

#import "CollectionCell1.h"

#import "MainCollectionModel.h"
#import "TLScrollVIew.h"
#import "CollectionModel.h"
@interface CollectionCell1()




@end
@implementation CollectionCell1

+ (instancetype)createCelllWithTableView:(UITableView *)tableView
{
    CollectionCell1 *cell = [tableView dequeueReusableCellWithIdentifier:@"ccCell"];
//    cell.scrollV = nil;
    if (cell == nil) {
        
        cell= [[CollectionCell1 alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ccCell"];
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        
        
    }
    
    return self;
    
}

-(void)setSelectFrame:(SelectFrame *)selectFrame
{
  
    TLScrollVIew *s = [[TLScrollVIew alloc]initWithFrame:CGRectZero];
    if (_scrollV == nil) {
        NSLog(@"_scrollV为空");
        [self addSubview:s];
        _scrollV = s;
    }

    _selectFrame = selectFrame;
//    [_scrollV.timer invalidate];
//    _scrollV = nil;
    _scrollV.frame = _selectFrame.scrrollFrame;

    MainCollectionModel *mColModel =_selectFrame.mainCM;
    _scrollV.mainCollectionModel = mColModel;
    [self MainCollectionModel:mColModel];
    
    
    
}
-(void)MainCollectionModel:(MainCollectionModel *)mainCollectionModel
{
    //    if (mainCollectionModel != nil) {
    mainCollectionModel = mainCollectionModel;
    
    NSMutableArray *urlArray = [[NSMutableArray alloc]initWithCapacity:mainCollectionModel.collectionArray.count];
    
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:mainCollectionModel.collectionArray.count];
    
    NSMutableArray *subTitleArray = [[NSMutableArray alloc]initWithCapacity:mainCollectionModel.collectionArray.count];
    
    for (CollectionModel *tempModel in  mainCollectionModel.collectionArray) {
        
        NSString *str = tempModel.bg_pic[0];
        
        //        if ([tempModel.title_notshown  isEqual: @0]) {
        
        NSString *str1 = tempModel.title;
        NSString *str2 = tempModel.sub_title;
        
        [titleArray addObject:str1];
        [subTitleArray addObject:str2];
        
        //        }
        
        [urlArray addObject:str];
        
    }
    
    _scrollV.titleArray = titleArray;
    _scrollV.subTitleArray = subTitleArray;
    _scrollV.URLArray = urlArray;
    
    //}
    
    
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
