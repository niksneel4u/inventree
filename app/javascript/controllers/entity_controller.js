import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var signUpRules = {
      'entity[name]': requiredRule
    };

    var errorMessages = {
      'entity[name]': 'Place Enter Entity Name'
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#entity');
  }
}
