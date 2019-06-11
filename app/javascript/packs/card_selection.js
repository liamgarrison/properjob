// Basic function for toggling active class on and off selection cards
const cardSelectionWrappers = document.querySelectorAll('.card-selection-wrapper');

const processWrapper = (wrapper) => {
  const cards = wrapper.querySelectorAll('.card-selection')
  if (cards) {
    const singleToggle = wrapper.dataset.singleToggle === 'true'; // Grab whether it's single or multiple selection from the first card dataset
    cards.forEach((card) => {
      card.addEventListener('click', (event) => {
        if (singleToggle) {
          cards.forEach((card) => {
            card.classList.remove('active');
          })
        }
        event.currentTarget.classList.toggle('active');
      })
    })
  }
}

const cardSelection = () => {
  if (cardSelectionWrappers) {
    cardSelectionWrappers.forEach(processWrapper)
  }
}

export default cardSelection;