let closeButton = document.querySelector(".close-button");
let flashPanel = document.querySelector(".flash");
let signUpButton2 = document.getElementById("signUpButton2");

signUpButton2.addEventListener("click", function(event){
    
    var first_name = document.forms["sign_up"]["first_name"].value;
    var last_name = document.forms["sign_up"]["last_name"].value;
    var username = document.forms["sign_up"]["username"].value;
    var password = document.forms["sign_up"]["password"].value;
    var email = document.forms["sign_up"]["email"].value;
    console.log(email.includes("."))
    if (first_name === "" || last_name === "" || username === "" || password === "" || email === ""|| email.includes(".") === false) {
        console.log(email.includes("."))
        event.preventDefault();
        alert("All fields must be filled correctly");
        console.log("NONONO")
        return false;
        
    }

});
    

closeButton.addEventListener("click", event => {
  event.preventDefault()

  flashPanel.classList.add("hide")
})

