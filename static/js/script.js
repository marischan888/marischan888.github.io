var mainNav = document.getElementById("js-menu")
var navBarToggle = document.getElementById("js-navbar-toggle")
var imageContainers = [...document.getElementsByClassName("image")]
var projectsNav = document.getElementById("js-navbar-projects-toggle")
var projectsDropdown = document.getElementById("js-projects-menu")

/**
 * image caption on click for mobile and image modal for click on medium to large devices
 */
imageContainers.forEach(imageContainer => {
    imageContainer.addEventListener("click", function () {
        // on medium to large devices, show image modal on click
        if (window.matchMedia("(min-width: 768px)").matches) {
            document.getElementById("imageModal").style.display = "grid"
            document.getElementById("imageModalImage").src = imageContainer.getElementsByTagName("p")[0].getElementsByTagName("img")[0].src.replace(".jpg", "_large.jpg")
            document.getElementById("imageModalCaption").innerHTML = imageContainer.getElementsByClassName("caption")[0].getElementsByTagName("p")[0].innerHTML
        }
    })
})

/**
 * close modal on escape
 */
document.addEventListener('keyup', function (event) {
    if (event.key === 'Escape') {
        document.getElementById("imageModal").style.display = "none"
    }
});

/**
 * navigation toggle for mobile
 */
navBarToggle.addEventListener("click", function () {
    mainNav.classList.toggle("active")
    navBarToggle.children[0].classList.toggle("fa-bars")
    navBarToggle.children[0].classList.toggle("fa-times")
})