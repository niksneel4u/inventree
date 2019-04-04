import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var signUpRules = {
      'marketplace[name]': requiredRule,
      'marketplace[website_url]': {
        required: true,
        url: true
      }

    };

    var errorMessages = {
      'marketplace[name]': 'Place Enter Marketplace Name',
      'marketplace[website_url]':{
        required: 'place enter URL'
      } 
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#marketplace');
  }
}
