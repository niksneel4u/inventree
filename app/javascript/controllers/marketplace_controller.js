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
      },
      'marketplace[image_xpath]': requiredRule
    };

    var errorMessages = {
      'marketplace[name]': 'Place Enter Marketplace Name',
      'marketplace[website_url]':{
        required: 'place enter URL'
      },
      'marketplace[image_xpath]': 'Place Enter Image path for Marketplace'
    };
    Inventree.form.validate_form(signUpRules, errorMessages, '#marketplace');
  }
}
