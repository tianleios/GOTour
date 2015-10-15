//
//  ExpenseCell.m
//  旅行
//
//  Created by 磊 田 on 15/10/5.
//  Copyright (c) 2015年 tianLei. All rights reserved.
//

#import "ExpenseCell.h"
#import "ExpenseModel.h"
#import "NSString+Ext.h"
@interface ExpenseCell ()

@property (nonatomic, strong) NSArray *expense;

@end
@implementation ExpenseCell
{
    UILabel *_Lbl;

}
+ (instancetype)createCellWith:(DetailBootomCellFrame *)frameModel
{
    ExpenseCell *cell = [[ExpenseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.frameModel = frameModel;
    
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:nil]) {
        
        _Lbl = [[UILabel alloc]initWithFrame:self.frame];
        [self addSubview:_Lbl];
        _Lbl.numberOfLines = 0;
        _Lbl.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    return self;
}

-(void)setFrameModel:(DetailBootomCellFrame *)frameModel
{
    _frameModel = frameModel;
    _Lbl.frame = _frameModel.expenseCellFrame;
    _Lbl.text = _frameModel.expenseStr;


}
//-(void)setExpense:(NSArray *)expense
//{
//    _expense = expense;
//    //字符串的拼接
//    NSMutableString *string = [NSMutableString string];
//    for (ExpenseModel *model in expense) {
//        
//        [string appendString:model.group];
//        [string appendString:@"\n"];
//        
//        for (NSString *str in model.content) {
//            [string appendString:str];
//            [string appendString:@"\n"];
//        }
//    }
//    
// CGSize size = [NSString calculateStringSize:CGSizeMake(kScreenWidth - 40, MAXFLOAT) string:string font:[UIFont systemFontOfSize:15]];
//    CGFloat y = size.height + 20;
//    _Lbl.frame = CGRectMake(20, 10, kScreenWidth - 40, y);
//}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
