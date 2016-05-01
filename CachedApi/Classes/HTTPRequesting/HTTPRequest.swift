//
//  HTTPRequest.swift
//  CachedApi
//
//  Created by wegie on 2016/05/01.
//  Copyright © 2016年 wegie. All rights reserved.
//

import Alamofire
import JsonData
import AlamofireJsonData
import Promise

public class HTTPRequest {

    private let host: String

    public init(host: String) {
        self.host = host
    }

}

extension HTTPRequest {

    public func headers(method: HTTPMethod, path: HTTPRequestPath) -> [String : String]? {
        return nil
    }

}

extension HTTPRequest {

    public func requestJsonData(method: HTTPMethod, path: HTTPRequestPath,
                                params: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL) -> Promise<JsonData> {
        return Promise<JsonData> { resolve, reject in
            Alamofire.request(method.method, path.path(host), parameters: params, encoding: encoding, headers: self.headers(method, path: path))
                .responseJsonData() { (response: Response<JsonData, NSError>) in
                    if response.result.isSuccess {
                        resolve(response.result.value!)
                    } else {
                        reject(response.result.error!)
                    }
            }
        }
    }

    public func requestData(method: HTTPMethod, path: HTTPRequestPath,
                            params: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL) -> Promise<NSData> {
        return Promise<NSData> { resolve, reject in
            Alamofire.request(method.method, path.path(host), parameters: params, encoding: encoding, headers: self.headers(method, path: path))
                .responseData() { (response: Response<NSData, NSError>) in
                    if response.result.isSuccess {
                        resolve(response.result.value!)
                    } else {
                        reject(response.result.error!)
                    }
            }
        }
    }

    public func requestString(method: HTTPMethod, path: HTTPRequestPath,
                              params: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL) -> Promise<String> {
        return Promise<String> { resolve, reject in
            Alamofire.request(method.method, path.path(host), parameters: params, encoding: encoding, headers: self.headers(method, path: path))
                .responseString() { (response: Response<String, NSError>) in
                    if response.result.isSuccess {
                        resolve(response.result.value!)
                    } else {
                        reject(response.result.error!)
                    }
            }
        }
    }

    public func requestObject<T, Parser where Parser : HTTPResponseParser, T == Parser.T>(method: HTTPMethod, path: HTTPRequestPath,
                              params: [String : AnyObject]? = nil, encoding: ParameterEncoding = .URL,
                              parser: Parser) -> Promise<T> {
        return requestData(method, path: path, params: params, encoding: encoding).then(parser.parse)
    }

}


extension HTTPRequest {

    public func requestObject<T where T : Objectable, T == T.ObjectType>(method: HTTPMethod, path: HTTPRequestPath,
                              params: [String : AnyObject]?, encoding: ParameterEncoding) -> Promise<T> {
        return requestJsonData(method, path: path, params: params, encoding: encoding).then {
            switch T.boxing($0) {
            case .Boxing(let item):
                return Promise.resolve(item)
            case .Error(let errorInfos):
                return Promise.reject(errorInfos.error)
            }
        }
    }

}
