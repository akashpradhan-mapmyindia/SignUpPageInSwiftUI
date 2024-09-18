
import SwiftUI

@available(iOS 13.0, *)
struct SignUpView: View {
    
    @State var emailId: String
    @State var fullName: String = ""
    @State var password: String = ""
    @State var isPasswordVisible2: Bool = false
    @State var isPasswordVisible1: Bool = false
    @State var reenterPassword: String = ""
    @State var continueBtnEnabled: Bool = false
    @State var emailDisabled: Bool = true
    @State var fNameFloatingOpacity: Double = 0.0
    @State var fNameRightIcon: String = ""
    @State var contBtnOpacity: Double = 0.5
    @State var signUpError: String = ""
    @State var passwordMismatchTxt: String = ""
    @State var passwordDescTxt: String = ""
    @State var passStrength: String = ""
    @State var check1: String = "login-uncheck"
    @State var check2: String = "login-uncheck"
    @State var check3: String = "login-uncheck"
    @State var passFloatingOpacity: Double = 0.0
    @State var reenterPassFloatingOpacity: Double = 0.0
    @State var submitBtnClicked: () -> Void = {}
    @State var passTextInField: String = "Password"
    @State var fNamePlaceholder: String = "Full Name"
    @State var reEnterPassPlaceholder: String = "Re-enter Password"
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
                        
                        Text(signUpError)
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
                                .foregroundColor(.gray)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(.gray)
                                .cornerRadius(10)
                            
                            Rectangle()
                                .frame(height: 6)
                                .foregroundColor(.gray)
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
                        
                        Text(passwordMismatchTxt)
                            .font(.system(size: 15))
                            .foregroundColor(Color(red: 224/255, green: 48/255, blue: 33/255))
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding([.top], 20)
                    
                    Button("Continue") {
                        submitBtnClicked()
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 44)
                    .background(Color.green)
                    .cornerRadius(5)
                    .foregroundColor(.white)
                    .padding([.top], 20)
                    .disabled(continueBtnEnabled)
                    .opacity(contBtnOpacity)
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
}

