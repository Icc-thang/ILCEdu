//
//  SwitchViewController.swift
//  ICLEdu
//
//  Created by Tuan Ta on 10/2/19.
//  Copyright © 2019 Ta Tuan. All rights reserved.
//

import UIKit
import Moya
import ObjectMapper

class SwitchViewController: UIViewController {
    var rootVC : UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchView()
    }
    
    func switchView(){
        if(token == nil || token == ""){
            rootVC = UIStoryboard(name: "LoginController", bundle: nil).instantiateViewController(withIdentifier: "LoginController") as! LoginViewController
            self.navigationController?.pushViewController(rootVC!, animated: false)
        }else {
            
            rootVC = UIStoryboard(name: "TabbarController", bundle: nil).instantiateViewController(withIdentifier: "TabbarController") as! BubbleTabBarController
            getDataForProfile(view: rootVC!)
        }
    }
    
    func getDataForProfile(view: UIViewController){
        let profileProvider = MoyaProvider<ProfileRequest>()
        profileProvider.request(.getProfile){ (result) in
            switch result {
            case .success(let response):
                do{
                    let json = try response.mapJSON()
                    guard let dataJSON = Mapper<ProfileModel>().map(JSONObject: json)
                        else{
                            return
                    }
                    profileData = dataJSON
                    print("profile data: \(dataJSON)")
                    self.navigationController?.pushViewController(view, animated: false)
                }catch{
                    print("error TOKEN VALUE for HEADER")
                }
            case .failure(_):
                print("Fail connect")
            }
        }
    }
}
