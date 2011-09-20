//
//  AARPlugin.h
//  AdiumAvatarRandomizer
//
//  Created by Thijs Alkemade on 20-09-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Adium/AIPlugin.h>
#import <Adium/AIUserIcons.h>

@interface AARPlugin : AIPlugin <AIUserIconSource> {
}

- (AIUserIconSourceQueryResult)updateUserIconForObject:(AIListObject *)inObject;

@property (readonly, nonatomic) AIUserIconPriority priority;

@end
