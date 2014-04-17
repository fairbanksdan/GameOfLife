//
//  ViewController.m
//  GameOfLife2
//
//  Created by Daniel Fairbanks on 4/17/14.
//  Copyright (c) 2014 Fairbanksdan. All rights reserved.
//


#import "ViewController.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) NSMutableArray *currentArray;
@property (strong, nonatomic) NSMutableArray *modifiedArray;
@property (strong, nonatomic) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.currentArray = [NSMutableArray new];
    self.modifiedArray = [NSMutableArray new];
    
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++) {
            self.currentArray[i][j] = @NO;
        }
    }
    
    self.currentArray[2][4] = @YES;
    self.currentArray[1][3] = @YES;
    self.currentArray[2][2] = @YES;
    self.currentArray[1][3] = @YES;
    self.currentArray[1][2] = @YES;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(int)sumOfLitCellsForCoord:(int)x y:(int)y
{
    int sum = 0;
    for (int i = x-1; i <= x+1; i++) {
        for (int j = y-1; j <= y+1; j++) {
            if (i != x && j != y) {
                if (self.currentArray[i][j])
                {
                    sum++;
                    NSLog(@"%d", sum);
                }
            }
        }
    } return sum;
}

-(void)masterGridUpdater
{
    for (int i = 0; i < 10; i++) {
        for (int j = 0; j < 10; j++){
            if (self.currentArray[i][j]) {
                switch ([self sumOfLitCellsForCoord:i y:j]) {
                    case 2:
                    case 3:
                        break;
                        
                    default:
                        self.modifiedArray[i][j] = @NO;
                        NSLog(@"i is %d and j is %d", i, j);
                        break;
                }
            } else {
                switch ([self sumOfLitCellsForCoord:i y:j]) {
                    case 3:
                        self.modifiedArray[i][j] = @YES;
                        NSLog(@"i is %d and j is %d", i, j);
                        break;
                    default:
                        break;
                }
            }
        }
    }
}

#pragma mark - Collection View Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 100;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    return cell;
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(32, 32);
}



@end
