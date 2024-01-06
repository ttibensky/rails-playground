import { Controller } from "@hotwired/stimulus";

export default class LoginController extends Controller {
  submitForm() {
    const formData = new FormData(this.element.querySelector("form"));

    fetch("/login", {
      method: "POST",
      body: formData,
    })
      .then((response) => response.json())
      .then((data) => {
        if (data.success) {
          console.log("success!");
        } else {
          console.log("sum tin wong!");
        }
      });
  }
}
