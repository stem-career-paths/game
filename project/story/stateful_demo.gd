extends RefCounted

var _count := 0

func run(presenter)->void:
	while _count < 2:
		presenter.show_text("You have chosen %d options"% _count)
		await presenter.show_options(["Choose Something"])
		_count += 1
	
	presenter.show_text("You have chosen enough. Go home.")
	await presenter.show_confirmation()
	print("Sample story complete.")
