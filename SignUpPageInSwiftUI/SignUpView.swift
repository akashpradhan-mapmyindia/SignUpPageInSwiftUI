
import SwiftUI

@available(iOS 13.0, *)
struct SignUpView: View {
    
    @State var emailId: String
    @State var fullName: String = ""
    @State var password: String = ""
    @State var isPasswordVisible2: Bool = false
    @State var isPasswordVisible1: Bool = false
    @State var reenterPassword: String = ""
    @State var continueBtnDisabled: Bool = true
    @State var emailDisabled: Bool = true
    @State var fNameFloatingOpacity: Double = 0.0
    @State var fNameRightIcon: String = ""
    @State var contBtnOpacity: Double = 0.5
    @State var fNameErrorTxt: String = ""
    @State var passwordMismatchTxt: String = ""
    @State var passwordDescTxt: String = ""
    @State var passStrength: String = ""
    @State var check1: String = "login-uncheck"
    @State var check2: String = "login-uncheck"
    @State var check3: String = "login-uncheck"
    @State var check1Color: Color = .gray
    @State var check2Color: Color = .gray
    @State var check3Color: Color = .gray
    @State var passFloatingOpacity: Double = 0.0
    @State var reenterPassFloatingOpacity: Double = 0.0
    @State var passTextInField: String = "Password"
    @State var fNamePlaceholder: String = "Full Name"
    @State var reEnterPassPlaceholder: String = "Re-enter Password"
    @State var continBtnTitle: String = "Continue"
    @State var nameCorrect: Bool = false
    @State var passCorrect: Bool = false
    @State var rePassCorrect: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 10) {
                    Text("Sign Up")
                        .font(.system(size: 34))
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Text("Please provide details to create your account")
                        .font(.system(size: 14))
                        .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        TextField("", text: $emailId)
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                            .disabled(emailDisabled)
                        
                        Spacer()
                        
                        SwiftUI.Image("Check_1")
                            .frame(width: 22, height: 22)
                    }
                    .frame(height: 40)
                    .overlay(
                        Rectangle()
                            .fill(Color(red: 60/255, green: 60/255, blue: 41/255))
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding([.top])
                        , alignment: .bottom
                    )
                    .padding([.top], 20)
                    
                    
                    VStack(spacing: 5) {
                        
                        Text("Full Name")
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                            .opacity(fNameFloatingOpacity)
                        
                        HStack {
                            TextField(fNamePlaceholder, text: $fullName, onEditingChanged: { editingChanged in
                                
                                if editingChanged {
                                    if password == "" {
                                        passFloatingOpacity = 0.0
                                        passTextInField = "Password"
                                    }
                                    if reenterPassword == "" {
                                        reenterPassFloatingOpacity = 0.0
                                        reEnterPassPlaceholder = "Re-enter Password"
                                    }
                                    fNameFloatingOpacity = 1.0
                                    fNamePlaceholder = ""
                                }else {
                                    if fullName == "" {
                                        fNameFloatingOpacity = 0.0
                                        fNamePlaceholder = "Full Name"
                                    }
                                }
                            })
                            .frame(maxWidth: .infinity)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                            .onChange(of: fullName) { newValue in
                                if newValue.isEmpty {
                                    fNameErrorTxt = "Enter Name"
                                    fNameRightIcon = "Close_1"
                                    nameCorrect = false
                                }else if newValue.count < 3 {
                                    fNameErrorTxt = "Please enter atleast 3 character"
                                    fNameRightIcon = "Close_1"
                                    nameCorrect = false
                                }else if newValue.removingWhitespaces().count < 3 {
                                    fNameErrorTxt = "Name should be of at least 3 characters"
                                    fNameRightIcon = "Close_1"
                                    nameCorrect = false
                                }else{
                                    fNameErrorTxt = ""
                                    fNameRightIcon = "Check_1"
                                    nameCorrect = true
                                }
                                
                                checkValidations()
                            }
                            
                            Spacer()
                            
                            SwiftUI.Image(fNameRightIcon)
                                .frame(width: 22, height: 22)
                        }
                        .frame(height: 40)
                        .overlay(
                            Rectangle()
                                .fill(Color(red: 60/255, green: 60/255, blue: 41/255))
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding([.top])
                            , alignment: .bottom
                        )
                        
                        Text(fNameErrorTxt)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 224/255, green: 48/255, blue: 33/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.top], 10)
                    
                    VStack(spacing: 5) {
                        
                        Text("Password")
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                            .opacity(passFloatingOpacity)
                        
                        HStack {
                            if isPasswordVisible1 {
                                TextField(passTextInField, text: $password) { changed in
                                    
                                    if changed {
                                        if reenterPassword == "" {
                                            reenterPassFloatingOpacity = 0.0
                                            reEnterPassPlaceholder = "Re-enter Password"
                                        }
                                        passFloatingOpacity = 1.0
                                        passTextInField = ""
                                    }else {
                                        if password == "" {
                                            passFloatingOpacity = 0.0
                                            passTextInField = "Password"
                                        }
                                    }
                                }
                            } else {
                                SecureField(passTextInField, text: $password, onCommit: {
                                    if password == "" {
                                        passFloatingOpacity = 0.0
                                        passTextInField = "Password"
                                    }
                                })
                                .onTapGesture {
                                    if reenterPassword == "" {
                                        reenterPassFloatingOpacity = 0.0
                                        reEnterPassPlaceholder = "Re-enter Password"
                                    }
                                    passFloatingOpacity = 1.0
                                    passTextInField = ""
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                isPasswordVisible1.toggle()
                            }) {
                                SwiftUI.Image(isPasswordVisible1 ? "view" : "view-off")
                                    .frame(width: 22, height: 22)
                            }
                        }
                        .frame(height: 40)
                        .overlay(
                            Rectangle()
                                .fill(Color(red: 60/255, green: 60/255, blue: 41/255))
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding([.top])
                            , alignment: .bottom
                        )
                        .onChange(of: password) { newValue in
                            let fails = PasswordValidator.getFailedRules(newValue, PasswordRule.allCases)
                            if fails.count == 3 {
                                check1Color = .gray
                                check2Color = .gray
                                check3Color = .gray
                            }else {
                                var passStngthNum = 0
                                if fails.count == 0{
                                    passStrength = "Password: Strong"
                                }else if fails.count == 1{
                                    passStrength = "Password: Average"
                                    passStngthNum = 1
                                }else{
                                    passStrength = "Password: Weak"
                                    passStngthNum = 2
                                }
                                if fails.contains(PasswordRule.lengthOfCharacters) {
                                    check1 = "login-uncheck"
                                }else {
                                    check1 = "circle-checked"
                                }
                                if fails.contains(PasswordRule.specialCharacterOrNumber) {
                                    check2 = "login-uncheck"
                                }else {
                                    check2 = "circle-checked"
                                }
                                if fails.contains(PasswordRule.capitalLetter) {
                                    check3 = "login-uncheck"
                                }else{
                                    check3 = "circle-checked"
                                }
                                check1Color = PasswordValidator.getPasswordStrengthColor(passwordStrength: passStngthNum, viewIndex: 0)
                                check2Color = PasswordValidator.getPasswordStrengthColor(passwordStrength: passStngthNum, viewIndex: 1)
                                check3Color = PasswordValidator.getPasswordStrengthColor(passwordStrength: passStngthNum, viewIndex: 2)
                            }
                            
                            if !PasswordValidator.getIsPasswordValid(newValue, PasswordRule.allCases){
                                passwordDescTxt = "Invalid Password"
                                continBtnTitle = "Invalid Password"
                                contBtnOpacity = 1.0
                                passCorrect = false
                            }else{
                                passwordDescTxt = ""
                                continBtnTitle = "Continue"
                                passCorrect = true
                                if reenterPassword != "" {
                                    if reenterPassword != password {
                                        passwordMismatchTxt = "Password mismatch"
                                        rePassCorrect = false
                                        continBtnTitle = "Password mismatch"
                                    }else{
                                        rePassCorrect = true
                                        passwordMismatchTxt = ""
                                        continBtnTitle = "Continue"
                                    }
                                }
                            }
                            
                            checkValidations()
                        }
                        
                        Text(passwordDescTxt)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 224/255, green: 48/255, blue: 33/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.top], 7)
                    
                    VStack(spacing: 7) {
                        HStack(spacing: 3) {
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(check1Color)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(check2Color)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(check3Color)
                                .cornerRadius(10)
                        }
                        
                        Text(passStrength)
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                SwiftUI.Image(check1)
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                
                                Text("Must be at least 8 characters")
                            }
                            .padding([.top, .leading], 10)
                            
                            HStack {
                                SwiftUI.Image(check2)
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                
                                Text("Contain a special character or number")
                            }
                            .padding([.leading], 10)
                            
                            HStack {
                                SwiftUI.Image(check3)
                                    .resizable()
                                    .frame(width: 22, height: 22)
                                
                                Text("Include a capital letter")
                            }
                            .padding([.leading, .bottom], 10)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(red: 243/255, green: 243/255, blue: 243/255))
                        .cornerRadius(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(.gray, lineWidth: 1)
                        )
                        .font(.system(size: 15))
                        .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                    }
                    .padding([.top], 20)
                    
                    VStack(spacing: 5) {
                        
                        Text("Re-enter Password")
                            .font(.system(size: 15))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundColor(Color.init(red: 121/255, green: 121/255, blue: 121/255))
                            .opacity(reenterPassFloatingOpacity)
                        
                        HStack {
                            if isPasswordVisible2 {
                                TextField(reEnterPassPlaceholder, text: $reenterPassword) { changed in
                                    if changed {
                                        if password == "" {
                                            passFloatingOpacity = 0.0
                                            passTextInField = "Password"
                                        }
                                        reenterPassFloatingOpacity = 1.0
                                        reEnterPassPlaceholder = ""
                                    }else {
                                        if reenterPassword == "" {
                                            reenterPassFloatingOpacity = 0.0
                                            reEnterPassPlaceholder = "Re-enter Password"
                                        }
                                    }
                                }
                            } else {
                                SecureField(reEnterPassPlaceholder, text: $reenterPassword, onCommit: {
                                    if reenterPassword == "" {
                                        reenterPassFloatingOpacity = 0.0
                                        reEnterPassPlaceholder = "Re-enter Password"
                                    }
                                })
                                .onTapGesture {
                                    if password == "" {
                                        passFloatingOpacity = 0.0
                                        passTextInField = "Password"
                                    }
                                    reenterPassFloatingOpacity = 1.0
                                    reEnterPassPlaceholder = ""
                                }
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                isPasswordVisible2.toggle()
                            }) {
                                SwiftUI.Image(isPasswordVisible2 ? "view" : "view-off")
                                    .frame(width: 22, height: 22)
                            }
                        }
                        .frame(height: 40)
                        .overlay(
                            Rectangle()
                                .fill(Color(red: 60/255, green: 60/255, blue: 41/255))
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding([.top])
                            , alignment: .bottom
                        )
                        .onChange(of: reenterPassword) { newValue in
                            if password != reenterPassword{
                                passwordMismatchTxt = "Password mismatch"
                                continBtnTitle = "Password mismatch"
                                contBtnOpacity = 1.0
                                rePassCorrect = false
                            }else{
                                passwordMismatchTxt = ""
                                continBtnTitle = "Continue"
                                rePassCorrect = true
                            }
                            checkValidations()
                        }
                        
                        Text(passwordMismatchTxt)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 224/255, green: 48/255, blue: 33/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.top], 20)
                    
                    Button(continBtnTitle) {
                        print("Submitted")
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    .padding([.top], 20)
                    .disabled(continueBtnDisabled)
                    .opacity(contBtnOpacity)
                    .onTapGesture {
                        submitValidCheck()
                    }
                }
                .padding([.leading, .trailing], 20)
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: Button("Back") {
            self.presentationMode.wrappedValue.dismiss()
        })
        .navigationBarItems(trailing: Button("Skip"){
            print("Skip button pressed")
        })
    }
    
    func submitValidCheck() {
        if !nameCorrect {
            fNameErrorTxt = "Enter Name"
        }
        if !passCorrect {
            passwordDescTxt = "Invalid Password"
        }
        if !rePassCorrect {
            passwordMismatchTxt = "Password mismatch"
        }
    }
    
    func checkValidations() {
        if nameCorrect && passCorrect && rePassCorrect {
            continueBtnDisabled = false
            contBtnOpacity = 1.0
        }else {
            continueBtnDisabled = true
        }
    }
}

class PasswordValidator {
    static func getIsPasswordValid(_ password: String, _ validRules: [PasswordRule])->Bool{
        
        let failedRules = getFailedRules(password, validRules)
        return failedRules.count > 0 ? false : true
    }
    
    static func getFailedRules(_ password: String, _ validRules: [PasswordRule])->[PasswordRule]{
        
        var failedRules = [PasswordRule]()
        
        for validRule in validRules{
            switch validRule {
            case .lengthOfCharacters:
                if !containsAtLeast8Characters(input: password){
                    failedRules.append(.lengthOfCharacters)
                }
            case .capitalLetter:
                if !containsCapitalLetter(input: password){
                    failedRules.append(.capitalLetter)
                }
                
            case .specialCharacterOrNumber:
                if !containsSpecialCharacterOrNumber(input: password){
                    failedRules.append(.specialCharacterOrNumber)
                }
            }
        }
        return failedRules
    }
    
    static func containsNumber(input: String)-> Bool{
        return input.rangeOfCharacter(from: CharacterSet.decimalDigits) != nil
    }
    static func containsCapitalLetter(input: String)->Bool{
        return input.rangeOfCharacter(from: CharacterSet.uppercaseLetters) != nil
    }
    static func containsAtLeast8Characters(input: String)-> Bool{
        return input.count >= 8
    }
    static func containsSpecialCharacter(input : String)-> Bool{
        return input.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*(),.?\":{}|<>")) != nil
    }
    static func containsSpecialCharacterOrNumber(input: String) -> Bool{
        return containsSpecialCharacter(input: input) || containsNumber(input: input)
    }
    static func getPasswordStrengthColor(passwordStrength: Int, viewIndex: Int) -> Color {
       switch passwordStrength {
        case 2:
            if viewIndex == 0 {
                return Color(red: 255/255, green: 124/255, blue: 16/255)
            } else {
                return Color(red: 255/255, green: 124/255, blue: 16/255, opacity: 0.5)
            }
        case 1:
            if viewIndex == 0 || viewIndex == 1 {
                return Color(red: 218/255, green: 165/255, blue: 32/255)
            } else {
                return Color(red: 218/255, green: 165/255, blue: 32/255, opacity: 0.5)
            }
        case 0:
            return Color(red: 13/255, green: 170/255, blue: 0/255)
       default:
           return Color.gray
        }
    }
}

enum PasswordRule: Int, CaseIterable{
    case lengthOfCharacters
    case specialCharacterOrNumber
    case capitalLetter
}

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
