function initializeFunctions() 
{
  const form = document.querySelector('.adventure form'); // Select the form element
  console.log(form);

  form.addEventListener('submit', function(event) {
    console.log("submission!");
    const dateInput = form.querySelector('#adventure_date');
    const minLevelInput = form.querySelector('#adventure_min_level');
    const maxLevelInput = form.querySelector('#adventure_max_level');

    // Parse inputs to appropriate data types
    const selectedDate = new Date(dateInput.value);
    console.log("selectedDate: " + selectedDate);
    const minLevel = parseInt(minLevelInput.value, 10);
    const maxLevel = parseInt(maxLevelInput.value, 10);

    // Perform validations
    if (selectedDate < new Date()) {
      alert('Date cannot be in the past!');
      event.preventDefault(); // Prevent form submission
    }

    if (minLevel < 0 || minLevel > 98 || maxLevel < 1 || maxLevel > 99 || minLevel > maxLevel) {
      alert('Level constraints not met!');
      event.preventDefault();
    }
  });
}

initializeFunctions();
document.addEventListener('turbo:render', function() { initializeFunctions(); });