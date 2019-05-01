import { Controller } from "stimulus"

export default class extends Controller {
  connect() {
    var requiredRule = {
      required: true
    };

    var marketplaceRules = {
      'marketplace[name]': requiredRule,
      'marketplace[website_url]': {
        required: true,
        url: true
      },
      'marketplace[image_xpath]': requiredRule
    };

    var errorMessages = {
      'marketplace[name]': 'Please Enter Marketplace Name',
      'marketplace[website_url]':{
        required: 'Please enter URL'
      },
      'marketplace[image_xpath]': 'Please Enter Image path for Marketplace'
    };
    Inventree.form.validate_form(marketplaceRules, errorMessages, '#marketplace');
  }
}
