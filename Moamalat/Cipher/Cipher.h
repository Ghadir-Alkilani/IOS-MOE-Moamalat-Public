//
//  Cipher.h
//  TTSwitch
//
//  Created by dataserve on 5/24/16.
//  Copyright © 2016 Two Toasters. All rights reserved.
//

#import <Foundation/Foundation.h>
 
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface Cipher : NSObject {
    NSString* cipherKey;
}

@property (retain) NSString* cipherKey;

- (Cipher *) initWithKey:(NSString *) key;

- (NSData *) encrypt:(NSData *) plainText;
- (NSData *) decrypt:(NSData *) cipherText;

- (NSData *) transform:(CCOperation) encryptOrDecrypt data:(NSData *) inputData;

+ (NSData *) md5:(NSString *) stringToHash;

@end