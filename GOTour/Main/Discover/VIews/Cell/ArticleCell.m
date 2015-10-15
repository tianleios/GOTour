//
//  ArticleCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/7.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ArticleCell.h"
#import "TLScrollVIew.h"

#import "ArticleModel.h"
@interface ArticleCell ()


@end
@implementation ArticleCell
+(instancetype)createCelllWithReusableID:(NSString *)ID articles:(NSArray *)articles collectionView:(UICollectionView *)collectionView indexPath:(NSIndexPath *)indexPath
{
    ArticleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:ID forIndexPath:indexPath];
    cell.articles = articles;
    return cell;

}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _scrollView = [[TLScrollVIew alloc]initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.userInteractionEnabled = YES;
        [self.contentView addSubview:_scrollView];
        
        _pageControl = [[UIPageControl alloc]init];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        [self.contentView addSubview:_pageControl];
    }
    return self;
}

-(void)setArticles:(NSArray *)articles
{
    _articles = articles;

    NSMutableArray *urlStrings = [[NSMutableArray alloc]initWithCapacity:_articles.count];
    for (ArticleModel *model in articles) {
        
        NSString *str = model.bg_pic;

        [urlStrings addObject:str];
    }
     _scrollView.URLArray = urlStrings;
    CGSize size = [_pageControl sizeForNumberOfPages:articles.count];
    _pageControl.frame = CGRectMake(self.frame.size.width/2 - size.width/2, self.frame.size.height - 40, size.width, 40);
    _pageControl.numberOfPages = _articles.count;
    _pageControl.currentPage = _scrollView.contentOffset.x/_scrollView.frame.size.width;
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    _pageControl.currentPage = offSetX/_scrollView.frame.size.width;
    _numPage = _pageControl.currentPage;
}
@end
