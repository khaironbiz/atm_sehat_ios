//
//  ELInputAlertView.m
//  自定义tabbar
//
//  Created by iot_user on 2019/1/19.
//  Copyright © 2019年 IOT. All rights reserved.
//

#import "ELInputAlertView.h"
#import "CABasicAnimation+ELAnimation.h"
#import "UIView+Category.h"
#import "Masonry.h"

//字符串是否为空
//#define IsEmptyStr(str)         [NSString isEmptyString:str]
//375x667的屏幕
#define ScreenHeight             [UIScreen mainScreen].bounds.size.height
#define ScreenWeight             [UIScreen mainScreen].bounds.size.width
//
//#define SW(w)   ScreenWeight*(w/375.0)
//#define SH(h)   ScreenHeight*(h/667.0)
#define AlertWidth 285
#define AlertHeight 285
#define ButtonHeight 45
#define ButtonEdge 25

@interface ELInputAlertView()
@property (nonatomic, strong) UIView * alertView;
@property (nonatomic, strong) UITextField * inputTF;

@property (nonatomic, strong) UIButton *topBtn;
@property (nonatomic, strong) UIButton *bottomBtn;



@end

@implementation ELInputAlertView
-(UITextField *)inputTF{
    if (_inputTF == nil) {
        _inputTF = [[UITextField alloc]init];
        _inputTF.textColor = [UIColor blackColor];
        _inputTF.font = [UIFont systemFontOfSize:18];
        _inputTF.clearButtonMode = UITextFieldViewModeWhileEditing;
//        _inputTF.layer.borderColor = EL242GrayColor.CGColor;
//        _inputTF.layer.borderWidth = 1.0f;
        //
        UIView *leftView = [[UIView alloc]init];
        leftView.frame = CGRectMake(0, 0, 5, 5);
        _inputTF.leftView = leftView;
        _inputTF.leftViewMode = UITextFieldViewModeAlways;
    }
    return _inputTF;
}
-(instancetype)initWithTittle:(NSString *)title withText:(NSString *)text withMessage:(NSString *)placeholder withLeftButton:(NSString *)leftTitle withRightButton:(NSString *)rightTitle{
    if (self = [super init]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.leftAutoHide = YES;
        self.rightAutoHide = NO;
        //
        UIView * backgrand = [[UIView alloc]init];
        backgrand.backgroundColor = [UIColor blackColor];
        backgrand.alpha = 0.5;
        backgrand.frame = self.frame;
        [self addSubview:backgrand];
        //
        UIView * alertView = [[UIView alloc]init];
        self.alertView = alertView;
        alertView.frame = CGRectMake((ScreenWeight-AlertWidth)/2, (ScreenHeight - AlertHeight)/2, AlertWidth, AlertHeight);
        alertView.backgroundColor = [UIColor whiteColor];
        [self addSubview:alertView];
        
        UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:alertView.bounds byRoundingCorners:(UIRectCornerAllCorners) cornerRadii:CGSizeMake(5, 5)];
        CAShapeLayer * layer = [CAShapeLayer layer];
        layer.frame = alertView.bounds;
        layer.path = path.CGPath;
        alertView.layer.mask = layer;
        //标题
        UILabel * titleLbl = [[UILabel alloc]init];
        titleLbl.text = title;
        titleLbl.textColor = [UIColor blackColor];
        titleLbl.font = [UIFont systemFontOfSize:16];
        titleLbl.textAlignment = NSTextAlignmentCenter;
        titleLbl.frame = CGRectMake(10, 10, alertView.frame.size.width-20, 25);
        [alertView addSubview:titleLbl];
        //输入框
//        if (IsEmptyStr(placeholder)) {
//            placeholder = @"";
//        }
        self.inputTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString:placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:18],NSForegroundColorAttributeName:[UIColor lightGrayColor]}];
        self.inputTF.text = text;
        [self.inputTF becomeFirstResponder];
        self.inputTF.frame = CGRectMake(10, CGRectGetMaxY(titleLbl.frame)+55, alertView.frame.size.width-20, 40);
        [alertView addSubview:self.inputTF];
        //
        UIView *lineView = [[UIView alloc] init];
        lineView.backgroundColor = [UIColor blackColor];
        [alertView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.top.equalTo(self.inputTF.mas_bottom).mas_offset(5);
            make.height.mas_equalTo(1);
        }];
        //下边按钮
        UIButton * leftButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.bottomBtn = leftButton;
        [leftButton setTitle:leftTitle forState:(UIControlStateNormal)];
        [leftButton setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
        [leftButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        leftButton.titleLabel.font  = [UIFont systemFontOfSize:18];
        leftButton.frame = CGRectMake(ButtonEdge, alertView.frame.size.height-ButtonHeight-5, alertView.frame.size.width-ButtonEdge*2, ButtonHeight);
        [alertView addSubview:leftButton];
        [leftButton addTarget:self action:@selector(leftAction:) forControlEvents:(UIControlEventTouchUpInside)];
        //上边按钮
        UIButton * rightButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        self.topBtn = rightButton;
        [rightButton setTitle:rightTitle forState:(UIControlStateNormal)];
        [rightButton setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [rightButton setTitleColor:[UIColor grayColor] forState:(UIControlStateHighlighted)];
        rightButton.titleLabel.font  = [UIFont systemFontOfSize:18];
        rightButton.frame = CGRectMake(ButtonEdge, alertView.frame.size.height-ButtonHeight*2-10, alertView.frame.size.width-ButtonEdge*2, ButtonHeight);
        [alertView addSubview:rightButton];
        rightButton.backgroundColor = [UIColor blueColor];
        [rightButton addTarget:self action:@selector(rightAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [rightButton setCornerRadii:CGSizeMake(ButtonHeight/2, ButtonHeight/2) withCorner:(UIRectCornerAllCorners)];
//        //竖线
//        UIView *sxLine = [[UIView alloc]init];
//        sxLine.frame = CGRectMake(alertView.frame.size.width/2, alertView.frame.size.height-ButtonHeight, 1, ButtonHeight);
//        sxLine.backgroundColor = EL242GrayColor;
//        [alertView addSubview:sxLine];
//        //横线
//        UIView * hxLine = [[UIView alloc]init];
//        hxLine.backgroundColor = EL242GrayColor;
//        hxLine.frame = CGRectMake(0, alertView.frame.size.height-ButtonHeight, alertView.frame.size.width, 1);
//        [alertView addSubview:hxLine];
        //
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    }
    return self;
}

-(void)setTopBtnBackColor:(UIColor *)topBtnBackColor{
    _topBtnBackColor = topBtnBackColor;
    
    self.topBtn.backgroundColor = topBtnBackColor;
}

-(void)keyboardWillShow:(NSNotification *)noti{
    CGRect frame = [[[noti userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect alertFrame = self.alertView.frame;
    alertFrame.origin.y = ScreenHeight - frame.size.height - AlertHeight - 10>0?ScreenHeight - frame.size.height - AlertHeight - 10:0;
    self.alertView.frame = alertFrame;
    
}
-(void)keyboardWillHide:(NSNotification *)noti{
    CGRect alertFrame = self.alertView.frame;
    alertFrame.origin.y = (ScreenHeight - AlertHeight)/2;
    self.alertView.frame = alertFrame;
}
-(void)leftAction:(UIButton *)sender{

    if (self.leftBlock) {
        self.leftBlock(self.inputTF.text);
        [self hide];
        [self.inputTF resignFirstResponder];
    }
    if (self.leftHideBlock) {
        BOOL hide = self.leftHideBlock(self.inputTF.text, self);
        if (hide == YES) {
            [self hide];
            [self.inputTF resignFirstResponder];
        }
    }
    if (self.leftAutoHide) {
        [self hide];
        [self.inputTF resignFirstResponder];
    }
}
-(void)rightAction:(UIButton *)sender{

    if (self.rightBlock) {
        self.rightBlock(self.inputTF.text);
        [self hide];
        [self.inputTF resignFirstResponder];
    }
    
    if (self.rightHideBlock) {
        BOOL hide = self.rightHideBlock(self.inputTF.text, self);
        if (hide == YES) {
            [self.inputTF resignFirstResponder];
            [self hide];
        }
    }
    if (self.rightAutoHide) {
        [self.inputTF resignFirstResponder];
        [self hide];
    }
}
-(void)show{
    UIWindow * window = [UIApplication sharedApplication].windows.firstObject;
    [window addSubview:self];
    [self.alertView.layer addAnimation:[CABasicAnimation scaleShowAnimationWithDuration:ELAnimationDuration] forKey:@"ELInputAlertViewShowAnimation"];
}
-(void)hide{
    [self.alertView.layer addAnimation:[CABasicAnimation scaleHideAnimationWithDuration:ELAnimationDuration] forKey:@"ELInputAlertViewHideAnimation"];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(ELAnimationDuration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeFromSuperview];
    });
    
    
}

@end
