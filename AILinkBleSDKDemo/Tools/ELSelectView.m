//
//  ELSelectView.m
//  Elink
//
//  Created by iot_user on 2019/1/23.
//  Copyright © 2019年 iot_iMac. All rights reserved.
//

#import "ELSelectView.h"
#import "CABasicAnimation+ELAnimation.h"
#import "UILabel+WZAdd.h"
#import "Masonry.h"
#import "UIButton+WZAdd.h"
#import "AppDelegate.h"

//375x667的屏幕
#define ScreenH            [UIScreen mainScreen].bounds.size.height
#define ScreenW             [UIScreen mainScreen].bounds.size.width

#define MaxHeight ScreenH/2
#define MaxWeight 250
#define CellHeight 45

@implementation ELSelectViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style
                    reuseIdentifier:reuseIdentifier]) {
        self.titleLbl = [UILabel createWithFrame:CGRectZero bgColor:[UIColor whiteColor] text:nil textColor:[UIColor grayColor] font:[UIFont systemFontOfSize:18] align:NSTextAlignmentCenter];
        self.titleLbl.numberOfLines=0;
        self.titleLbl.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:self.titleLbl];
        [self.titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

@end

static NSString * ELSelectViewCellid = @"ELSelectViewCellid";

@interface ELSelectView()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) UIView *alertView;

@property (nonatomic, copy) NSArray * datas;

@end


@implementation ELSelectView
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorColor = [UIColor clearColor];
    }
    return _tableView;
}
-(instancetype)initWithTitle:(NSString *)title withSelectArray:(NSArray<NSString *> *)array{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.datas = [array copy];
        //
        UIView * backgrand = [[UIView alloc]init];
        backgrand.backgroundColor = [UIColor blackColor];
        backgrand.alpha = 0.5;
        backgrand.frame = self.frame;
        [self addSubview:backgrand];
        //
        CGFloat height = (array.count+1)*CellHeight;
        height = (height > MaxHeight?MaxHeight:height)+33;
        //TopMargin
        UIView * alertView = [[UIView alloc]init];
        self.alertView = alertView;
        alertView.frame = CGRectMake((ScreenW-MaxWeight)/2,(ScreenH-height)/2, MaxWeight, height);
        alertView.backgroundColor = [UIColor whiteColor];
//        alertView.layer.cornerRadius = 5;
        [self addSubview:alertView];
        //
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:alertView.bounds byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = alertView.bounds;
        layer.path = path.CGPath;
        alertView.layer.mask = layer;
        //
        UILabel * titleLbl = [UILabel createWithFrame:CGRectZero bgColor:[UIColor whiteColor] text:title textColor:[UIColor lightGrayColor] font:[UIFont systemFontOfSize:15] align:NSTextAlignmentCenter];
        [alertView addSubview:titleLbl];
        [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(33);
        }];
        //
        UIButton * cancelBtn  = [UIButton createWithFrame:CGRectZero bgColor:[UIColor whiteColor] font:[UIFont systemFontOfSize:16] norTitle:@"取消" norTitleColor:[UIColor lightGrayColor] norImage:nil borderColor:nil needRoundCorner:NO target:self action:@selector(cancelAction:)];
        
        [cancelBtn setTitleColor:[UIColor redColor] forState:(UIControlStateHighlighted)];
        [alertView addSubview:cancelBtn];
        [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.mas_equalTo(0);
            make.height.mas_equalTo(CellHeight);
        }];
        //
        [alertView addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(0);
            make.top.equalTo(titleLbl.mas_bottom).mas_offset(0);
            make.bottom.equalTo(cancelBtn.mas_top).mas_equalTo(0);
        }];
    }
    return self;
}
-(void)cancelAction:(UIButton *)sender{
    [self hide];
}

-(void)show{
    UIWindow * window = [UIApplication sharedApplication].windows.firstObject;;
    [window addSubview:self];
    [self.alertView.layer addAnimation:[CABasicAnimation scaleShowAnimationWithDuration:ELAnimationDuration] forKey:@"ELSelectViewShowAnimation"];
}

-(void)hide{
    [self.alertView.layer addAnimation:[CABasicAnimation scaleHideAnimationWithDuration:ELAnimationDuration] forKey:@"ELSelectViewHideAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ELAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });

    
}


#pragma mark ============ UITableView数据源方法 ==============
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ELSelectViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ELSelectViewCellid];
    if (cell == nil) {
        cell = [[ELSelectViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:ELSelectViewCellid];
    }
    cell.titleLbl.text = self.datas[indexPath.row];
    
    return cell;
    
}


#pragma mark ============ UITableView代理 ==============
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ELSelectViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLbl.textColor = [UIColor blueColor];
    cell.titleLbl.font = [UIFont systemFontOfSize:20];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ELAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.selectRowBlock) {
            self.selectRowBlock(indexPath.row);
        }

        [self hide];
    });

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return CellHeight;
}
@end
