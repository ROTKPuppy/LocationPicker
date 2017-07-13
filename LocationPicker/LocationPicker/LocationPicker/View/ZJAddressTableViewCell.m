//
//  ZJAddressTableViewCell.m
//  LocationPicker
//
//  Created by 郑键 on 2017/7/12.
//  Copyright © 2017年 inborn. All rights reserved.
//

#import "ZJAddressTableViewCell.h"
#import "ZJAddressModel.h"

const NSString *ZJAddressTableViewCellReId = @"ZJAddressTableViewCellReId";

@interface ZJAddressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *selectedFlagImageView;
@end

@implementation ZJAddressTableViewCell

- (void)setSelectedTintColor:(UIColor *)selectedTintColor
{
    _selectedTintColor = selectedTintColor;
}

- (void)setSelectedImage:(UIImage *)selectedImage
{
    _selectedImage = selectedImage;
    self.selectedFlagImageView.image = selectedImage;
}

- (void)setAddressModel:(ZJAddressModel *)addressModel
{
    _addressModel = addressModel;
    
    _addressLabel.text = addressModel.name;
    _addressLabel.textColor = addressModel.isSelected ? self.selectedTintColor : [UIColor blackColor] ;
    _selectedFlagImageView.hidden = !addressModel.isSelected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
