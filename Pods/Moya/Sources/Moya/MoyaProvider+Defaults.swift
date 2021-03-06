import Foundation

/// These functions are default mappings to `MoyaProvider`'s properties: endpoints, requests, manager, etc.
public extension MoyaProvider {
    public final class func defaultEndpointMapping(for target: Target) -> Endpoint<Target> {
        //var url = target.baseURL.appendingPathComponent(target.path).absoluteString.replacingOccurrences(of: "2", with: "+")
       // url = url.replacingOccurrences(of: "2", with: "+")
        
        return Endpoint(
            url: URL(target: target).absoluteString,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
    }

    public final class func defaultRequestMapping(for endpoint: Endpoint<Target>, closure: RequestResultClosure) {
        if let urlRequest = endpoint.urlRequest {
            closure(.success(urlRequest))
        } else {
            closure(.failure(MoyaError.requestMapping(endpoint.url)))
        }
    }

    public final class func defaultAlamofireManager() -> Manager {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Manager.defaultHTTPHeaders

        let manager = Manager(configuration: configuration)
        manager.startRequestsImmediately = false
        return manager
    }
}
