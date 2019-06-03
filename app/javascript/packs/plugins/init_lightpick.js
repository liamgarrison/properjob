import Lightpick from 'lightpick'

const initLightpick = () => {
  const timeSelectors = document.getElementById('time_selectors');
  const parentEl = document.querySelector('.popover-datepicker');
  const contractorDates = JSON.parse(parentEl.dataset.contractorDates).map((date) => new Date(date))

  const daysToShow = 91
  const disableDates = []

  let placeholderDate = new Date()
  for (let i = 1; i <= daysToShow; i++) {
    let isDisabled = true;
    contractorDates.forEach((contractorDate) => {
      console.log(contractorDate, placeholderDate)
      if (contractorDate.toDateString() === placeholderDate.toDateString()) {
        isDisabled = false;
        console.log('enabling date')
      }
    })
    if (isDisabled) {
      disableDates.push(new Date(placeholderDate))
    }
    // Increment the date
    placeholderDate.setDate(placeholderDate.getDate() + 1)
  }

  if (parentEl && timeSelectors) {
    const picker = new Lightpick({
      field: timeSelectors,
      singleDate: true,
      inline:true,
      disableDates: disableDates,
      maxDate: placeholderDate,
      minDate: new Date(),
      parentEl: '.popover-datepicker'
    });
  }
};


export { initLightpick }
