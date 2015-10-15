//
//  TLScrollVIew.m
//  旅行
//
//  Created by 磊 田 on 15/9/19.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "TLScrollVIew.h"
#import "MainCollectionModel.h"
#import "CollectionModel.h"

#import "TopSelectionModel.h"
@implementation TLScrollVIew
{
    
    NSInteger last;

}
-(void)dealloc
{
    [_timer invalidate];
    NSLog(@"定时器销毁");

}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        last = 0;
        self.pagingEnabled = YES;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.userInteractionEnabled = NO;
       
 
         }
    return self;
}

-(void)scrollAction
{
    
    if (last < _pageNum) {
        [self setContentOffset:CGPointMake(last*kScreenWidth, 0) animated:YES];

        last ++;
    }else
    {
        last = 0;
    
    }
    
    
}

-(void)setMainCollectionModel:(MainCollectionModel *)mainCollectionModel
{
    if (mainCollectionModel != nil) {
        _mainCollectionModel = mainCollectionModel;
    
    NSMutableArray *urlArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
    NSMutableArray *titleArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
    NSMutableArray *subTitleArray = [[NSMutableArray alloc]initWithCapacity:_mainCollectionModel.collectionArray.count];
    
    for (CollectionModel *tempModel in  _mainCollectionModel.collectionArray) {
        
        NSString *str = tempModel.bg_pic[0];
        
        if ([tempModel.title_notshown  isEqual: @0]) {
            
            NSString *str1 = tempModel.title;
            NSString *str2 = tempModel.sub_title;
            
            [titleArray addObject:str1];
            [subTitleArray addObject:str2];
            
        }
        
        [urlArray addObject:str];
        
    }
    
    self.titleArray = titleArray;
    self.subTitleArray = subTitleArray;
    self.URLArray = urlArray;
    
}



}


-(void)setURLArray:(NSArray *)URLArray
{
    _URLArray = URLArray;
    _pageNum = _URLArray.count;
   
    for (int i = 0; i < _pageNum; i ++) {
        
        self.contentSize = CGSizeMake(_pageNum * kScreenWidth, 0);

        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(i*kScreenWidth, 0, kScreenWidth, bigImageHeight)];
        NSURL *url = [NSURL URLWithString:_URLArray[i]];
        imgView.contentMode =  UIViewContentModeScaleToFill;
        [imgView  sd_setImageWithURL:url  placeholderImage:[UIImage imageNamed:@"home_prospect_tb.png"]];
        
        //有标题添加标题
        UILabel *lableTitle = nil;
        if (_titleArray.count != 0) {
            //添加图片上的标题
            
            lableTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, bigImageHeight*2/5, kScreenWidth, 35)];
            lableTitle.textColor = [UIColor whiteColor];
            lableTitle.backgroundColor = [UIColor clearColor];
            lableTitle.font = [UIFont boldSystemFontOfSize:25];
            //        lableTitle.font = [UIFont systemFontOfSize:20 weight:10];

         lableTitle.text = _titleArray[i];
            
            lableTitle.textAlignment = NSTextAlignmentCenter;
            [imgView addSubview:lableTitle];

        }
    
         CGFloat y = CGRectGetMaxY(lableTitle.frame);
        //有子标题添加子标题
        if (_subTitleArray.count != 0) {
               
               
               UILabel *lableSub = [[UILabel alloc]initWithFrame:CGRectMake(0, y, kScreenWidth, 20)];
               lableSub.textColor = [UIColor whiteColor];
               lableSub.backgroundColor = [UIColor clearColor];
               lableSub.textAlignment = NSTextAlignmentCenter;
               lableSub.font = [UIFont boldSystemFontOfSize:15];
               //是否加载图片文字

               lableSub.text = _subTitleArray[i];
               
               [imgView addSubview:lableSub];
       }
       
        

        
        
        [self addSubview:imgView];
    }
    
    if (_URLArray.count > 1) {
        
         _timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(scrollAction) userInfo:nil repeats:YES];
    }
   
    
}
@end
