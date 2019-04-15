import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var signUpRules = {
      'receiver_email[name]': requiredRule,
      'receiver_email[email]': {
        required: true,
        email: true
      }

    };

    var errorMessages = {
      'receiver_email[name]': 'Place Enter Name',
      'receiver_email[email]': {
        required: 'place enter E-Mail'
      }
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#receiver_mail');
  }
}
