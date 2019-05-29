const initNavbar = () => {
  const navbarToggler = document.getElementById('navbarToggler')
  const navbarDropdown = document.getElementById('navbarDropdown')

  const showDropdown = (event) => {
    console.log('clicked')
  console.log(navbarDropdown)
  navbarDropdown.style.display = "block"
  }

  navbarToggler.addEventListener("click", showDropdown);
}

export { initNavbar }
