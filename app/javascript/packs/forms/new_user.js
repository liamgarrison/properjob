const userTypeCards = document.querySelectorAll('.user-type-card');
const userTypeField = document.querySelector('#user_user_type');
const contractorTypeField = document.querySelector('#user_contractor_type');
const contractorTypeInputSection = document.querySelector('.singup-contractor-type');
const contractorTypeCards = document.querySelectorAll('.contractor-type-card');

const onUserCardClick = (event) => {
  // Grab the current active card
  const activeCard = document.querySelector('.user-type-card.active');
  userTypeField.value = activeCard.dataset.value;

  // Show the contractor type buttons if contractor was picked
  if (event.currentTarget.dataset.value === 'contractor') {
    contractorTypeInputSection.classList.remove('d-none');
    
  } else {
    contractorTypeInputSection.classList.add('d-none');
    contractorTypeField.value = ''
    contractorTypeCards.forEach((card) => card.classList.remove('active'))
  }
}

const onContractorCardClick = (event) => {
  const activeCard = document.querySelector('.contractor-type-card.active');
  contractorTypeField.value = activeCard.dataset.value;
}

const newUser = () => {
  if (userTypeCards && userTypeField) {
    userTypeCards.forEach((card) => {
      card.addEventListener('click', onUserCardClick)
    })
  }
  if (contractorTypeCards && contractorTypeField) {
    contractorTypeCards.forEach((card) => {
      card.addEventListener('click', onContractorCardClick)
    })
  }
}

export { newUser };