extends RefCounted

var _count := 0

func run(presenter)->void:
	while _count < 2:
		presenter.show_text("You have chosen %d options"% _count)
		var _options := [
			"Choose Something",
			"Choose Something Else",
		]

		var _choice = _options.find(await presenter.show_options(_options))
		_count += 1
		
		match _choice:
			0:
				presenter.show_effects({
					"mathematics": _count,
				})
			1:
				presenter.show_effects({
					"resilience": _count,
				})

	presenter.show_text("You have chosen enough. Go home.")
	await presenter.finish()
