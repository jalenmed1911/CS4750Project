//used by CreatePlayer.php

//Gets the dropdown position selector from createPlayer.php
const positionSelect = document.getElementById('PositionSelector');

//Gets the container of all the position stats from createPlayer.php
const positionStats = document.getElementById('positionStats');


function showView(viewId) {
    //Lists all the div elements in the parent stats container that have id attributes
    const groups = positionStats.querySelectorAll('div[id]');

    //For each element in the groups list...
    groups.forEach(group => {
        //hide all of them
        group.classList.add('hidden');
        //make sure the inputs are all disabled and not required initially (default state)
        group.querySelectorAll('input').forEach(input => {
            input.required = false;
            input.disabled = true;
        });
    });

    //selectedGroup: Gets the element that is supposed to be shown/filled out
    const selectedGroup = document.getElementById(viewId);
    //if exists... (safe coding)
    if (selectedGroup) {
        //unhide it
        selectedGroup.classList.remove('hidden');
        //require the user to fill out their stats
        selectedGroup.querySelectorAll('input').forEach(input => {
            input.required = true;
            input.disabled = false;
        });
    }
}

//Calls the showView function when user changes the position part of the form in createPlayer.php
positionSelect.addEventListener('change', function() {
    showView(positionSelect.value);
});