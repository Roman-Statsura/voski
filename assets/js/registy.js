let steps = document.querySelectorAll(".login-steps-content__step");

steps.forEach(element => {
    element.addEventListener("click", function () {
        console.log(document.querySelector(".form_current[data-id='" + this.dataset.id + "']"));
    });
});