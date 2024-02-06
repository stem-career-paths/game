extends HBoxContainer

var world: World:
	set(value):
		if world != null:
			if world != value:
				world.years_changed.disconnect(_year_progressed)

		world = value
		world.years_changed.connect(_year_progressed)
		_update_display(world.year)

@onready var _year_name: Label = %YearName
@onready var _year_circles := {
	Year.Name.FRESHMAN: %Year1,
	Year.Name.SOPHOMORE: %Year2,
	Year.Name.JUNIOR: %Year3,
	Year.Name.SENIOR: %Year4,
}
@onready var _particles: CPUParticles2D = %Particles


func _year_progressed(years: int) -> void:
	_particles.emitting = true
	_update_display(years)

func _update_display(new_year: Year.Name) -> void:
	_year_circles[new_year].year_passed = true
	_year_name.text = Year.as_string(new_year)
