// Basic function for toggling active class on and off selection cards
const cardSelection = () => {
  const cards = document.querySelectorAll('.card-selection');
  if (cards) {
    cards.forEach((card) => {
      card.addEventListener('click', (event) => {
        event.currentTarget.classList.toggle('active');
      })
    })
  }
}

export default cardSelection;