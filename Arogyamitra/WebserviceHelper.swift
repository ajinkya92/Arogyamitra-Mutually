//
//  WebserviceHelper.swift
//  Arogyamitra
//
//  Created by Nitin Landge on 15/12/18.
//  Copyright © 2018 Nitin Landge. All rights reserved.
//

import Foundation
import UIKit
public typealias successBlock = (Data?) -> Void
public typealias failureBlock = (String) -> Void

class WebserviceHelper: NSObject
{
    private let manager = NetworkReachabilityManager(host: googleUrl)
    
    func isNetworkReachable() -> Bool
    {
        return manager?.isReachable ?? false
    }
    static let sharedInstance = WebserviceHelper()
    
    override init()
    {
        // do initial setup or establish an initial connection.
    }
    
    // POST REQUEST
    func getData(URL: String, parameterDict: [String: Any], methodType:HTTPMethod, headerDict: [String: String],Encoding:ParameterEncoding, successBlock: @escaping successBlock, failureMessage:@escaping failureBlock)-> Void
    {
        print("URL: \(URL)")
        print("Body: \(parameterDict)")
        print("Method Type : \(methodType)")
        print("Headers: \(headerDict)")
        
        if self.isNetworkReachable()
        {
            request(URL, method: methodType, parameters: parameterDict, encoding: Encoding, headers: headerDict).responseJSON
                {
                    (response) in
                    
                    let responseResult = response.result.value
                    print(responseResult ?? "")
                    
                    let code = response.response?.statusCode
                    print("STATUS CODE: \(String(describing: code))")
                    
                    if (code == 200 || code == 201)
                    {
                        if let ResponseData = response.data
                        {
                            successBlock(ResponseData)
                        }
                        else
                        {
                            failureMessage("\(String(describing: response.response?.statusCode.description))  \n Please try again")
                        }
                    }
                    else
                    {
                        if let JSONDict:[String:Any] = response.result.value as? [String : Any]
                        {
                            if let errorMessage:String = (JSONDict["message"] as? String)
                            {
                                failureMessage(errorMessage)
                            }
                            else
                            {
                                failureMessage(otherStatusCodeErrorMessage)
                            }
                        }
                        else
                        {
                            failureMessage(otherStatusCodeErrorMessage)
                        }
                        
                    }
                    
            }
            
        }  // If Network Reachable else
        else
        {
            //            failureMessage(NoInternetConnectionMessage)
            showAlertMessage(message: noInternetConnectionMessage, title: "")
        }
    }
}
