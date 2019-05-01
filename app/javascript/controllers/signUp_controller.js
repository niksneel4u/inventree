import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var signUpRules = {
      'company[name]': requiredRule,
      'company[contact_person_name]': requiredRule,
      'company[email]': {
        required: requiredRule,
        email: true
      },
      'user[first_name]': requiredRule,
      'user[last_name]': requiredRule,
      'company[contact_person_number]': {
        required: requiredRule,
        digits: true,
        minlength: 10,
        maxlength: 10
      },
      'user[password]': {
        required: requiredRule,
        minlength: 6,
        maxlength: 15
      },
      'user[password_confirmation]': {
        required: requiredRule,
        minlength: 6,
        maxlength: 15,
        equalTo: "#user_password"
      }
      // 'company[terms_and_conditions]' : requiredRule
    };

    var errorMessages = {
      'company[name]': 'Please Enter Company Name',
      'company[contact_person_name]': 'Please Enter Contact Person Name',
      'company[email]': {
        required: 'Please Enter E-Mail',
        email: 'Enter Valid E-Mail Address'
      },
      'user[first_name]': 'Please Enter First Name',
      'user[last_name]': 'Please Enter First Name',
      'company[contact_person_number]': {
        required: 'Please Enter Phone Numbe',
        digits: 'Please enter only digits.',
        minlength: 'Please Enter valid number',
        maxlength: 'Please Enter valid number'
      },
      'user[password]': {
        required: "Password required",
        minlength: "Enter minimum 6 characters",
        maxlength: "Password should not grater than 15 characters"
      },
      'user[password_confirmation]': {
        equalTo: "Password and Confirm Password do not match"
      }
      // 'company[terms_and_conditions]' : "Please accept terms and condition"
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#signUp');
  }
}
