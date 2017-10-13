//
//  ViewController.m
//  Runtime 面试初探
//
//  Created by JQ on 2017/10/11.
//  Copyright © 2017年 Majq. All rights reserved.
//

#import "ViewController.h"
//#import "Person.h"
//#import "Son.h"
//#import "Student.h"

#import "Book.h"
#import "GeographyBook.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //考察 load、init 方法
//    Person *p = [[Person alloc] init];
    
//    Son *s = [[Son alloc] init];
    
//    
//    Student *stu = [Student alloc];
//    stu = [stu init];
    NSLog(@"\n");
//    Book *b = [Book alloc];
//    b = [b init];
    
    GeographyBook *g = [GeographyBook alloc] ;
    int a = 5;
    int b = 6;
    NSLog(@"%d",a);
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
