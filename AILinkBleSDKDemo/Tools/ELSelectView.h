//
//  ELSelectView.h
//  Elink
//
//  Created by iot_user on 2019/1/23.
//  Copyright © 2019年 iot_iMac. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ELSelectViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLbl;

@end


@interface ELSelectView : UIView
@property (nonatomic, copy) void (^selectRowBlock)(NSInteger row);



-(instancetype)initWithTitle:(NSString *)title withSelectArray:(NSArray<NSString *> *)array;

-(void)show;
@end

NS_ASSUME_NONNULL_END
