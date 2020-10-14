//
//  ViewController.m
//  WuluKitDemo
//
//  Created by gaolailong on 2020/8/4.
//

#import "ViewController.h"
#import <WuluKit/WuluKit.h>
#import "ProtocolTest.h"

@interface ViewController ()

@property (nonatomic, strong) WuluKitPlugin *wuluPlugin;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor systemGray5Color];
    
    CGFloat SCREENWIDTH = [[UIScreen mainScreen] bounds].size.width;
    CGFloat SCREENHEIGHT = [[UIScreen mainScreen] bounds].size.height;
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.frame = CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT);
    scrollView.contentSize = CGSizeMake(SCREENWIDTH, SCREENHEIGHT * 1.1);
    [self.view addSubview:scrollView];
    
    // 初始化交通卡SDK
    self.wuluPlugin = [[WuluKitPlugin alloc] initialWithDelegate:[ProtocolTest shareInstance] appid:@"101" userId:@"2" deviceToken:@"3"];
    self.wuluPlugin.wxAppid = @"wx6fe739eda712ed9a";
    UIViewController *waistView = [self.wuluPlugin showWaistLinePageWithMinY:160.0];
    [self addChildViewController:waistView];
    [waistView didMoveToParentViewController:self];
    [scrollView addSubview:waistView.view];
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"njsmk_standard.png" ofType:nil];
    UIImage *iamge = [UIImage imageWithContentsOfFile:filePath];
    NSLog(@"%ld", UIImagePNGRepresentation(iamge).length);
    [self calulateImageFileSize:iamge];
    
    NSURL *url = [NSURL fileURLWithPath:filePath];
    [self getImageFileSizeWithURL:url];
    
}

#pragma mark - ------ 计算UIImage图片大小 ------
- (void)calulateImageFileSize:(UIImage *)image {
    NSData *data = UIImageJPEGRepresentation(image, 0.7);
    if (!data) {
        data = UIImagePNGRepresentation(image);
    }
    double dataLength = [data length] * 1.0;
    NSArray *typeArray = @[@"bytes",@"KB",@"MB",@"GB",@"TB",@"PB", @"EB",@"ZB",@"YB"];
    NSInteger index = 0;
    while (dataLength > 1024) {
        dataLength /= 1024.0;
        index ++;
    }
    NSLog(@"image = %.3f %@",dataLength,typeArray[index]);
}

- (CGFloat)getImageFileSizeWithURL:(NSURL *)url
{
    NSURL *mUrl = nil;
    if ([url isKindOfClass:[NSURL class]]) {
        mUrl = url;
    }
    if (!mUrl) {
        return 0.0f;
    }

    CGFloat fileSize = 0;
    CGImageSourceRef imageSourceRef = CGImageSourceCreateWithURL((CFURLRef)mUrl, NULL);
    if (imageSourceRef) {
        CFDictionaryRef imageProperties = CGImageSourceCopyProperties(imageSourceRef, NULL);
        if (imageProperties != NULL) {
            CFNumberRef fileSizeNumberRef = CFDictionaryGetValue(imageProperties, kCGImagePropertyFileSize);
            if (fileSizeNumberRef != NULL) {
                CFNumberGetValue(fileSizeNumberRef, kCFNumberFloat64Type, &fileSize);
            }
            CFRelease(imageProperties);
        }
        CFRelease(imageSourceRef);
    }
    return fileSize;
}

@end
