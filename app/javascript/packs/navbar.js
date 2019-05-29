const initNavbar = () => {
  const navbarToggler = document.getElementById('navbarToggler')
  const navbarDropdown = document.getElementById('navbarDropdown')
  const closeButton = document.getElementById('closeButton')

  const showDropdown = (event) => {
    navbarDropdown.style.display = "block"
  }

  const hideDropdown = (event) => {
    navbarDropdown.style.display = "none"
  }

  navbarToggler.addEventListener("click", showDropdown);
  closeButton.addEventListener("click", hideDropdown);
}

export { initNavbar }
