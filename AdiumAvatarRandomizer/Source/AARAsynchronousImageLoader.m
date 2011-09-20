//
//  AARAsynchronousImageLoader.m
//  AdiumAvatarRandomizer
//
//  Created by Thijs Alkemade on 20-09-11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AARAsynchronousImageLoader.h"
#import <CommonCrypto/CommonDigest.h>
#import <Adium/AIListContact.h>

@implementation AARAsynchronousImageLoader

@synthesize object, delegate;

- (id)initWithListObject:(AIListObject *)inObject delegate:(AARPlugin *)plugin
{
	if (self = [super init]) {
		self.object = inObject;
		self.delegate = plugin;
	}
	
	return self;
}

- (void)start
{
	if (![self.object isKindOfClass:[AIListContact class]]) return;
	
	AIListContact *contact = (AIListContact *)self.object;
	
	const char *chr = [[contact UID] UTF8String];
	unsigned char result[16];
	CC_MD5(chr, strlen(chr), result);
	
	NSString *MD5UID = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
						result[0], result[1], result[2], result[3], 
						result[4], result[5], result[6], result[7],
						result[8], result[9], result[10], result[11],
						result[12], result[13], result[14], result[15]
						];
	
	NSURL *gravatarURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.gravatar.com/avatar/%@.jpg?d=identicon", MD5UID]];
	
	NSURLRequest *gravatarURLRequest = [NSURLRequest requestWithURL:gravatarURL cachePolicy:NSURLCacheStorageAllowed timeoutInterval:60.0];
	NSURLConnection *gravatarConnection = [[NSURLConnection alloc] initWithRequest:gravatarURLRequest delegate:self];
	
	if (gravatarConnection) {
		imageData = [[NSMutableData alloc] init];
	} else {
		NSLog(@"Bad! gravatarConnection is nil!");
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	NSImage *icon = [[[NSImage alloc] initWithData:imageData] autorelease];
	
	NSLog(@"Found: %@", icon);
	
	[AIUserIcons userIconSource:delegate
		   didDetermineUserIcon:icon
				 asynchronously:YES
					  forObject:self.object];
	
	[imageData release];
	[connection release];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
	[imageData appendData:data];
}

@end
