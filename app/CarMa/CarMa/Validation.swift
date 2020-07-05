//
//  Validation.swift
//  CarMa
//
//  Created by Tianze Huang on 2/13/20.
//  Copyright © 2020 Dianprakasa, Arif. All rights reserved.
//

import Foundation
class Validation {
   public func validatefirst_name(first_name: String) ->Bool {
      // Length be 18 characters max and 3 characters minimum, you can always modify.
      let first_nameRegex = "^\\w{3,18}$"
      let trimmedString = first_name.trimmingCharacters(in: .whitespaces)
      let validatefirst_name = NSPredicate(format: "SELF MATCHES %@", first_nameRegex)
      let isValidatefirst_name = validatefirst_name.evaluate(with: trimmedString)
      return isValidatefirst_name
   }
   public func validatelast_name(last_name: String) ->Bool {
      // Length be 18 characters max and 3 characters minimum, you can always modify.
      let last_nameRegex = "^\\w{3,18}$"
      let trimmedString = last_name.trimmingCharacters(in: .whitespaces)
      let validatelast_name = NSPredicate(format: "SELF MATCHES %@", last_nameRegex)
      let isValidatelast_name = validatelast_name.evaluate(with: trimmedString)
      return isValidatelast_name
   }
   public func validatephone(phone: String) -> Bool {
      let phoneRegex = "^[0-9]{10}$"
      let trimmedString = phone.trimmingCharacters(in: .whitespaces)
      let validatephone = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
      let isValidphone = validatephone.evaluate(with: trimmedString)
      return isValidphone
   }
   public func validateemail(email: String) -> Bool {
      let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
      let trimmedString = email.trimmingCharacters(in: .whitespaces)
      let validateemail = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
      let isValidateemail = validateemail.evaluate(with: trimmedString)
      return isValidateemail
   }

   public func validateAnyOtherTextField(otherField: String) -> Bool {
      let otherRegexString = "Your regex String"
      let trimmedString = otherField.trimmingCharacters(in: .whitespaces)
      let validateOtherString = NSPredicate(format: "SELF MATCHES %@", otherRegexString)
      let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
      return isValidateOtherString
   }
}
