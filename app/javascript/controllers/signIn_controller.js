
import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var addressRules = {
      'user[phone_number]': {
        required: true,
        digits: true,
        minlength: 10,
        maxlength: 10
    },
      'user[password]': {
        required: true,
        minlength: 6,
        maxlength: 15
      },
    };

    var errorMessages = {
      'user[phone_number]': {
        minlength: 'Place enter valid number',
        maxlength: 'Place enter valid number'
      },
      'user[password]': {
        required: "Password required",
        minlength: "Enter minimum 6 characters",
        maxlength: "Password should not grater than 15 characters"
      }
    };
    Inventree.form.validate_form(addressRules, errorMessages, '#form');
  }
}
