let closeButton = document.querySelector(".close-button");
let flashPanel = document.querySelector(".flash");
let signUpButton = document.getElementById("signUpButton");

signUpButton.addEventListener("click", function(event){
    
    var first_name = document.forms["sign_up"]["first_name"].value;
    var last_name = document.forms["sign_up"]["last_name"].value;
    var username = document.forms["sign_up"]["username"].value;
    var password = document.forms["sign_up"]["password"].value;
    var email = document.forms["sign_up"]["email"].value;
    if (first_name === "" || last_name === "" || username === "" || password === "" || email === "") {
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

