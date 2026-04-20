const positionSelect = document.getElementById('PositionSelector');
const positionStats = document.getElementById('positionStats');


function showView(viewId) {
    const groups = positionStats.querySelectorAll('div[id]');
    groups.forEach(group => {
        group.classList.add('hidden');
        group.querySelectorAll('input').forEach(input => {
            input.required = false;
            input.disabled = true;
        });
    });

    const selectedGroup = document.getElementById(viewId);
    if (selectedGroup) {
        selectedGroup.classList.remove('hidden');
        selectedGroup.querySelectorAll('input').forEach(input => {
            input.required = true;
            input.disabled = false;
        });
    }
}

positionSelect.addEventListener('change', function() {
    showView(positionSelect.value);
});