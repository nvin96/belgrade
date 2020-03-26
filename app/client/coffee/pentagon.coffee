chart = require 'chart.js'

graphPentagon = (team_cats, team_bpas, player_bpas) ->
    ctx = document.querySelector('.pentagon').getContext('2d')
    teamPentagon = new Chart(ctx, 
        type: 'radar',
        data: 
            labels: team_cats,
            datasets: [
                label: 'Team BPA/Rd'
                data: team_bpas
            ]
        options: 
            animation:
                duration: 0
            scale:
                ticks:
                    min: 0,
                    max: 10,
                    stepSize: 5
    )
    setRowHandlers(teamPentagon, player_bpas)

setRowHandlers = (pentagon, player_bpas) ->
    document.querySelectorAll('.players tr').forEach (el) ->
        el.addEventListener 'mouseover', (e) -> 
            e.currentTarget.classList.add 'hover'
            bpasAdd = (bpa.bpa_rd for bpa in player_bpas when (bpa != undefined && e.currentTarget.id == bpa.name))
            pentagon.data.datasets.push
                label: "#{e.currentTarget.id}'s BPA/Rd"
                data: bpasAdd
            pentagon.update()
        el.addEventListener 'mouseout', (e) -> 
            e.currentTarget.classList.remove 'hover'
            pentagon.data.datasets.pop()
            pentagon.update()

window.loadBpaData = () ->
    team_categories = (cat.name for cat in window.teamBpas when cat.level == 1 && cat.t_countRooms >= 25)
    team_bpas = ((20 * cat.bpa / cat.t_countRooms) for cat in window.teamBpas when cat.level == 1 && cat.t_countRooms >= 25)
    player_bpas = window.playerBpas.map (cat) ->
        if cat.count_t_heard >= 25
            name: cat.player_name
            category: cat.category
            bpa_rd: 20 * cat.bpa / cat.count_t_heard
    graphPentagon(team_categories, team_bpas, player_bpas)