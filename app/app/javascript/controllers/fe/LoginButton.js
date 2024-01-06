import { Controller } from '@hotwired/stimulus';
import LoginController from './LoginController';

export default class LoginButtonController extends Controller {
  connect() {
    const loginButton = this.element;
    loginButton.addEventListener('click', () => {
      LoginController.handleSubmitForm();
    });
  }
}