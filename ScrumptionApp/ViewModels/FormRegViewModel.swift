
//  Scrumptious APP
//
//  Created by mohamed ayed
//

import Foundation
import Combine
class FormRegViewModel:ObservableObject{
    
    
    @Published var companyList = [Companies]()
    
    @Published var branchList = [Branches]()
    
    @Published var showingBranchDialog = false
    
    @Published var RegistrationSuccess = false
    
    @Published var BranchListDone = false
    
    @Published var CompanyListDone = false
    
    @Published var username = ""
    
    @Published var emailAddress  = ""
    
    @Published var passwordLogin = ""
    
    @Published var emailLogin = ""
    
    @Published var phoneNumber = ""
    
    @Published var companyName = ""
    
    @Published var deskLocation = ""
    
    @Published var password  = ""
    
    @Published var passwordAgain = ""
    
    @Published var isValid = false
    
    
    @Published var inlineErrorText = ""
    
    enum FormStatus{
        case passwordEmpty
        case passwordsNotEqual
        case NotStrongEnough
        case valid
        
        
    }
    
    enum FieldStatus{
        
        
        case userNameNotValid
        case emailAddressNotValid
        case deskEmpty
        case valid
        
    }

    @Published var ApiToken :String  = helpers.getApiToken() ?? ""
   
//
//    @Published var ApiToken :String = UserDefaults.standard.string(forKey: "ApiToken") ?? ""{
//
//        didSet{
//            UserDefaults.standard.setValue(self.IsLoggedIn, forKey: "ApiToken")
//        }
//
//    }
//

    
    
    
    @Published var IsLoggedIn :Bool = UserDefaults.standard.bool(forKey: "IsLoggedIn"){
        
        didSet{
            
            UserDefaults.standard.setValue(self.IsLoggedIn, forKey: "IsLoggedIn")
        }
        
    }

        
    
    private static let predicate = NSPredicate(format:"SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}")
    
    func getCompaniesList(){
        
        let dict = [
            "_identifier":"API",
            "_type_params[type]":"getCompanies"
        ]
        API.getCompanies(dict: dict) { (error:Error?,company: [Companies]?) in
            if let company = company{
                self.companyList.append(contentsOf: company)
            }
            print(self.companyList)
            
        }
        if self.companyList.count > 0{
            CompanyListDone = true
        }
        
    }
    
    
    func getBranchesList(agentID:Int){
        
        let dictBranch = [
            "_identifier":"API",
            "_type_params[type]":"getBranches",
            "_type_params[agent]":agentID
        ] as [String : Any]
        
        self.branchList = [Branches]()
        API.getBranches(dict: dictBranch) { (error:Error?, branch:[Branches]?) in
            if let branch = branch{
                
                self.branchList.append(contentsOf: branch)
                
            }
            if(self.branchList.count > 0){
                self.showingBranchDialog = true
                self.BranchListDone = true
            }else{
                self.showingBranchDialog = false
            }
            
            
            print(self.branchList)
        }
        
        
    }
    
    
    func registerUser(dict:[String:Any]){
        
        API.Register(dict: dict) { (error:Error?, success:Bool?, token:String?,user:User?) in
            if let token  = token{
                
                    let encoder = JSONEncoder()
                    if let encoded = try? encoder.encode(user) {
                        let defaults = UserDefaults.standard
                        defaults.set(encoded, forKey: "userInfo")
                    }
                
                
                if !token.isEmpty{
                    helpers.setApiToken(token: token)
                    self.IsLoggedIn = true
                }
                
            }
        }
        
       
        
    }
    
    
    func loginUser(dict:[String:Any]){
        
        API.Login(dict: dict) { (error:Error?, success:Bool?, token:String?,user:User?) in
            if let token  = token{
                
                self.ApiToken = token
                
                print("token--token\(token)\(self.ApiToken)Hadeer")
            
                let encoder = JSONEncoder()
                if let encoded = try? encoder.encode(user) {
                    let defaults = UserDefaults.standard
                    defaults.set(encoded, forKey: "userInfo")
                }
                
                
                if !token.isEmpty{
                    helpers.setApiToken(token: token)
                    self.IsLoggedIn = true
                }
                
            }
        }
        print("helpers.getApiToken()\(helpers.getApiToken())")
        
    }
    
    
    func logout(){
        
       
        if !self.ApiToken.isEmpty{
            print("here\(self.ApiToken)")
            
            helpers.removeAPiToken()
            self.ApiToken = ""
            self.IsLoggedIn = false
        }
        
        
    }
    
    
    private var cancellables = Set <AnyCancellable>()
    
    private var isUserNameValidPublisher: AnyPublisher< Bool, Never>{
        
        $username.debounce(for: 0.2, scheduler: RunLoop.main)
            .removeDuplicates()
            .map{ $0.count >= 3 }
            .eraseToAnyPublisher()
        
        
    }
    
    
    
    
    
    private var isPasswordEmptyPublisher:AnyPublisher<Bool,Never>{
        
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ $0.isEmpty }
            .eraseToAnyPublisher()
        
    }
    
    
    private var isPasswordsEqualPublisher:AnyPublisher<Bool,Never>{
        
        
        Publishers.CombineLatest($password,$passwordAgain)
            .debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ $0 == $1}
            .eraseToAnyPublisher()
        
        
        
    }
    
    private var isPasswordStrongEnoughPublisher:AnyPublisher<Bool,Never>{
        
        $password.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{ $0.count > 5}
            .eraseToAnyPublisher()
        
        
    }
    
    
    private var isDeskLocationEmpty:AnyPublisher<Bool,Never>{
        
        $deskLocation.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{
                $0.isEmpty
            }.eraseToAnyPublisher()
        
        
    }
    
    
    private var isEmailValidPublisher:AnyPublisher<Bool,Never>{
        
        $emailAddress.debounce(for: 0.2, scheduler: RunLoop.main)
            .map{
                FormRegViewModel.predicate.evaluate(with: $0)
            }
            .eraseToAnyPublisher()
        
    }
    
    
    private var isFormFieldsPassed:AnyPublisher<FieldStatus,Never>{
        
        
        Publishers.CombineLatest3(isUserNameValidPublisher,isDeskLocationEmpty,isEmailValidPublisher)
            .dropFirst()
            .map{
                
                if !$0{return FieldStatus.userNameNotValid}
                if !$2{return FieldStatus.emailAddressNotValid}
                if $1{return FieldStatus.deskEmpty}
               
                return FieldStatus.valid
            }.eraseToAnyPublisher()
        
    }
    
    
    private var IsPasswordValidPublisher:AnyPublisher<FormStatus,Never>{
        
        Publishers.CombineLatest3(isPasswordEmptyPublisher,isPasswordsEqualPublisher,isPasswordStrongEnoughPublisher)
            .dropFirst()
            .map{
                
                
                if $0{return FormStatus.passwordEmpty}
                if !$2{return FormStatus.NotStrongEnough}
                if !$1{return FormStatus.passwordsNotEqual}
                
                
                return FormStatus.valid
            }.eraseToAnyPublisher()
        
        
        
    }
    
    
    
    
    
    private var isFormValidPublisher:AnyPublisher<Bool,Never>{
        
        
        Publishers.CombineLatest(isFormFieldsPassed,IsPasswordValidPublisher)
            .map{ $0 == .valid && $1 == .valid }
            .eraseToAnyPublisher()
        
        
    }
    
    init() {
        
        
        
        isFormValidPublisher
            .receive(on: RunLoop.main)
            .assign(to: \.isValid, on: self)
            .store(in:&cancellables)
        
        
        IsPasswordValidPublisher
            .receive(on: RunLoop.main)
            .dropFirst()
            .map{
                
                switch($0){
                
                case .passwordEmpty:
                    
                    return "Please fill your password"
                    
                  
                    
                case .NotStrongEnough:
                    return "Password charachter must be more than 5"
                    
                
                    
                case .passwordsNotEqual:
                    
                    return "Password must be the equal"
                    
                case .valid:
                return ""
                
                }
            }.assign(to: \.inlineErrorText, on: self)
            .store(in:&cancellables)
        
        
        isFormFieldsPassed
        .receive(on:RunLoop.main)
        .dropFirst()
        .map{
            switch($0){
            case .userNameNotValid:
                return "Please enter your username"
            case .emailAddressNotValid:
                return "Please add valid email address"
                
            case .deskEmpty:
                return "Please Fill your desk location"
                
                
                
            case .valid:
                return ""
                
                
            }
        }.assign(to: \.inlineErrorText, on: self)
        .store(in:&cancellables)
    
       
        
        
        
        
        
    }
    
    
    
}
