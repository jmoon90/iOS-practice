//
//  BNRDetailViewController.m
//  Homepwner
//
//  Created by John Moon on 6/10/14.
//  Copyright (c) 2014 BNR. All rights reserved.
//

#import "BNRDetailViewController.h"
#import "BNRItem.h"
#import "BNRItemStore.h"

@interface BNRDetailViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *serialNumberField;
@property (weak, nonatomic) IBOutlet UITextField *valueField;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIToolbar *toolbar;

@end

@implementation BNRDetailViewController
- (IBAction)takePicture:(id)sender {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    
    //If the device has a camera, take a picture, otherwise just pick from photo library
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    } else {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    imagePicker.delegate = self;
    
    //Place image picker on the screen
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    //Get picked image from info dictionary
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    //Put that image onto the screen in our image view
    self.imageView.image = image;
    
    //Take image picker off the screen you must call this dismiss method
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)setItem:(BNRItem *)item {
    _item = item;
    self.navigationItem.title = _item.itemName;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    BNRItem *item= self.item;
    
    self.nameField.text = item.itemName;
    self.serialNumberField.text = item.serialNumber;
    self.valueField.text = [NSString stringWithFormat:@"%d", item.valueInDollars];

//    if (self) {
//        UINavigationItem *navItem = self.navigationItem;
//        navItem.title = [[NSString alloc] initWithFormat:@"%@", item.itemName];
//    }
    
    //Need NSDate formatter
    static NSDateFormatter *dateFormatter = nil;
    if(!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterMediumStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    }
    
    //Use filtered NSDate object to set DateLabel contents
    self.dateLabel.text = [dateFormatter stringFromDate:item.dateCreated];
}

-(void)viewWillDisappear:(BOOL)animated  {
    [super viewWillDisappear:animated];
    
    //Clear first responder
    [self.view endEditing:YES];
    
    // "Save" changes to item
    BNRItem *item = self.item;
    item.itemName = self.nameField.text;
    item.serialNumber = self.serialNumberField.text;
    item.valueInDollars = [self.valueField.text intValue];
    
}

@end
