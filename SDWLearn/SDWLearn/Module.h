//
//  Module.h
//  SDWLearn
//
//  Created by Product Division 1 on 15/10/13.
//  Copyright © 2015年 gph. All rights reserved.
//

#import <Foundation/Foundation.h>


/*!
 @header NSURLProtocol.h
 
 This header file describes the constructs used to represent URL
 protocols, and describes the extensible system by which specific
 classes can be made to handle the loading of particular URL types or
 schemes.
 
 <p>NSURLProtocol is an abstract class which provides the
 basic structure for performing protocol-specific loading of URL
 data.
 
 <p>The NSURLProtocolClient describes the integration points a
 protocol implemention can use to hook into the URL loading system.
 NSURLProtocolClient describes the methods a protocol implementation
 needs to drive the URL loading system from a NSURLProtocol subclass.
 
 <p>To support customization of protocol-specific requests,
 protocol implementors are encouraged to provide categories on
 NSURLRequest and NSMutableURLRequest. Protocol implementors who
 need to extend the capabilities of NSURLRequest and
 NSMutableURLRequest in this way can store and retrieve
 protocol-specific request data by using the
 <tt>+propertyForKey:inRequest:</tt> and
 <tt>+setProperty:forKey:inRequest:</tt> class methods on
 NSURLProtocol. See the NSHTTPURLRequest on NSURLRequest and
 NSMutableHTTPURLRequest on NSMutableURLRequest for examples of
 such extensions.
 
 <p>An essential responsibility for a protocol implementor is
 creating a NSURLResponse for each request it processes successfully.
 A protocol implementor may wish to create a custom, mutable
 NSURLResponse class to aid in this work.
 */

@interface Module : NSObject

@end
