const showContentToggle = () => {
  const showContentTogglers = document.querySelectorAll('[data-show-toggler]');
  const showContent = document.querySelectorAll('[data-show-content]')

  if (showContentTogglers && showContent) {
    showContentTogglers.forEach((toggler) => {
      toggler.querySelector('i')
      toggler.addEventListener("click", (event) => {
        const stageToToggle = toggler.getAttribute('data-show-toggler');
        const contentToShow = document.querySelector(`[data-show-content="${stageToToggle}"]`)
        contentToShow.classList.toggle('show-visible')
        toggler.querySelector('i').classList.toggle('fa-chevron-down')
        toggler.querySelector('i').classList.toggle('fa-chevron-up')
      })
    })
  }
}

export { showContentToggle }
