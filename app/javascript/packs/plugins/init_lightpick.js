import Lightpick from 'lightpick'

const initLightpick = () => {
  const timeSelectors = document.getElementById('time_selectors');
  const parentEl = document.querySelector('.popover-datepicker');

  if (parentEl && timeSelectors) {
    const contractorDates = JSON.parse(parentEl.dataset.contractorDates).map((date) => new Date(date))
    const daysToShow = 90
    const disableDates = []

    let placeholderDate = new Date()
    for (let i = 1; i <= daysToShow; i++) {
      let isDisabled = true;
      contractorDates.forEach((contractorDate) => {
        if (contractorDate.toDateString() === placeholderDate.toDateString()) {
          isDisabled = false;
        }
      })
      if (isDisabled) {
        disableDates.push(new Date(placeholderDate))
      }
      // Increment the date
      placeholderDate.setDate(placeholderDate.getDate() + 1)
    }

    const picker = new Lightpick({
      field: timeSelectors,
      singleDate: true,
      inline:true,
      disableDates: disableDates,
      maxDate: placeholderDate.setDate(placeholderDate.getDate() - 1),
      minDate: new Date(),
      parentEl: '.popover-datepicker'
    });
  }
};


export { initLightpick }
