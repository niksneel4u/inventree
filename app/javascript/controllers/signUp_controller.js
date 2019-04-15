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
    };

    var errorMessages = {
      'company[name]': 'Place Enter Company Name',
      'company[contact_person_name]': 'Place Enter Contact Person Name',
      'company[email]': {
        required: 'Place Enter E-Mail',
        email: true
      },
      'user[first_name]': 'Place Enter First Name',
      'user[last_name]': 'Place Enter First Name',
      'company[contact_person_number]': {
        required: 'Place Enter Phone Numbe',
        digits: 'Please enter only digits.',
        minlength: 'Place Enter valid number',
        maxlength: 'Place Enter valid number'
      },
      'user[password]': {
        required: "Password required",
        minlength: "Enter minimum 6 characters",
        maxlength: "Password should not grater than 15 characters"
      }
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#signUp');
  }
}
