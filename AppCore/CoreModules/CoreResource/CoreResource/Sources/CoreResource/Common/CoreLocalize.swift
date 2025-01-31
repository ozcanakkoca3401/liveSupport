//
//  CoreLocalize.swift
//  
//
//  Created by Ozcan Akkoca on 7.01.2024.
//

import Foundation

public struct CoreLocalize {
    public struct General {
        public static var Info: String {
            return NSLocalizedString("general_info", bundle: .module, comment: "General")
        }
        
        public static var Error: String {
            return NSLocalizedString("general_error", bundle: .module, comment: "General")
        }
        
        public static var ErrorTitle: String {
            return NSLocalizedString("general_error_title", bundle: .module, comment: "General")
        }
        
        public static var OkButton: String {
            return NSLocalizedString("general_ok_button", bundle: .module, comment: "General")
        }
        
        public static var ExitButton: String {
            return NSLocalizedString("general_exit_button", bundle: .module, comment: "General")
        }
        
        public static var YesButton: String {
            return NSLocalizedString("general_yes_button", bundle: .module, comment: "General")
        }
        
        public static var NoButton: String {
            return NSLocalizedString("general_no_button", bundle: .module, comment: "General")
        }
        
        public static var AssistantExitConfirmation: String {
            return NSLocalizedString("general_assistant_exit_confirmation", bundle: .module, comment: "General")
        }
    }
    
    public struct LiveSupport {
        public static var Title: String { return NSLocalizedString("live_support_title", bundle: .module, comment: "LiveSupport") }
        public static var OrderNumber: String { return NSLocalizedString("live_support_order_number", bundle: .module, comment: "LiveSupport") }
        public static var Date: String { return NSLocalizedString("live_support_date", bundle: .module, comment: "LiveSupport") }
        public static var Select: String { return NSLocalizedString("live_support_select", bundle: .module, comment: "LiveSupport") }
    }
}
