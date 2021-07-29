
//  Scrumptious APP
//
//  Created by mohamed ayed
//


import Foundation
import Combine


class ProfileVM:ObservableObject{
    
    enum PasswordErrorType{
        
        case passwordNotStrongEnough
        
        case passwordNotMatch
        case valid
        
        
    }
   
    
    @Published var profileUsername = ""
    @Published var profileEmail = ""
    @Published var profilePhoneNumber = ""
    @Published var profileCompany = ""
    @Published var profileCompanyBranch = ""
    @Published var profileCompanyID = 0
    
    @Published var profileDeskLocation = ""
    
    @Published var profilePassword  = ""
    
    @Published var profilePasswordAgain  = ""
    
    @Published var inlineErrorText  = ""
    
    @Published var isValid = false
 
    
    func decode(){
        if let savedPerson = UserDefaults.standard.object(forKey: "userInfo") as? Data {
            let decoder = JSONDecoder()
            if let userInfoObj = try? decoder.decode(User.self, from: savedPerson) {
                guard let profileUsername = userInfoObj.name, let profileEmail = userInfoObj.email,let profileCompany = userInfoObj.agent_name,let profileCompanyBranch = userInfoObj.branch_name,let profilePhoneNumber = userInfoObj.mobile_number,let profileCompanyID = userInfoObj.agent else{return}
                
                self.profileUsername = profileUsername
                self.profileEmail = profileEmail
                self.profileCompany = profileCompany
                self.profileCompanyBranch = profileCompanyBranch
                self.profilePhoneNumber = String(profilePhoneNumber)
                self.profileCompanyID = profileCompanyID

                
            }
        }
        
        
    }
    
    
    
    func updateUser(dict:[String:Any]){
        
       // print("\(dict)TB3n")
        
        API.UpdateProfile(dict: dict) { (error:Error?, success:Bool?,user:User?) in
            if let success  = success{
                
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(user) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "userInfo")
                    }
                print("User updated successfully")
                
            }
        }
        
       
        
    }
 
    private var cancellables = Set<AnyCancellable>()
    
    
    
    private var isPasswordStrongEnoughPublisher:AnyPublisher<Bool,Never>{
        
        $profilePassword.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{$0.count > 5}
            .eraseToAnyPublisher()
        
        
    }
    
    
    private var isPasswordMatchPublisher:AnyPublisher<Bool,Never>{
        
        Publishers.CombineLatest($profilePassword,$profilePasswordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{$0 == $1}
            .eraseToAnyPublisher()
        
        
    }
    
    
    private var isPasswordValidPublisher:AnyPublisher<PasswordErrorType,Never>{
        
        Publishers.CombineLatest(isPasswordStrongEnoughPublisher,isPasswordMatchPublisher)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{
                
                if !$0{return PasswordErrorType.passwordNotStrongEnough}
                if !$1{return PasswordErrorType.passwordNotMatch}
                return PasswordErrorType.valid
                
            }.eraseToAnyPublisher()
     
        
        
        
    }
    
    init() {
        self.decode()
        isPasswordValidPublisher.receive(on:RunLoop.main)
            .dropFirst()
            .map{
                
                switch($0){
                
                case .passwordNotStrongEnough:
                
                return "password must be more than 5 charchaters"
                
                case .passwordNotMatch:
                
                return "Password not match"
                
                case .valid:
                
                return ""
                
                
                
                }
                
            }.assign(to: \.inlineErrorText, on: self)
            .store(in: &cancellables)
    }
    
    
    
    
    
}
