chart = require 'chart.js'

graphPentagon = (categories, bpas) ->
    ctx = document.querySelector('.pentagon').getContext('2d')
    pentagon = new Chart(ctx, 
        type: 'radar',
        data: 
            labels: categories,
            datasets: [
                label: 'Team BPA/Rd'
                data: bpas
            ]
        options: 
            scale:
                ticks:
                    min: 0,
                    max: 10,
                    stepSize: 5
    )

window.loadBpaData = () ->
    categories = (cat.name for cat in window.teamBpas when cat.level == 1 && cat.t_countRooms >= 25)
    bpas = ((20 * cat.bpa / cat.t_countRooms) for cat in window.teamBpas when cat.level == 1 && cat.t_countRooms >= 25)
    graphPentagon(categories, bpas)