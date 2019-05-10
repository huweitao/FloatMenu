//
//  Base64Images.m
//  AccountAuthService
//
//  Created by huweitao on 2019/5/6.
//  Copyright © 2019年 DMC. All rights reserved.
//

#pragma mark - NSString Extension
@interface NSString (Base64Format)

- (NSString *) stringPaddedForBase64;

@end

@implementation NSString (Base64Format)

- (NSString *) stringPaddedForBase64 {
    NSUInteger paddedLength = self.length + (self.length % 3);
    return [self stringByPaddingToLength:paddedLength withString:@"=" startingAtIndex:0];
}

@end

#pragma mark - NSData Extension

@interface NSData (Base64Format)

/**
 Returns a data object initialized with the given Base-64 encoded string.
 @param base64String A Base-64 encoded NSString
 @returns A data object built by Base-64 decoding the provided string. Returns nil if the data object could not be decoded.
 */
- (instancetype) initWithBase64EncodedStringInFormat:(NSString *)base64String;

/**
 Create a Base-64 encoded NSString from the receiver's contents
 @returns A Base-64 encoded NSString
 */
- (NSString *) base64EncodedString;

@end

@implementation NSData (Base64Format)

- (instancetype) initWithBase64EncodedStringInFormat:(NSString *)base64String {
    return [self initWithBase64Encoding:[base64String stringPaddedForBase64]];
}

- (NSString *) base64EncodedString {
    return [self base64Encoding];
}

@end

#import "Base64Images.h"

@implementation Base64Images

+ (UIImage *)cupImage
{
    return [self base64ImageFromString:[self cupImageBase64]];
}

+ (UIImage *)lightImage
{
    return [self base64ImageFromString:[self lightImageBase64]];
}

+ (UIImage *)circleImage
{
    return [self base64ImageFromString:[self circleImageBase64]];
}

+ (UIImage *)homeImage
{
    return [self base64ImageFromString:[self homeImageBase64]];
}

+ (UIImage *)base64ImageFromString:(NSString *)str
{
    if (!str || str.length == 0) {
        return nil;
    }
    NSString *prefix = @"data:image/png;base64,";
    if ([str hasPrefix:prefix]) {
        str = [str stringByReplacingOccurrencesOfString:prefix withString:@""];
    }
    NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedStringInFormat:str];
    UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
    return decodedImage;
}

+ (NSString *)cupImageBase64
{
    return @"data:image/png;base64,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";
}

+ (NSString *)lightImageBase64
{
    return @"data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAMgAAADICAYAAACtWK6eAAAcPElEQVR4Xu1dCfx31Zx+HvuSxFAILaNIosYylSilxZRoEUlRmGqyhDAqhDRGllJDksoWWUOIrClraLElGVu2qWxRw4xnPk/O2/y9ve//f86959577r3n+/n8P28fvmd7zn1+Z/suRJVeEZB0RwBrhb91Adx6iQ78L4DfAfgNgN8CuBLA5QB+TPJ/eu38DBvjDMfc+ZAlrQFg4/BnEiwjxDoAbp6pA38B8HMAlwH4NoALAVzgf0lek6mN2VdTCdLiE5B0IwD3ALBJIIP/fSCA27eotm1RrzjfAPAZAJ8FcA7Jq9tWOtfylSCJMy/pZgAeDmBXALsMTIaY3nsbdn4gzKcBnFdXmBjY/qpTCRKBlaRbAtgBwGMB7AhglYhipap4+3UWgPcC+FBdXRafpkqQleATtk+PALAPgEcCMEmmJn8CcCaANwH4OElNbYBtx1MJshyCktYEsB+AAwDcpS3AIyr/w0CUE0leMaJ+d9rVSpAAr6RtABwI4FEAbtIp6mVX/kcAbwRwNEnfks1aZk0QSTcOK8UzAaw36y/hhoP/M4CTABxF8qdzxWa2BJHkQ/exANaf6+RHjttEORXAkSR/HFlmMmqzI4ikjbx9ALD9ZGaxn4H4feVEAIeTvKqfJodvZTYEkXQfAEcA2G142OG3CV+3Lv93LXDd/+cbs1uEf/3fy/78vw0tvwbwIgBvIGnSTFomTxBJtwlbqScN8O7jD/5bAC4CcHH49+sk/ZEliyQT5N4A7hv+vBr+w0CPld8EsD/JLyQPZEQFJk0QSVsBeEeP17U+zPq1+mwAXwVwKUnbTHUqwfbLRPF4fRvn/+5rbt8O4Nkk/6vTQQ5UeV8g9jo8SbcC8Kpwbdtl234vsM2TSfFpkt/rsrHYuiWttoAsJswGsWUb6tna+GCSpzQsX2yxyRFEkg0GbUZhK9ouxObm7wHwTgCfH8Prs6S1ATwOwJ5ha9YFLq7zwwD2JWmMJiGTIYgkj+XwcIDM/dD3ewBnBFKcPWY/DEk+w5goewGw+X1u8VZrT5Kfyl3xEPVNgiCSVgXw7g6ubi/x/b9XJJI+cE9KJG0G4JBglZzzW/Dt1iEkjxk7YDlBGQQLSfcE8BEAf5+xA751erm3UmPYQrUdt6QNw+q7BwD7uOSS0wE8keR/56qw73pGTRBJ9st4PwBf5eaQr4UXY2+nZieSbFVwKIAnALAZTg7xbd5OJH+Vo7K+6xgtQSQdDODVmX7xbMn6NJJeiWYvknzB4VtAO4TlEBs9bkfSbyejktERJPhpnADgqRmQ9rni3wD8+5i3ARlwWGEVkmyO8x+Ztq+2Et6NpJ21RiOjIogk3075Ctcm6W3FV5IHkfxJ24qmXF6Sg0w8F8BhwfylzXBt+LjLmFbq0RAkTNQHANjLr438KJhIfLxNJXMrK+luAF7v80TLsdvWbG+S72pZTy/FR0GQYIP0IQDbtkTFh+8nkXR8qSoNEJB0UDj7tQlfZNfex5L0g2vRUjxBQhSRjwHYugWSPmvYXugNLeqoRQMC4Vr4gy3PJvaH34bkuSUDWzRBAjm8crTx3fBjnw+HtqqtkgkBSY4I6R+cvVtUaQuFzUu+3SqWIMF0xFuinVtMgC15nzLFV/AWmGQtKsmPizZStIFoE/klgAeU6tZbMkHs9WcziKZyDMlnNS1cy8UjIGlTAJ+MiDO8skq/A2BTkrYKLkqKJIikfQGc3AIpu4XaVKRKTwhIun8giU3tm8jnwpmkKC/F4ggi6aHBv6KJqYNvR/y2UQ/jTT7RlmWCpbD9Y1ZvWNUJJB16qRgpiiCS/i64qDo6eqrYc28fkj53VBkIAUk2ofdq4HeTJuJr+Lc0KdhFmWIIEg7l9iF4WIOBmhyPG8O9eoOxja6IJEek9PVtE38Tv7ZvQfIrJQy8JILYirTpucFebI7dVKUQBCTZ/eDLALwrSBVb/t6nBD/3IggSHHf8i9PEF+FFJF+WOgNVv3sEgvvz5xvebn2CZJv3rywDHJwgISKHsyM1OXecStI3XlUKRUCSLSBs99bEDfpAkrbcHkxKIIizIG3ZAIH3Adijj7A6DfpWiyxAQNJjANg4MXWHYBOhjUh+fyhAByWIpCeGuK+p4z8n3JnXJJapyA2kL+kZIYBfag/OJfmQ1EK59AcjSIjd5F+G1EOcD3AbzCk+bK7JHroeSbbe3b1BP+ztacet3mVIgnhvuX/iiP3K6ivALyWWq+oFIBAC+tnv/16J3fmDywxhrzUIQYJZgp35U9t/DsnXJIJb1QtCQJKzAjsLb2qex9NJOvhdr5L6gbbuXHgQdFgdR1tPkY+QbOvNltJe1e0IAUnO+Wg3hlTZrO/dwxAE+ZcQCCAFHJ9VNqkZWVMgK1tXkoPKObNXinyDpANz9ya9EkSSl1VnKbpd4gh97jgvsUxVLxiBEGPAwb7vnthNu+o6imYv0jdBng/gFYkjc9hP36NXmRgCkpzMyFFqUuQHzifZ1/tXbwSR5CxJXj3ukICGQ1auU7OtJiA2MlVJtvy1i0OKOJzpW1MKNNXtkyDeb6YGM652Vk1ndiTlgg+JL21S/H8cy2zdPqLs90KQEPDN8ahsBh0rBsFL6WgDH8cOdO56kl7rBDyJOPSyivRFEOcHTM0+tCtJB4qrMnEEQh5Jny1Stt8+4Pvx0F6knUnnBAnvHt9NzEd+AUlniqoyEwQkPScEzE4ZscOYdhqJvw+CNHkU2pmkY+dWmQkCDS9xziHZxBI8GtU+CHImgB2jewTU1SMBrCmpSnqeI+0njmltkj7fdiKdEkTSnQBcnugH8GiSDmtZZWYIhFXkZwBSQge9kqTf1zqRrgnyQgAvTej5t4MvcqcHr4T+VNWeEZD0AgBHJTTrVNxrdPVw2DVBLktMx/wYkqkvqwlYVtXSEQjmSL7iT1lFHtFVYp7OCCLpQSGqReycOH3wnbr6JYjtRNUbHgFJdo6yUWusnEQyR8axG7TXJUFSH39qLN3Yz2HieiHW7xcThnll2GZlD1vaCUHC28cvEkNQOsK3vc2qVAQgKXV7vjVJhz3NKl0R5IEAUiLjfZfkBllHVisbNQKSXgTgJQmDeC3JZyfoR6l2RZDDAaQEczuUpLPNVqkIXIeApLsCSEmwehlJu/Nmla4I4mh6W0T21Fe6dyXp++8qFYHrEZDkaJsPToDkniRto5VNshMkpOZyksxY8+UvkEwBIdvga0VlIyDpaQCOS+il81D6ciibdEEQp2n+aEIPX0ryxQn6VXUmCEjyudSPx7FyBsldYpVj9LogyJEh6XxM+9bZiqS9yqpUBG6AgKSf+30sEporSN4xUjdKrQuC+Kptq6jWATtDrdKHZ1hkf6paYQhIckKkxyd0a32SlyboL6qalSDBc9CpfW8R2cFPkXx4pG5VmyECkp4C4E0JQ8+aKyY3QTYCYP/iWDmMZIphWmy9VW8iCEhaF4AfDWPldSRT422ttO7cBHkCgLfFjgRA75HyEvpWVQtBQNIPAawV2Z3PkYzd4i9ZZW6CpOQ2t93MzUlmt59ZctRVYVQIJEaFv4pkasaA3laQTwDYNhL9Tl4+I9uuaiNCQFLqzejdSaa8wvdGkP8EsHYk9h8lmeKKG1ltVZsaApL2BpASKC7b00G2LZYkv5ynZHzqxLhsah9HHc91dlmpvkX7kUwNM7VCqHMSxGl/U3LJHUDyjfUDqAgshYCkVQHYfClWjiRpd+/WkpMgPnv4DBIrndjvxzZe9caFgKRfJvgXnUZyrxwjzEmQfQC8JaFTa1YL3gS0Zq4qyYlbY5N5nk1yuxyQ5STIswBEp0cjma3tHEDUOspGQNI7AcSmYMuWaCfbRyrp5QAOjYT59yS9r6xSEYhCQNKJAGIDM/yEZGpinhX2IydBfOD+56jRAj8juWakblWrCPgm69UAYl1q/0jy1jlgy0mQ0wDsGdmpS0impgKOrLqqTREBSfZPt596lOTawuckyPsA7BrVe+BrJB8QqdurmqTbh8OgjeTOJ2n34clKGK/do+3P7fH6MFycSDoEgE2ZYsVmTH+KVV6ZXk6CpASp/izJh7XtfM7ykmyib8tiW4LeaEHdjrl0EMnTc7Y3dF2SbgbAJhxOO7BwvL8O4/WhuBiRtD+AExI6tCpJu160kpwEORtArG/Hh0nu3KrnmQtLckyuxVIMn0Jyv8zNDlKdJGcZ/pRTay/SgVeRfO4gHVxBo5LsNGXnqVi5A0n/uLWSnAQx4FtH9qaozLWSjgXwjIi+v4tk7Dkrorr+VSTZ0tUuzhtGtL4dSf/wDS4NMuKuTtLhbFtJToI4UIMDNsTImSSdWGdwCV6Qdv1duM1YrF+jJUkgh/PN3zMS+GI8PiX5Zfztkf222m1J/i5Bf4WqOQnyfgCxESVKAj41CqSBHB1JGpDD48zqW9HmY23gelvcIT3lmveLJDdvA1iuspJ2APCxBvW9jaTNa4oXSU6O+dnIbdXfjCfXdWlbkCR5C+ytcJTk6nfOFeRkAPtG9b6gNGsNQlwuHGLxK0nDlWPZGC8med/IOe1UTZKzSL0ispFrSN4qUndRtZwEScnp8EOS6+QYQI46JKV4Qi7fZLEkaUkOj/OZJF+XA+O2dUhy7OZ/jawn29YwJ0EcHfGIyAH8maTv4YsQSfZluSQhXGrxJMlADqfu3rCUhEaS7FFoz8IYyWapkZMgtsNKcYDKcg0Xg1aMToM4sMtX+w6SjuoyuEhaA4AD+DVNKfEHAFuWlK9FUsozQrbIJjkJkpoPfROSFwz+NS3ogKSDABzfok8fALD7kL+6klYH4OxMNpVpIr4a3Ybk+U0Kd1VGkle02Ovp00nGmsYv2uWcBLFt1VcTANqJ5EcS9HtRbXCduHy/BiNJJnI8lOSFvYCd0Igkm42sElnkWJIHR+r2RhCbr/80oVMHk4y+tkuot7XqGEkycXI4eLWDWMfKC0jG3nj1QxC3IulaB4OLHEVnmUkj219UbUwkmTI5wne1DYBPJszrXiT9Ltdasm2xwkCWMvhb2OEvkdys9Qg6rGAMJJk6OcJ3ZQvrYxKmeuNc28TcBHFc3tibnKtJ3iZh0IOolkySOZAjEMTR3R3lPVaymJm4sdwEeUHwqYgdyLokHY2xaCmRJJLuAsDOXG1uq4o8kC//MUj6EoB/jPxIvk9yvUjdJdVyE+RRAM5YstX/V9ibZIqFZkLVeVVLIkkgxxcSIp4vD4adoh6WaxuSF+m/rS1YW18D4CaR7WT1NcpNEMflTVkR3kwyZemMxKgbtUASR9doipuvgB/TJqJ9JnJsQTIl9183gEbUKumhwX8lQvs6laNIHharvJRe04leab2S7KRi69EYGV2E9xBI2QHymmLnt59HNSHJ3MjhD0iSQ0k5pFSs7EgyJYnsovU2neTFCPJeALvFjgbAnUn+IkF/cNUhSDJHcgSC2BXBLgkxIgD2Rb86RjlGpwuCOHaRYxjFSrZI3LEN5tDrkyQzJoczBvwm4QX9QpIb55jfZXV0QZBNgy1QbD+zHqpiG82h1wdJ5kqOsHo4vu7HE+bqeJJPT9BfUrULgtwUgG9JYiPbOXbRaiR9UzE66ZIkcyZHIMgbAByQ8FH4AsRb/GySnSBhYL7q9ZVvrGQfWGzDOfS6IIkkx5Z1ELfY5JXLD+WKYLI+ituq5Tsvyd/mzwDYDitGnOvyNrl/aLsiyJMBnBQzqqCTLZ9DQptZVXOSJJDD7xxN4xebHA8m+b2sg+yxMkmpW/VPkozNjxk9kq4I4mvelJhENnJ0oC876oxWMpHEwQm8csyWHGEX8noAByZ8DJ24B3dCkDDALwNwbrlYeQrJN8cql6qXgST+sXAY1CYy+pUjfDsOuOAf2JTAC+uQdD71rNIlQexgb0f7WDmXZGwGodg6B9GT9FgAjm3bGb4rGNgkyBEIkrpFv4jk/bqY7M4mMNzAOFd1bMRCj28UxosxE9EzSSZDjkCQrwBwQL9YeS7JV8Uqp+h1RpAwUJtV/FNCh44h6VRukxBJqXkbm4z7V+G2yj7boxdJqa7bfj1fI0cc3hWB1zVBdgfwnoRZ81uIk3v6HWUS0vFKMqmVI/yopoSwdZFsCTuHIIgfDf0Lt1rC1/5iki9N0C9etUHg5ZgxTWrlCORYH4BXwpQf7n1I2lGvE0npSKMOSLLzvMNGxopXD68io3xZX9kgM68kzhm+2RiczWInPRDEt5gpOVh+C+CuOY0Tl+9vHwRxEDNHO4l1eHEfDyGZYvCYMg+D6WZaSWz5/BCS3x9sIB00LMkWA37YTIm4eTTJ53XQneur7Jwg4ZchxVfdRRwDaa0pnUWWIR5WEmdKsqVqqkxy5QjfiFPc7ZEAyP8AWJvk5QllklX7IohNkL+R2LvXkXQ0i8mJpEcDsFFdCkn8o3G/qW2rAjlSzUpcrBfzpF4IEkD4tP2gE752G5/da2pbiQUriUniG5vYOeh8O5EwN1lVJX19iXyJK2rPPxYXZe3ICiqLnZzW/ZCUGvzLbZ5FMjatW+s+9l2BJNuexZpTHEoyxTKh7+E0ak+Sw0Sl3kJ9guT2jRpMLNQbQcIq4ixHWyb2cQ+SKW8pidUPpy7JN3axV+CTI4ik2wK4DIATi6bIRiS/mVKgqW7fBGmy1/StzXpdXuU1Ba9tuUoQpWQlWwb3O0k6JXQv0itBwiqSkk99GQgnkEwxfe4FvLaNzJkgDcL5GO4/A1i/C6vdlc3lEARxhDxHykuVrUk6KcxkZK4EkeRzl1Ms3CNxMo8jGZPPPrHalav3TpCwiqS+mLqYt1ree9r+aBIyY4Kkvnl4vj3v3mo7yklvMhRBfDD1S3Dq4ayY/Oo5ZmiOBJH0RACnNsDvySR9ZulVBiFIWEWcIstORanSme1/akfa6s+NIJK8pfLWKvZqexnEXyNpM/jeZTCCBJKcBSD1PtsPiM6h97ne0crc4JwIImlVAH4QdEbhFLG/hx8FL04plEt3aILcGcC3ANwucUBONLkpye8klitKfS4EkWS3B2eIciDqVHkNyeekFsqlPyhBwiqSmjJh2dhtIexMuaM9tM+IIO8CYD/9VHHu+vuSdHDBQWRwggSSpFr7LgPLKd+2Gusj4hwIIukIAC9u8HWbFA8Yamu1rL+lEMT7U+8xHU0wVRxe6OFjJMnUCSIpNbLNwrl/HsmjUz+G3PpFECSsIn5APDfRsWoZHqMkyZQJ0pIctvz2j54P6INKMQQJJPFhrGn4FpNkW5L2mxiFTJUgklJzVS6cL4eK8oOw3WkHl6IIEkiSGvh6IYg+k2xP8srBkY3owBQJIukoACZIE3Ecggf1Zakb08ESCeLU0HaEcb7DJnJpOLg7MnjRMiWChGjspwDwS3lT2YVkShLYpu1ElyuOIGEVcRhJpzhumkfdy/SWpbunToUgIROt7at2jf7ybqh4BMmXtCjfSdEiCRJIsjkAW++mRLlYCNJVAJ5A0jnuipQpEESS7eo+5EgrLUB+C8kntSjfWdFiCRJIslPIu54S3GAhWL4FeSWAw0k6CkZRMnaCSNoQgMPLNk3y4/nwC/sOTbL+9jGZRRMkkGRPAA6T06avXwWwO8kf9wFqbBtjJogk/3i9G8AtY8e7Aj2/fTkAXrF5Ydp8dC1wSSsqyeHw39SSJL42PICkzR6KkDESRJJzlzhaZtuQTPZFdxYsx/oqVkZBkLCSOCSl07q17bND7exL0gaPg8rYCCJpIwA+jG/QEjjH3/UliuMLFy1tP7ZeBycpF0kcjc8ksX/8YDIWgkjyGfDgkBDJlrltxLk//FbVq2dg0w6PiiCZVxJX5z20c9vZnbd3GQNBJO0MwDZRjrzeVnwrueOYApOPjiCBJDaRP62BZ9qKJvjqYG16bN83KSUTJCSyOR6AbeRyiGOb7UXSkUlGI6MkSCDJfQB8FMDdMqHttMu79bmalEgQSU6Z9zIAh2bC1dW8gmRT85OM3UivarQECSRx0If3NYjWuDKk/AJvH4ReDo+lESSYi/hK3VfrOeQvAJ46RLCFHJ13HaMmSCCJD5A2kMuVJ+Jkkr5W7lwKJMgOAHJZHvgQ/viSLRliJnj0BFk2yHCY9Lnk1jEDX0TH5vK37cMXoUCCNAkFuiIoz7GLbZ/b1ZZzvtLikyFIWE3WA/DBDPf0TgHXuTVwgQQ5D4Bt4JqK3WR9dnGghcGdnZoOYmG5SREkkMSmD8d679sCoF6ihxdIEEeYuXdD3FzWxqEXNCxfZLHJEWTBlst5Reyf4ByJqVIJEo+Y45T5neRFY7vCjRniZAkSVpPbA/BdfuqtTCVIzNfz1/CxjyNpT85JyqQJsmA1eRqA4xJmsBJkabBspv5IktcurTpejbkQZIvgoRg7U5UgSyN1PMmnL602bo1KkBXPXyXI0t91JcjSGI1DQ1JdQSKmSlLKLVYlSASmo1BpQJC9AHT+DgLgwwBWiQTRDmN+CM0tfq+41O8+lSA3hLZusXJ/buOtz3ZoNweweuQQ6goSCVTxag1WkOLHVEAHK0EKmIQsXagEyQLj8pVUgnQC6wCVVoJ0AnolSCewDlBpJUgnoFeCdALrAJVWgnQCeiVIJ7AOUGklSCegV4J0AusAlVaCdAJ6JUgnsA5QaSVIJ6BXgnQC6wCVVoJ0AnolSCewDlBpJUgU6H5Jd9zdO0ZpA5UgkUAVr9aAIH3ZYpWAXbXFWmQWqi3WisHpxdy9BHYs7EM1VrzhjFSCVIJcj0AlSCVI7I92XUGWRqqeQZbGaBwaDc4glSBLT20lyNIYjUOjEiRunuoWq26x4r4UoK4gSyNVV5ClMRqHRl1B4uapriB1BYn7UuoKEoNTXUFiUBqDjqQHAzg3oa8bk7wwQX8SqpIuSUi1dhzJZ0xi4PWhUA7I7JA2VfIhcATJl+Srrsya5vJQ6Bi9V5Y5BaPtlTNHOS33pGUWBPEMSnKcqztPejb7HdwstqFzIoiDVzuIdZX2CPyc5F3aV1N+DXMiiM8hFwNwFtcq7RA4kuQL21UxjtKzIUjYZr0VwN7jmJpie3kVgLuT/EOxPczYsbkRxNsCpwiLdQrKCPVkqtqdpFNvz0JmRZCwijwovIncdBYznHeQryT5/LxVll3b7AgSSOJ0CGc63XPZ01NU744mmSsXfVEDW6wzsyRIIIkP7W8GsOloZmuYjv4KwPNJnjpM88O2OluCLINd0vYA9gewI4CbDTsdRbXuxJxvA3AiyWuK6lmPnZk9QRYQxYlsbLO1JgAf5m+SOA+3A1CSbdIPwgceOwwHb/AN1eUALiR5WWzBKetVgmScXUnnA7h/xirbVHUgyRPaVFDLApUgGb8CSfuFc03GWhtVdYVXQpJ/alS6FroegUqQjB+DJG/LzgPgq+Qh5ckkTx6yA1NpuxIk80xKuhuAiwCslrnq2OrOJrldrHLVWxyBSpAOvhBJOwE4A8CNO6h+sSptJbDFXMxA+sC2EqQjlCVtDuA94Uaso1b+plpfy25N8nd9NDaXNipBOpxpSU6pfBaATTps5i8AXgPghSSv7bCdWVZdCdLxtEuyzdc+AA4DsE7G5vxecQqAk0j+KGO9taoFCFSC9PQ5SLIfil/rtwWwDQCbuqTKbwC8H8BpAD5D0qtHlQ4RqATpENzFqpa0KoB7AdgAwFoLHLn8ov378KptP3r/+V3Df78m6f+/Sk8I/B+caf9QcOsJVgAAAABJRU5ErkJggg==";
}

+ (NSString *)circleImageBase64
{
    return @"data:image/png;base64,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";
}

+ (NSString *)homeImageBase64
{
    return @"data:image/png;base64,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";
}

@end
