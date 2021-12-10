//
//  BaseTextField.swift
//  PracticalSwiftUI
//
//  Created by Lysimachos Giatrakis on 10/12/21.
//

import SwiftUI
import Combine

struct BaseTextField: View {
    
    var placeHolder: String
    var keyboardType: UIKeyboardType = .default
    var textLimit: Int? = nil
    var safetyCheck: SafetyCheck? = nil
    var disabled: Bool = false
    
    @Binding var viewAlert: BaseAlert
    @Binding var bindedText: String
    
    enum SafetyCheck: String {
        // Just a random check in order to add some logic
        case MoreThanOneCharacter = "Please insert more than one Character"
    }
    
    init(placeHolder: String,
         keyboardType: UIKeyboardType = .default,
         textLimit: Int? = nil,
         safetyCheck: SafetyCheck? = nil,
         disabled: Bool = false,
         viewAlert: Binding<BaseAlert> = .constant(BaseAlert()),
         bindedText: Binding<String>) {
        self.placeHolder = placeHolder
        self.keyboardType = keyboardType
        self.textLimit = textLimit
        self.safetyCheck = safetyCheck
        self.disabled = disabled
        self._viewAlert = viewAlert
        self._bindedText = bindedText
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            TextField(placeHolder, text: $bindedText, onEditingChanged: { changed in
                guard let safetyCheck = safetyCheck else { return }
                /// Closure receives a Boolean value that indicates the editing status: true when the user begins editing, false  when they finish.
                if !changed {
                    validateLength(safetyCheck)
                }
            })
            .keyboardType(keyboardType)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding(.bottom, 10)
            .disabled(disabled)
            .onReceive(Just(bindedText)) { _ in
                if let textLimit = self.textLimit {
                    limitText(textLimit)
                }
            }
        }
    }
    
}

// Helper Funcs
extension BaseTextField {
    func limitText(_ upper: Int) {
        if bindedText.count > upper {
            bindedText = String(bindedText.prefix(upper))
        }
    }
    
    func validateLength(_ safetyCheck: SafetyCheck) {
        switch safetyCheck {
        case .MoreThanOneCharacter:
            if bindedText.count < 2 {
                self.viewAlert.setActive(message: SafetyCheck.MoreThanOneCharacter.rawValue)
            }
        }
    }
}

struct BaseTextField_Previews: PreviewProvider {
    static var previews: some View {
        let showText = "Some notes"
        BaseTextField(placeHolder: showText, bindedText: .constant(showText))
    }
}

