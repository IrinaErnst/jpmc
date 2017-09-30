//
//  LyricaWikieService.swift
//  jpmc
//
//  Created by Irina Ernst on 9/30/17.
//  Copyright © 2017 irinaernst. All rights reserved.
//

// http://lyrics.wikia.com/api.php?func=getSong&artist=Tom+Waits&song=new+coat+of+paint&fmt=json
//struct LyricsWikiaService: NetworkServiceType {
//
//    // MARK: - Properties
//    private(set) var provider: MoyaProvider<JPMC>
//
//    // MARK: - Initializers(s)
//    init(provider: MoyaProvider<JPMC> = MoyaProvider<JPMC>(endpointClosure: endpointClosure,
//                                                           manager: DefaultAlamofireManager.sharedManager,
//                                                           plugins: [LoggerPlugin()]))
//    {
//        self.provider = provider
//    }

//    func getSongLyric(with song: String, completion: @escaping (Result<[Truck], Moya.MoyaError>) -> Void) {
//        let dictionary =
//
//        let target = JPMC.search(dictionary: ["term": term])
//        //requestArray(target: target) { result in
//        request(target: target) { result in
//            switch result {
//            case let .success(json):
//                print("❤️ JSON: \(json)")
//                if let trucksArray = json["results"] as? JSONArray {
//                    var trucks = [Truck]()
//                    for truck in trucksArray {
//                        trucks.append(Truck.deserialize(from: truck))
//                    }
//                    //trucks = Truck.deserialize(from: trucksArray)
//                    print("❤️ TRUCKS: \(trucks)")
//                    completion(.success(trucks))
//                }
//            case let .failure(error):
//                completion(.failure(MoyaError.underlying(error, nil)))
//            }
//        }
//    }
    
    
//}

