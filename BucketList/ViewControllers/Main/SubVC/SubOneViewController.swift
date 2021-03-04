//
//  SubOneViewController.swift
//  BucketList
//
//  Created by Taein Kim on 2021/03/01.
//

import Alamofire
import Foundation
import HeroCommon
import HeroUI
import ObjectMapper
import SnapKit

public class SubOneViewController: HeroBaseViewController {
    private var oneLabel: UILabel = UILabel()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBlue
        view.addSubview(oneLabel)
        
        oneLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(120)
        }
        oneLabel.font = .font15PBold
        oneLabel.textColor = .white
        oneLabel.text = "111. One View Controller"
        
        PromiseSampleAPIRequest(method: .get)
            .getUserInfo().then { json -> Void in
                DebugLog("\(json)")
            }.catch { error in
                ErrorLog(error.localizedDescription)
            }
        
//        let url = URL(string: "https://reqres.in/api/users/2")!
//        let heroRequest = HeroRequest(path: "2", httpMethod: .get  , encoding: .urlQuery, parameter: nil)
//        Alamofire.request(url).responseJSON { response in
//            print("RESPONSE1 : \(response.result.isSuccess) \(response.result.value)")
//        }
        
//        Alamofire.request(heroRequest).responseJSON { response in
//            print("RESPONSE2 : \(response.result.isSuccess) \(response.result.value)")
//            do {
//                if let dictValue = response.result.value as? NSDictionary {
//                    let jsonData = try JSONSerialization.data(withJSONObject: dictValue, options: .prettyPrinted)
//                    let getData = try JSONDecoder().decode(BucketListNoticeServerModel.self, from: jsonData)
//                    print(">>>> getData : \(getData)")
//                }
//            } catch {
//                print("ERROR")
//            }
//        }
//
        BucketListAPIRequest.homeNoticeListRequest()
    }
}
